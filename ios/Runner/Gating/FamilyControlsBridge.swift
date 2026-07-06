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
/// selection whenever no unlock is active, and never removes shields. Layers:
///  1. DeviceActivityEvent usage threshold (= unlock length) — precise, works < 15 min
///  2. One-shot DeviceActivitySchedule backstop (padded to Apple's ~15-min minimum,
///     full date components so midnight-crossing unlocks are valid)
///  3. Foreground/clock-change enforcement (didBecomeActive + significantTimeChange)
///  4. Local "time's up" notification at the exact unlock expiry
///  5. Daily repeating watchdog schedule that heals anything missed
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
    private let expiryNotificationId = "niyyah_unlock_expiry"
    private let watchdogActivityName = "niyyah_watchdog"
    private let unlockActivityPrefix = "unlock_"

    private let appGroupId = "group.com.ayaunlock.shared"
    private var sharedDefaults: UserDefaults? { UserDefaults(suiteName: appGroupId) }

    /// The full gated selection (apps + categories + web domains) as picked by the
    /// user. Persisted so every re-shield path restores all of it — restoring only
    /// app tokens silently dropped category shields after the first unlock.
    private var gateSelection: FamilyActivitySelection?

    /// Tokens decoded from the legacy storage key (pre-1.1.1 builds persisted only
    /// application tokens). Used when no full selection has been stored yet.
    private var legacyTokens = Set<ApplicationToken>()

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
        if let sel = gateSelection {
            return !(sel.applicationTokens.isEmpty && sel.categoryTokens.isEmpty
                && sel.webDomainTokens.isEmpty)
        }
        return !legacyTokens.isEmpty
    }

    /// Apply shields from the FamilyActivitySelection (apps, categories, web domains)
    func applySelectionShields(selection: FamilyActivitySelection) {
        gateSelection = selection
        legacyTokens = selection.applicationTokens
        saveSelectionToStorage()
        applyStoredShields()
        gateLog("FamilyControlsBridge: Applied shields — \(selection.applicationTokens.count) apps, \(selection.categoryTokens.count) categories, \(selection.webDomainTokens.count) web domains")
    }

    /// Push the stored selection into the ManagedSettingsStore. Never clears
    /// anything: with an empty selection this is a no-op.
    private func applyStoredShields() {
        guard hasStoredSelection else { return }
        if let sel = gateSelection {
            store.shield.applications =
                sel.applicationTokens.isEmpty ? nil : sel.applicationTokens
            store.shield.applicationCategories = sel.categoryTokens.isEmpty
                ? nil
                : ShieldSettings.ActivityCategoryPolicy<Application>.specific(sel.categoryTokens)
            store.shield.webDomains =
                sel.webDomainTokens.isEmpty ? nil : sel.webDomainTokens
        } else {
            store.shield.applications = legacyTokens
        }
    }

    /// Grant a temporary unlock: record the expiry FIRST (so any concurrent
    /// enforcement sees an active unlock), then drop shields and arm every
    /// re-lock layer.
    func grantTemporaryUnlock(seconds: Int) {
        let until = Date().timeIntervalSince1970 + Double(seconds)
        sharedDefaults?.set(until, forKey: unlockUntilKey)

        scheduleExpiryNotification(after: seconds)

        store.shield.applications = nil
        store.shield.applicationCategories = nil
        store.shield.webDomains = nil

        scheduleReshield(after: seconds)
        gateLog("FamilyControlsBridge: Unlock granted for \(seconds)s")
    }

    /// End any active unlock immediately and restore shields.
    func endUnlock(reason: String) {
        sharedDefaults?.removeObject(forKey: unlockUntilKey)
        cancelExpiryNotification()
        stopUnlockMonitors()
        applyStoredShields()
        recordRelock(reason: reason)
        gateLog("FamilyControlsBridge: Unlock ended (\(reason))")
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
            sharedDefaults?.removeObject(forKey: unlockUntilKey)
            applyStoredShields()
            recordRelock(reason: reason)
            gateLog("FamilyControlsBridge: Re-locked (\(reason))")
        } else {
            // No unlock recorded (fresh launch, post-reboot, …) — make sure the
            // shields match the stored selection.
            applyStoredShields()
        }
    }

    /// Called when the user stops gating entirely.
    func clearAllShieldsAndData() {
        gateSelection = nil
        legacyTokens.removeAll()
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        store.shield.webDomains = nil
        center.stopMonitoring()
        cancelExpiryNotification()
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
    private func scheduleReshield(after seconds: Int) {
        stopUnlockMonitors()

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
        let apps = gateSelection?.applicationTokens ?? legacyTokens
        let categories = gateSelection?.categoryTokens ?? []
        let webDomains = gateSelection?.webDomainTokens ?? []
        if !(apps.isEmpty && categories.isEmpty && webDomains.isEmpty) {
            events[DeviceActivityEvent.Name("unlock_budget")] = DeviceActivityEvent(
                applications: apps,
                categories: categories,
                webDomains: webDomains,
                threshold: DateComponents(minute: max(1, seconds / 60))
            )
        }

        let activityName = DeviceActivityName(
            "\(unlockActivityPrefix)\(Int(now.timeIntervalSince1970))"
        )

        do {
            try center.startMonitoring(activityName, during: schedule, events: events)
            gateLog("FamilyControlsBridge: Armed re-lock '\(activityName.rawValue)' — threshold \(max(1, seconds / 60))min, backstop \(max(seconds, 900) + 30)s")
        } catch {
            // Layers 3-5 still hold; the foreground timer below is a free extra.
            gateLog("FamilyControlsBridge: DeviceActivity monitoring failed: \(error)")
        }

        // Foreground bonus timer: exact re-lock if Niyyah stays open through the
        // window. Safe for superseded unlocks — enforcement checks `unlock_until`.
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(seconds) + 1) { [weak self] in
            self?.enforceLockState(reason: "foreground_timer")
        }
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

        let content = UNMutableNotificationContent()
        content.title = "Time's up · انتهى الوقت"
        content.body = "Your unlock window has ended. · انتهت نافذة فتح التطبيقات."
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
        guard let defaults = sharedDefaults else {
            gateLog("FamilyControlsBridge: App Group unavailable — selection not persisted")
            return
        }
        do {
            if let selection = gateSelection {
                defaults.set(try JSONEncoder().encode(selection), forKey: selectionStorageKey)
            }
            // Keep the legacy key in sync for one release: an update installed
            // mid-unlock may still have extension state keyed off it, and it makes
            // a rollback to 1.1.0 safe.
            defaults.set(try JSONEncoder().encode(legacyTokens), forKey: legacyTokenStorageKey)
        } catch {
            gateLog("FamilyControlsBridge: Failed to save selection: \(error)")
        }
    }

    private func loadStoredSelection() {
        guard let defaults = sharedDefaults else { return }
        if let data = defaults.data(forKey: selectionStorageKey),
           let selection = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data) {
            gateSelection = selection
            legacyTokens = selection.applicationTokens
            return
        }
        // Pre-1.1.1 builds stored only application tokens (possibly in standard
        // defaults on very old builds) — migrate them forward.
        let legacyData = defaults.data(forKey: legacyTokenStorageKey)
            ?? UserDefaults.standard.data(forKey: legacyTokenStorageKey)
        if let data = legacyData,
           let tokens = try? JSONDecoder().decode(Set<ApplicationToken>.self, from: data),
           !tokens.isEmpty {
            legacyTokens = tokens
            if defaults.data(forKey: legacyTokenStorageKey) == nil {
                defaults.set(data, forKey: legacyTokenStorageKey)
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
        sharedDefaults?.removeObject(forKey: selectionStorageKey)
        sharedDefaults?.removeObject(forKey: legacyTokenStorageKey)
        sharedDefaults?.removeObject(forKey: unlockUntilKey)
        UserDefaults.standard.removeObject(forKey: legacyTokenStorageKey)
        UserDefaults.standard.removeObject(forKey: "reshield_at")
    }
}
