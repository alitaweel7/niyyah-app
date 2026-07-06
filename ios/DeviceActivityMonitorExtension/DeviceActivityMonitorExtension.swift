import DeviceActivity
import ManagedSettings
import FamilyControls
import Foundation
import os

/// Runs in a system-spawned extension process. Mirrors the enforcement logic in
/// FamilyControlsBridge (main app): re-apply the stored selection unless a
/// still-valid `unlock_until` exists in the App Group. Kept dependency-free —
/// extension memory budgets are tight.
///
/// Cross-process rule: this extension NEVER deletes `unlock_until`. An expired
/// value is inert (every reader checks `now < until`), while a delete here can
/// race a fresh grant being written by the main app at the same instant and
/// destroy an unlock the user just earned. Only the main app removes the key.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {

    private let store = ManagedSettingsStore()
    private let log = Logger(subsystem: "com.alimustafa.ayaunlock", category: "monitor")
    private let appGroupId = "group.com.ayaunlock.shared"
    private let watchdogName = "niyyah_watchdog"

    override func intervalDidStart(for activity: DeviceActivityName) {
        // The daily watchdog fires here every midnight (and just after it is
        // registered) — heal any missed re-lock. Unlock intervals need nothing.
        if activity.rawValue == watchdogName {
            enforceLockState(trigger: "watchdog", isRelockEvent: false)
        }
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        // The watchdog's day also "ends" at 23:59 every night; midnight's
        // intervalDidStart is the designated healer, so skip the duplicate
        // (it would also clobber the re-lock diagnostics nightly).
        guard activity.rawValue != watchdogName else { return }
        // An unlock backstop expired → re-lock.
        enforceLockState(trigger: "interval_end", isRelockEvent: true)
    }

    override func eventDidReachThreshold(
        _ event: DeviceActivityEvent.Name,
        activity: DeviceActivityName
    ) {
        // The user has actually consumed the unlock budget on the gated apps.
        enforceLockState(trigger: "usage_threshold", isRelockEvent: true)
    }

    /// Same semantics as FamilyControlsBridge.enforceLockState: never removes
    /// shields, respects an active unlock, and a newer grant always wins over a
    /// stale callback from a superseded activity.
    ///
    /// `isRelockEvent` separates true unlock-lifecycle re-locks (which update the
    /// last_relock_* diagnostics) from the watchdog's routine daily re-assert
    /// (which records its own heartbeat instead, so the forensic record of the
    /// last real re-lock survives).
    private func enforceLockState(trigger: String, isRelockEvent: Bool) {
        guard let defaults = UserDefaults(suiteName: appGroupId) else { return }

        if let until = defaults.object(forKey: "unlock_until") as? Double,
           Date().timeIntervalSince1970 < until {
            log.info("skip re-lock (\(trigger, privacy: .public)): unlock still active")
            return
        }

        guard applyStoredShields(from: defaults) else { return }

        if isRelockEvent {
            defaults.set(Date().timeIntervalSince1970, forKey: "last_relock_at")
            defaults.set("ext_\(trigger)", forKey: "last_relock_reason")
        } else {
            defaults.set(Date().timeIntervalSince1970, forKey: "last_watchdog_at")
        }
        log.info("re-locked (\(trigger, privacy: .public))")
    }

    /// Restore the full selection (apps + categories + web domains); fall back to
    /// the legacy application-token key written by pre-1.1.1 builds.
    private func applyStoredShields(from defaults: UserDefaults) -> Bool {
        if let data = defaults.data(forKey: "gate_selection"),
           let selection = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data),
           !(selection.applicationTokens.isEmpty && selection.categoryTokens.isEmpty
               && selection.webDomainTokens.isEmpty) {
            store.shield.applications =
                selection.applicationTokens.isEmpty ? nil : selection.applicationTokens
            store.shield.applicationCategories = selection.categoryTokens.isEmpty
                ? nil
                : ShieldSettings.ActivityCategoryPolicy<Application>
                    .specific(selection.categoryTokens)
            store.shield.webDomains =
                selection.webDomainTokens.isEmpty ? nil : selection.webDomainTokens
            return true
        }

        if let data = defaults.data(forKey: "shielded_app_tokens"),
           let tokens = try? JSONDecoder().decode(Set<ApplicationToken>.self, from: data),
           !tokens.isEmpty {
            store.shield.applications = tokens
            return true
        }

        return false
    }
}
