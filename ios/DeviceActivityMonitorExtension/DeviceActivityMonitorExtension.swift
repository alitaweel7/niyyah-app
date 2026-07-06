import DeviceActivity
import ManagedSettings
import FamilyControls
import Foundation
import os

/// Runs in a system-spawned extension process. Mirrors the enforcement logic in
/// FamilyControlsBridge (main app): re-apply the stored selection unless a
/// still-valid `unlock_until` exists in the App Group. Kept dependency-free —
/// extension memory budgets are tight.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {

    private let store = ManagedSettingsStore()
    private let log = Logger(subsystem: "com.alimustafa.ayaunlock", category: "monitor")
    private let appGroupId = "group.com.ayaunlock.shared"

    override func intervalDidStart(for activity: DeviceActivityName) {
        // The daily watchdog fires here every midnight (and just after it is
        // registered) — heal any missed re-lock. Unlock intervals need nothing.
        if activity.rawValue == "niyyah_watchdog" {
            enforceLockState(trigger: "watchdog")
        }
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        // Backstop schedule end (or watchdog day end — harmless, idempotent).
        enforceLockState(trigger: "interval_end")
    }

    override func eventDidReachThreshold(
        _ event: DeviceActivityEvent.Name,
        activity: DeviceActivityName
    ) {
        // The user has actually consumed the unlock budget on the gated apps.
        enforceLockState(trigger: "usage_threshold")
    }

    /// Same semantics as FamilyControlsBridge.enforceLockState: never removes
    /// shields, respects an active unlock, and a newer grant always wins over a
    /// stale callback from a superseded activity.
    private func enforceLockState(trigger: String) {
        guard let defaults = UserDefaults(suiteName: appGroupId) else { return }

        if let until = defaults.object(forKey: "unlock_until") as? Double,
           Date().timeIntervalSince1970 < until {
            log.info("skip re-lock (\(trigger, privacy: .public)): unlock still active")
            return
        }

        guard applyStoredShields(from: defaults) else { return }

        defaults.removeObject(forKey: "unlock_until")
        defaults.set(Date().timeIntervalSince1970, forKey: "last_relock_at")
        defaults.set("ext_\(trigger)", forKey: "last_relock_reason")
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
