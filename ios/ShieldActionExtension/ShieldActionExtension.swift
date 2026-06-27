import Foundation
import ManagedSettings
import UserNotifications

/// Debug-only logging — compiled out of release builds.
private func gateLog(_ message: @autoclosure () -> String) {
    #if DEBUG
    print(message())
    #endif
}

// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldActionExtension: ShieldActionDelegate {

    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        switch action {
        case .primaryButtonPressed:
            signalGateNeeded()
            completionHandler(.close)
        case .secondaryButtonPressed:
            completionHandler(.close)
        @unknown default:
            completionHandler(.close)
        }
    }

    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        switch action {
        case .primaryButtonPressed:
            signalGateNeeded()
            completionHandler(.close)
        case .secondaryButtonPressed:
            completionHandler(.close)
        @unknown default:
            completionHandler(.close)
        }
    }

    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        switch action {
        case .primaryButtonPressed:
            signalGateNeeded()
            completionHandler(.close)
        case .secondaryButtonPressed:
            completionHandler(.close)
        @unknown default:
            completionHandler(.close)
        }
    }

    /// Write a flag to shared UserDefaults and post a notification so the user
    /// can tap the banner to open Niyyah immediately.
    private func signalGateNeeded() {
        let timestamp = Date().timeIntervalSince1970
        // App Groups (cross-process communication)
        if let shared = UserDefaults(suiteName: "group.com.ayaunlock.shared") {
            shared.set(timestamp, forKey: "gate_requested_at")
            shared.synchronize()
        }
        // Standard defaults as fallback
        UserDefaults.standard.set(timestamp, forKey: "gate_requested_at")
        UserDefaults.standard.synchronize()

        // Post an immediate notification — tapping opens Niyyah directly
        postReadingNotification()
    }

    /// Post a time-sensitive local notification so it breaks through Focus/DND
    /// and appears prominently. Tapping opens Niyyah and skips straight to reading.
    private func postReadingNotification() {
        // Read the blocked app name from App Groups
        var appName = "your app"
        let suites: [UserDefaults?] = [
            UserDefaults(suiteName: "group.com.ayaunlock.shared"),
            UserDefaults.standard
        ]
        for defaults in suites.compactMap({ $0 }) {
            if let name = defaults.string(forKey: "last_blocked_app_name") {
                appName = name
                break
            }
        }

        // Read the user's preferred content type from App Groups
        var contentType = "quran"
        if let shared = UserDefaults(suiteName: "group.com.ayaunlock.shared") {
            if let preferred = shared.string(forKey: "preferred_content_type") {
                contentType = preferred
            }
        }

        let content = UNMutableNotificationContent()
        content.title = "Tap to start reading"
        content.body = "Read to unlock \(appName)"
        content.sound = .default
        content.userInfo = [
            "action": "open_gate",
            "blocked_app_name": appName,
            "content_type": contentType,
            "skip_picker": true
        ]

        // Time-sensitive: breaks through Focus/DND (iOS 15+)
        if #available(iOS 15.0, *) {
            content.interruptionLevel = .timeSensitive
        }

        let request = UNNotificationRequest(
            identifier: "niyyah_gate_reading",
            content: content,
            trigger: nil  // Deliver immediately
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                gateLog("ShieldAction: notification failed: \(error)")
            } else {
                gateLog("ShieldAction: posted reading notification")
            }
        }
    }
}
