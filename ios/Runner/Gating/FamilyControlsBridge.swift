import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity
import UserNotifications

/// Debug-only logging — compiled out of release builds.
private func gateLog(_ message: @autoclosure () -> String) {
    #if DEBUG
    print(message())
    #endif
}

/// Bridges Flutter method channel calls to iOS FamilyControls/ManagedSettings APIs.
///
/// Re-lock design — "five layers, one source of truth":
/// the single source of truth for an active unlock is `unlock_until` (epoch seconds)
/// in the App Group. `enforceLockState()` is idempotent: it re-applies the stored
/// selection whenever no valid unlock exists, and never removes shields. Layers:
///  1. DeviceActivityEvent usage threshold (= unlock length) — precise, works < 15 min
///  2. One-shot DeviceActivitySchedule backstop (padded to Apple's ~15-min minimum,
///     full date components so midnight-crossing unlocks are valid)
///  3. Foreground/clock-change enforcement (didBecomeActive + significantTimeChange)
///  4. Local "time's up" notification at the exact unlock expiry
///  5. Daily repeating watchdog schedule that heals anything missed
///
/// Cross-process rule: expiry paths never DELETE `unlock_until` (an expired value is
/// inert — every reader checks `now < until`). Deleting on expiry in the extension
/// would race a concurrent fresh grant in this process and destroy it. Only explicit
/// user paths (grant, revoke, selection change, stop gating) remove the key, and they
/// all run on this process's main thread, so they can't race each other.
///
/// IMPORTANT: The FamilyControls Distribution Entitlement must be approved by Apple.
@available(iOS 16.0, *)
class FamilyControlsBridge: NSObject {

    static let shared = FamilyControlsBridge()

    private let store = ManagedSettingsStore()
    private let center = DeviceActivityCenter()

    // Storage keys. The App Group container is shared with the Shield and
    // DeviceActivityMonitor extensions — the monitor extension reads
    // `gate_selection` / `unlock_until` with the same semantics as this class.
    private let selectionStorageKey = "gate_selection"
    private let legacyTokenStorageKey = "shielded_app_tokens"
    private let unlockUntilKey = "unlock_until"
    private let lastRelockAtKey = "last_relock_at"
    private let lastRelockReasonKey = "last_relock_reason"
    private let localeCodeKey = "locale_code"
    private let expiryNotificationId = "niyyah_unlock_expiry"
    private let watchdogActivityName = "niyyah_watchdog"
    private let unlockActivityPrefix = "unlock_"

    private let sharedDefaults = UserDefaults(suiteName: "group.com.ayaunlock.shared")

    /// Selection persistence falls back to standard defaults when the App Group
    /// container is unavailable (entitlement/signing regression) so relaunch
    /// re-shielding in the main app still works instead of failing open.
    private var storageDefaults: UserDefaults { sharedDefaults ?? .standard }

    /// The full gated selection (apps + categories + web domains) as picked by
    /// the user — the ONLY in-memory representation. Restoring just app tokens
    /// silently dropped category shields after the first unlock (fixed here).
    private var gateSelection: FamilyActivitySelection?

    /// Debounce for enforceLockState's steady-state branch: true while we know
    /// the ManagedSettingsStore already holds the stored selection, so every
    /// foreground/status-check doesn't rewrite identical settings via XPC.
    private var shieldsKnownApplied = false

    /// Foreground exact-expiry timer for the current grant (cancellable so
    /// revoked/superseded unlocks don't leave stale timers queued).
    private var foregroundRelockTimer: DispatchWorkItem?

    override init() {
        super.init()
        loadStoredSelection()
        migrateLegacyReshieldAt()
        enforceLockState(reason: "launch")
    }

    /// Check if FamilyControls authorization has been granted
    var hasAuthorization: Bool {
        return AuthorizationCenter.shared.authorizationStatus == .approved
    }

    /// Request FamilyControls authorization from the user
    func requestAuthorization() async -> Bool {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            return AuthorizationCenter.shared.authorizationStatus == .approved
        } catch {
            gateLog("FamilyControlsBridge: Authorization failed: \(error)")
            return false
        }
    }

    /// Whether anything is selected for gating.
    private var hasStoredSelection: Bool {
        guard let sel = gateSelection else { return false }
        return !(sel.applicationTokens.isEmpty && sel.categoryTokens.isEmpty
            && sel.webDomainTokens.isEmpty)
    }

    /// Epoch seconds the current unlock expires at, or nil when no valid unlock.
    var currentUnlockUntil: Double? {
        guard let until = sharedDefaults?.object(forKey: unlockUntilKey) as? Double,
              Date().timeIntervalSince1970 < until else {
            return nil
        }
        return until
    }

    /// Apply shields from the FamilyActivitySelection (apps, categories, web domains).
    func applySelectionShields(selection: FamilyActivitySelection) {
        let isEmpty = selection.applicationTokens.isEmpty
            && selection.categoryTokens.isEmpty
            && selection.webDomainTokens.isEmpty
        if isEmpty {
            // The picker always opens empty and "Done" with nothing checked is
            // the only user-reachable un-gate path — treat it as stop gating.
            // (Persisting an empty selection while shields stay applied would
            // strand the user locked with no layer able to ever re-shield.)
            clearAllShieldsAndData()
            return
        }

        // Editing the selection ends any active unlock: the new choice takes
        // effect immediately, and unlock state stays consistent with the UI.
        cancelUnlockArtifacts()
        gateSelection = selection
        saveSelectionToStorage()
        applyStoredShields()
        // Arm the watchdog right away — the Dart side only calls startGating on
        // the next launch, and the first gating session deserves layer 5 too.
        startWatchdog()
        gateLog("FamilyControlsBridge: Applied shields — \(selection.applicationTokens.count) apps, \(selection.categoryTokens.count) categories, \(selection.webDomainTokens.count) web domains")
    }

    /// Push the stored selection into the ManagedSettingsStore. Never clears
    /// anything: with an empty selection this is a no-op.
    private func applyStoredShields() {
        guard let sel = gateSelection, hasStoredSelection else { return }
        store.shield.applications =
            sel.applicationTokens.isEmpty ? nil : sel.applicationTokens
        store.shield.applicationCategories = sel.categoryTokens.isEmpty
            ? nil
            : ShieldSettings.ActivityCategoryPolicy<Application>.specific(sel.categoryTokens)
        store.shield.webDomains =
            sel.webDomainTokens.isEmpty ? nil : sel.webDomainTokens
        shieldsKnownApplied = true
    }

    /// Grant a temporary unlock: retire the previous grant's machinery, record
    /// the new expiry FIRST (so any concurrent enforcement sees an active
    /// unlock), then drop shields and arm every re-lock layer.
    func grantTemporaryUnlock(seconds: Int) {
        cancelUnlockArtifacts()

        let until = Date().timeIntervalSince1970 + Double(seconds)
        sharedDefaults?.set(until, forKey: unlockUntilKey)

        scheduleExpiryNotification(after: seconds)
        removeShieldsForUnlock()
        armReshieldLayers(after: seconds)

        // Heal the narrow cross-process race where a stale extension callback
        // (already past its unlock_until read) re-applies shields just as this
        // grant lands: re-assert the removal shortly after.
        let reassert = DispatchWorkItem { [weak self] in
            guard let self = self, self.currentUnlockUntil != nil else { return }
            self.removeShieldsForUnlock()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: reassert)

        gateLog("FamilyControlsBridge: Unlock granted for \(seconds)s")
    }

    private func removeShieldsForUnlock() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        store.shield.webDomains = nil
        shieldsKnownApplied = false
    }

    /// End any active unlock immediately and restore shields.
    func endUnlock(reason: String) {
        cancelUnlockArtifacts()
        applyStoredShields()
        recordRelock(reason: reason)
        gateLog("FamilyControlsBridge: Unlock ended (\(reason))")
    }

    /// Cancel every artifact of the active unlock: the App Group expiry, the
    /// pending notification, the DeviceActivity unlock monitors, and the
    /// foreground timer. Runs only on explicit user paths (main thread).
    private func cancelUnlockArtifacts() {
        sharedDefaults?.removeObject(forKey: unlockUntilKey)
        UserDefaults.standard.removeObject(forKey: unlockUntilKey)
        cancelExpiryNotification()
        stopUnlockMonitors()
        foregroundRelockTimer?.cancel()
        foregroundRelockTimer = nil
    }

    /// Idempotent lock enforcement — THE function every layer funnels into.
    /// Re-applies the stored selection unless a still-valid unlock is active.
    /// Never removes shields; granting an unlock is the only removal path.
    func enforceLockState(reason: String) {
        guard hasAuthorization, hasStoredSelection else { return }

        if let until = sharedDefaults?.object(forKey: unlockUntilKey) as? Double {
            if Date().timeIntervalSince1970 < until {
                return // unlock still valid — a newer grant always wins
            }
            // Expired → true unlocked→locked transition. Safe to clear here:
            // grant and enforcement both run on this process's main thread.
            sharedDefaults?.removeObject(forKey: unlockUntilKey)
            applyStoredShields()
            recordRelock(reason: reason)
            gateLog("FamilyControlsBridge: Re-locked (\(reason))")
            return
        }

        // Steady state (no unlock recorded): make sure the shields match the
        // stored selection, but skip the redundant XPC writes when we already
        // know they do (this runs on every app activation).
        guard !shieldsKnownApplied else { return }
        applyStoredShields()
    }

    /// Called when the user stops gating entirely.
    func clearAllShieldsAndData() {
        cancelUnlockArtifacts()
        gateSelection = nil
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        store.shield.webDomains = nil
        shieldsKnownApplied = false
        center.stopMonitoring() // all schedules, including the watchdog
        clearStorage()
        gateLog("FamilyControlsBridge: All shields and data cleared")
    }

    // MARK: - Re-lock layers 1+2: DeviceActivity threshold + backstop schedule

    /// Arm the DeviceActivity layers for an unlock of `seconds`:
    /// - a usage-threshold event on the gated tokens equal to the unlock length
    ///   (fires mid-scroll, works below Apple's schedule minimum), and
    /// - a one-shot schedule whose end is padded to `max(seconds, 15 min) + 30 s`
    ///   as a wall-clock backstop that also survives reboots.
    /// Uses full date components so unlocks crossing midnight stay valid, and a
    /// unique activity name per grant so stale callbacks can't fight a newer
    /// unlock (enforcement also checks `unlock_until`).
    private func armReshieldLayers(after seconds: Int) {
        let calendar = Calendar.current
        let now = Date()
        let backstopEnd = now.addingTimeInterval(TimeInterval(max(seconds, 900) + 30))
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]

        let schedule = DeviceActivitySchedule(
            intervalStart: calendar.dateComponents(components, from: now),
            intervalEnd: calendar.dateComponents(components, from: backstopEnd),
            repeats: false
        )

        var events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [:]
        if let sel = gateSelection, hasStoredSelection {
            // Round the threshold UP: a floor-truncated threshold (e.g. 1 min for
            // a 90 s unlock) fires while the unlock is still valid, gets skipped
            // by the guard, and never fires again for that grant.
            let thresholdMinutes = max(1, (seconds + 59) / 60)
            events[DeviceActivityEvent.Name("unlock_budget")] = DeviceActivityEvent(
                applications: sel.applicationTokens,
                categories: sel.categoryTokens,
                webDomains: sel.webDomainTokens,
                threshold: DateComponents(minute: thresholdMinutes)
            )
        }

        let activityName = DeviceActivityName(
            "\(unlockActivityPrefix)\(Int(now.timeIntervalSince1970))"
        )

        do {
            try center.startMonitoring(activityName, during: schedule, events: events)
            gateLog("FamilyControlsBridge: Armed re-lock '\(activityName.rawValue)' — backstop \(max(seconds, 900) + 30)s")
        } catch {
            // Layers 3-5 still hold; the foreground timer below is a free extra.
            gateLog("FamilyControlsBridge: DeviceActivity monitoring failed: \(error)")
        }

        // Foreground bonus timer: exact re-lock if Niyyah stays open through the
        // window. Cancelled on revoke/supersede via cancelUnlockArtifacts.
        let timer = DispatchWorkItem { [weak self] in
            self?.enforceLockState(reason: "foreground_timer")
        }
        foregroundRelockTimer = timer
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(seconds) + 1, execute: timer)
    }

    /// Stop all one-shot unlock monitors (never the watchdog).
    private func stopUnlockMonitors() {
        let stale = center.activities.filter { $0.rawValue.hasPrefix(unlockActivityPrefix) }
        if !stale.isEmpty {
            center.stopMonitoring(stale)
        }
    }

    // MARK: - Re-lock layer 5: daily watchdog

    /// Register a repeating all-day schedule. Its `intervalDidStart` (fired every
    /// midnight, and shortly after registration) runs the same enforcement in the
    /// monitor extension — healing anything the other layers missed (reboots,
    /// killed schedules, pathological timing).
    func startWatchdog() {
        guard hasStoredSelection else { return }
        if center.activities.contains(where: { $0.rawValue == watchdogActivityName }) {
            return
        }
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: true
        )
        do {
            try center.startMonitoring(DeviceActivityName(watchdogActivityName), during: schedule)
            gateLog("FamilyControlsBridge: Watchdog registered")
        } catch {
            gateLog("FamilyControlsBridge: Watchdog registration failed: \(error)")
        }
    }

    // MARK: - Re-lock layer 4: expiry notification

    private func scheduleExpiryNotification(after seconds: Int) {
        cancelExpiryNotification()

        // Follow the user's in-app language (synced via syncPrefsToAppGroup),
        // matching how the Dart-side reminder notifications pick ar/en.
        let isArabic = (sharedDefaults?.string(forKey: localeCodeKey) ?? "en")
            .hasPrefix("ar")

        let content = UNMutableNotificationContent()
        content.title = isArabic ? "انتهى الوقت" : "Time's up"
        content.body = isArabic
            ? "انتهت نافذة فتح التطبيقات."
            : "Your unlock window has ended."
        content.sound = .default
        content.userInfo = ["action": "unlock_expired"]

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(max(seconds, 1)),
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: expiryNotificationId,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                gateLog("FamilyControlsBridge: Expiry notification failed: \(error)")
            }
        }
    }

    private func cancelExpiryNotification() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [expiryNotificationId])
    }

    // MARK: - Persistence

    private func saveSelectionToStorage() {
        guard let selection = gateSelection else { return }
        do {
            let selectionData = try JSONEncoder().encode(selection)
            // Keep the legacy key in sync for one release: an update installed
            // mid-unlock may still have extension state keyed off it, and it
            // makes a rollback to 1.1.0 safe.
            let legacyData = try JSONEncoder().encode(selection.applicationTokens)
            storageDefaults.set(selectionData, forKey: selectionStorageKey)
            storageDefaults.set(legacyData, forKey: legacyTokenStorageKey)
            if sharedDefaults == nil {
                gateLog("FamilyControlsBridge: App Group unavailable — selection persisted to standard defaults")
            }
        } catch {
            gateLog("FamilyControlsBridge: Failed to save selection: \(error)")
        }
    }

    private func loadStoredSelection() {
        let sources = [sharedDefaults, UserDefaults.standard].compactMap { $0 }

        for defaults in sources {
            if let data = defaults.data(forKey: selectionStorageKey),
               let selection = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data) {
                gateSelection = selection
                // Heal a copy that only exists in standard defaults.
                if sharedDefaults?.data(forKey: selectionStorageKey) == nil {
                    saveSelectionToStorage()
                }
                return
            }
        }

        // Pre-1.1.1 builds stored only application tokens — wrap them into a
        // full selection and migrate forward.
        for defaults in sources {
            if let data = defaults.data(forKey: legacyTokenStorageKey),
               let tokens = try? JSONDecoder().decode(Set<ApplicationToken>.self, from: data),
               !tokens.isEmpty {
                var selection = FamilyActivitySelection()
                selection.applicationTokens = tokens
                gateSelection = selection
                saveSelectionToStorage()
                return
            }
        }
    }

    /// Pre-1.1.1 builds tracked the fallback re-lock time as `reshield_at` in
    /// standard defaults. Carry a live unlock across the update, then drop the key.
    private func migrateLegacyReshieldAt() {
        guard let reshieldAt = UserDefaults.standard.object(forKey: "reshield_at") as? Double else {
            return
        }
        UserDefaults.standard.removeObject(forKey: "reshield_at")
        if reshieldAt > Date().timeIntervalSince1970,
           sharedDefaults?.object(forKey: unlockUntilKey) == nil {
            sharedDefaults?.set(reshieldAt, forKey: unlockUntilKey)
            gateLog("FamilyControlsBridge: Migrated legacy reshield_at")
        }
    }

    private func recordRelock(reason: String) {
        sharedDefaults?.set(Date().timeIntervalSince1970, forKey: lastRelockAtKey)
        sharedDefaults?.set(reason, forKey: lastRelockReasonKey)
    }

    private func clearStorage() {
        for defaults in [sharedDefaults, UserDefaults.standard].compactMap({ $0 }) {
            defaults.removeObject(forKey: selectionStorageKey)
            defaults.removeObject(forKey: legacyTokenStorageKey)
            defaults.removeObject(forKey: unlockUntilKey)
            defaults.removeObject(forKey: "reshield_at")
        }
    }
}
