import Flutter
import UIKit
import UserNotifications

/// Debug-only logging — compiled out of release builds.
private func gateLog(_ message: @autoclosure () -> String) {
    #if DEBUG
    print(message())
    #endif
}

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Set ourselves as the notification delegate so we handle taps
    UNUserNotificationCenter.current().delegate = self

    // Re-lock enforcement (layer 3): whenever the app becomes active or the
    // system clock jumps (manual change, DST, timezone), verify the lock state.
    // Notification-based so it fires in both the scene-based and classic
    // lifecycles; enforcement is idempotent and never removes shields.
    if #available(iOS 16.0, *) {
      NotificationCenter.default.addObserver(
        forName: UIApplication.didBecomeActiveNotification,
        object: nil,
        queue: .main
      ) { _ in
        FamilyControlsBridge.shared.enforceLockState(reason: "did_become_active")
      }
      NotificationCenter.default.addObserver(
        forName: UIApplication.significantTimeChangeNotification,
        object: nil,
        queue: .main
      ) { _ in
        FamilyControlsBridge.shared.enforceLockState(reason: "time_change")
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: - Notification tap handling

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    let userInfo = response.notification.request.content.userInfo

    if userInfo["action"] as? String == "open_gate" {
      // Set the gate flag in OUR standard UserDefaults (readable by main app).
      UserDefaults.standard.set(
        Date().timeIntervalSince1970,
        forKey: "gate_requested_at"
      )

      // Save the blocked app name so the gate screen can show it
      if let appName = userInfo["blocked_app_name"] as? String,
         appName != "your app" {
        UserDefaults.standard.set(appName, forKey: "last_blocked_app_name")
      }

      // Save content type and skip_picker flag so gate skips to reading directly
      if let contentType = userInfo["content_type"] as? String {
        UserDefaults.standard.set(contentType, forKey: "gate_content_type")
      }
      if let skipPicker = userInfo["skip_picker"] as? Bool, skipPicker {
        UserDefaults.standard.set(true, forKey: "gate_skip_picker")
      }

      gateLog("AppDelegate: gate_requested_at set from notification tap (skip_picker)")
    }

    completionHandler()
  }

  // Show notification banners even when app is in foreground
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.banner, .sound])
  }
}
