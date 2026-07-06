import DeviceActivity
import ManagedSettings
import FamilyControls
import Foundation

class DeviceActivityMonitorExtension: DeviceActivityMonitor {

    private let store = ManagedSettingsStore()

    override func intervalDidStart(for activity: DeviceActivityName) {
        // Shield already applied — nothing to do.
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        // An unlock window expired → re-apply shields.
        reapplyAllShields()
    }

    private func reapplyAllShields() {
        // Suite + key MUST match FamilyControlsBridge.swift.
        guard let defaults = UserDefaults(suiteName: "group.com.ayaunlock.shared"),
              let data = defaults.data(forKey: "shielded_app_tokens"),
              let tokens = try? JSONDecoder().decode(Set<ApplicationToken>.self, from: data),
              !tokens.isEmpty else {
            return
        }
        store.shield.applications = tokens
    }
}
