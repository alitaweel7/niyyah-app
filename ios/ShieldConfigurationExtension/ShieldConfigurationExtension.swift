import Foundation
import ManagedSettings
import ManagedSettingsUI
import UIKit

// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {

    /// Read the user's gate duration from App Groups (synced by the main app).
    private var gateDurationMinutes: Int {
        if let shared = UserDefaults(suiteName: "group.com.ayaunlock.shared"),
           shared.integer(forKey: "gate_duration_seconds") > 0 {
            return max(1, shared.integer(forKey: "gate_duration_seconds") / 60)
        }
        return 1 // default
    }

    /// Reads the rotating ayah set synced by the main app (App Group), if any.
    private func currentAyah() -> (ar: String, en: String)? {
        guard let shared = UserDefaults(suiteName: "group.com.ayaunlock.shared"),
              let data = shared.data(forKey: "shield_ayahs"),
              let arr = try? JSONSerialization.jsonObject(with: data) as? [[String: String]],
              !arr.isEmpty else {
            return nil
        }
        // Rotate by day-of-year: stable within a day, changes daily.
        let day = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        let item = arr[day % arr.count]
        if let ar = item["ar"], let en = item["en"] {
            return (ar, en)
        }
        return nil
    }

    private func buildConfig(title appName: String) -> ShieldConfiguration {
        let minutes = gateDurationMinutes
        let durationText = minutes == 1 ? "1 minute" : "\(minutes) minutes"
        let gold = UIColor(red: 0.85, green: 0.71, blue: 0.53, alpha: 1.0)

        let ayah = currentAyah()
        let titleText = ayah?.ar ?? "Set your niyyah first"
        let subtitleText: String
        if let ayah = ayah {
            subtitleText = "\(ayah.en)\n\nRead for \(durationText) in Niyyah to unlock \(appName)."
        } else {
            subtitleText = "Read for \(durationText) in Niyyah to unlock \(appName)."
        }

        return ShieldConfiguration(
            backgroundBlurStyle: .systemUltraThinMaterialDark,
            backgroundColor: UIColor(red: 0.106, green: 0.263, blue: 0.196, alpha: 1.0),  // deep green
            icon: UIImage(named: "NiyyahIcon"),
            title: ShieldConfiguration.Label(text: titleText, color: .white),
            subtitle: ShieldConfiguration.Label(text: subtitleText, color: gold),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Read to Unlock", color: .white),
            primaryButtonBackgroundColor: UIColor(red: 0.161, green: 0.380, blue: 0.282, alpha: 1.0),
            secondaryButtonLabel: ShieldConfiguration.Label(
                text: "Not now",
                color: gold.withAlphaComponent(0.8)
            )
        )
    }

    override func configuration(shielding application: Application) -> ShieldConfiguration {
        let appName = application.localizedDisplayName ?? "This app"
        saveLastBlockedApp(name: appName)
        return buildConfig(title: appName)
    }

    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        let appName = application.localizedDisplayName ?? "This app"
        saveLastBlockedApp(name: appName)
        return buildConfig(title: appName)
    }

    /// Store the blocked app name so the main app can open it after reading.
    private func saveLastBlockedApp(name: String) {
        if let shared = UserDefaults(suiteName: "group.com.ayaunlock.shared") {
            shared.set(name, forKey: "last_blocked_app_name")
            shared.synchronize()
        }
        UserDefaults.standard.set(name, forKey: "last_blocked_app_name")
        UserDefaults.standard.synchronize()
    }

    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        return buildConfig(title: webDomain.domain ?? "This site")
    }

    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        return buildConfig(title: webDomain.domain ?? "This site")
    }
}
