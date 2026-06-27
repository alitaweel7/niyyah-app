import Flutter
import Foundation
import FamilyControls
import SwiftUI

/// Debug-only logging — compiled out of release builds.
private func gateLog(_ message: @autoclosure () -> String) {
    #if DEBUG
    print(message())
    #endif
}

/// Handles Flutter method channel calls for iOS app gating.
///
/// Bridges Flutter's `com.ayaunlock/gate` channel to [FamilyControlsBridge].
/// On iOS, the flow is:
/// 1. Flutter calls "requestPermissions" → prompts Screen Time authorization
/// 2. Flutter calls "showAppPicker" → presents FamilyActivityPicker
/// 3. User selects apps → shields are applied via ManagedSettingsStore
/// 4. Flutter calls "grantTemporaryUnlock" → shields removed temporarily
/// 5. After unlock duration, shields re-applied via DeviceActivityMonitor or timer
class GateMethodChannel: NSObject {

    private let methodChannel: FlutterMethodChannel
    private let eventChannel: FlutterEventChannel
    private var eventSink: FlutterEventSink?

    init(binaryMessenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(
            name: "com.ayaunlock/gate",
            binaryMessenger: binaryMessenger
        )
        eventChannel = FlutterEventChannel(
            name: "com.ayaunlock/gate_events",
            binaryMessenger: binaryMessenger
        )

        super.init()

        methodChannel.setMethodCallHandler(handle)
        eventChannel.setStreamHandler(self)
    }

    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if #available(iOS 16.0, *) {
            handleiOS16(call, result: result)
        } else {
            // FamilyControls requires iOS 16+
            switch call.method {
            case "hasPermissions":
                result(false)
            case "requestPermissions":
                result(false)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    @available(iOS 16.0, *)
    private func handleiOS16(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bridge = FamilyControlsBridge.shared

        switch call.method {
        case "hasPermissions":
            result(bridge.hasAuthorization)

        case "requestPermissions":
            Task {
                let granted = await bridge.requestAuthorization()
                DispatchQueue.main.async {
                    if !granted {
                        // Open Settings so user can enable Screen Time / Family Controls
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }
                    result(granted)
                }
            }

        case "showAppPicker":
            // Present the FamilyActivityPicker as a SwiftUI sheet
            showFamilyActivityPicker(result: result)

        case "startGating":
            // Re-apply shields from stored tokens (e.g., on app restart)
            bridge.reapplyShields()
            // Check if a pending re-shield time has passed while app was in background
            bridge.checkPendingReshield()
            result(nil)

        case "stopGating":
            bridge.clearAllShieldsAndData()
            result(nil)

        case "grantTemporaryUnlock":
            let args = call.arguments as? [String: Any]
            let durationSeconds = args?["durationSeconds"] as? Int ?? 600

            // Remove shields temporarily
            bridge.removeAllShields()

            // Schedule re-shield after duration
            bridge.scheduleReshield(after: durationSeconds, name: "unlock_session")
            result(nil)

        case "revokeUnlock":
            // Re-apply shields immediately
            bridge.reapplyShields()
            result(nil)

        case "isRunning":
            // Also check for pending re-shields whenever the app checks status
            bridge.checkPendingReshield()
            result(bridge.hasAuthorization)

        case "getLastBlockedAppName":
            // Get the name of the last app that was shielded
            let suites = [
                UserDefaults(suiteName: "group.com.ayaunlock.shared"),
                UserDefaults.standard
            ]
            for defaults in suites.compactMap({ $0 }) {
                if let name = defaults.string(forKey: "last_blocked_app_name") {
                    result(name)
                    return
                }
            }
            result(nil)

        case "openApp":
            // Open an app by URL scheme (e.g., instagram://)
            if let args = call.arguments as? [String: Any],
               let urlString = args["url"] as? String,
               let url = URL(string: urlString) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:]) { success in
                        result(success)
                    }
                }
            } else {
                result(false)
            }

        case "checkGateRequested":
            // Check if the ShieldActionExtension signaled that a reading is needed
            // Try App Groups UserDefaults first, then fall back to standard UserDefaults
            let suites = [
                UserDefaults(suiteName: "group.com.ayaunlock.shared"),
                UserDefaults.standard
            ]
            for defaults in suites.compactMap({ $0 }) {
                if let requestedAt = defaults.object(forKey: "gate_requested_at") as? Double {
                    let elapsed = Date().timeIntervalSince1970 - requestedAt
                    if elapsed < 120 { // 2 minute window
                        defaults.removeObject(forKey: "gate_requested_at")
                        result(true)
                        return
                    } else {
                        defaults.removeObject(forKey: "gate_requested_at")
                    }
                }
            }
            result(false)

        case "getGateNavigationInfo":
            // Returns skip_picker, content_type, and blocked_app_name in one call
            var info: [String: Any] = [:]

            // Check skip_picker flag
            let skipPicker = UserDefaults.standard.bool(forKey: "gate_skip_picker")
            info["skip_picker"] = skipPicker
            UserDefaults.standard.removeObject(forKey: "gate_skip_picker")

            // Check content_type
            if let contentType = UserDefaults.standard.string(forKey: "gate_content_type") {
                info["content_type"] = contentType
                UserDefaults.standard.removeObject(forKey: "gate_content_type")
            }

            // Check blocked app name
            let suites2 = [
                UserDefaults(suiteName: "group.com.ayaunlock.shared"),
                UserDefaults.standard
            ]
            for defaults in suites2.compactMap({ $0 }) {
                if let name = defaults.string(forKey: "last_blocked_app_name") {
                    info["blocked_app_name"] = name
                    break
                }
            }

            result(info)

        case "syncPrefsToAppGroup":
            // Sync key preferences to App Groups so shield extensions can read them
            let args = call.arguments as? [String: Any]
            if let shared = UserDefaults(suiteName: "group.com.ayaunlock.shared") {
                if let duration = args?["gateDurationSeconds"] as? Int {
                    shared.set(duration, forKey: "gate_duration_seconds")
                }
                if let unlockDuration = args?["unlockDurationSeconds"] as? Int {
                    shared.set(unlockDuration, forKey: "unlock_duration_seconds")
                }
                if let contentType = args?["preferredContentType"] as? String {
                    shared.set(contentType, forKey: "preferred_content_type")
                }
                shared.synchronize()
                gateLog("GateMethodChannel: synced prefs to App Group")
            }
            result(nil)

        case "syncShieldAyahs":
            let args = call.arguments as? [String: Any]
            if let json = args?["ayahs"] as? String,
               let shared = UserDefaults(suiteName: "group.com.ayaunlock.shared") {
                shared.set(json.data(using: .utf8), forKey: "shield_ayahs")
                shared.synchronize()
            }
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    @available(iOS 16.0, *)
    private func showFamilyActivityPicker(result: @escaping FlutterResult) {
        guard let rootVC = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows.first?.rootViewController else {
            result(FlutterError(code: "NO_ROOT_VC", message: "Cannot find root view controller", details: nil))
            return
        }

        let pickerView = FamilyActivityPickerView { selection in
            let bridge = FamilyControlsBridge.shared
            bridge.applySelectionShields(selection: selection)
            rootVC.dismiss(animated: true) {
                result(selection.applicationTokens.count + selection.categoryTokens.count)
            }
        } onCancel: {
            rootVC.dismiss(animated: true) {
                result(0)
            }
        }

        let hostingController = UIHostingController(rootView: pickerView)
        hostingController.modalPresentationStyle = .pageSheet
        rootVC.present(hostingController, animated: true)
    }

    func dispose() {
        methodChannel.setMethodCallHandler(nil)
    }
}

// MARK: - FlutterStreamHandler

extension GateMethodChannel: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
}

// MARK: - FamilyActivityPicker SwiftUI Wrapper

@available(iOS 16.0, *)
struct FamilyActivityPickerView: View {
    @State private var selection = FamilyActivitySelection()
    let onSelection: (FamilyActivitySelection) -> Void
    let onCancel: () -> Void

    var body: some View {
        NavigationView {
            FamilyActivityPicker(selection: $selection)
                .navigationTitle("Select Apps to Gate")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            onCancel()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            onSelection(selection)
                        }
                        .bold()
                    }
                }
        }
    }
}
