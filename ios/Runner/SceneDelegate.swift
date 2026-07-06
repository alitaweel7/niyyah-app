import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {

    private var gateMethodChannel: GateMethodChannel?

    override func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        super.scene(scene, willConnectTo: session, options: connectionOptions)

        // The FlutterViewController is now available via the window
        if let windowScene = scene as? UIWindowScene,
           let controller = windowScene.windows.first?.rootViewController as? FlutterViewController {
            gateMethodChannel = GateMethodChannel(
                binaryMessenger: controller.binaryMessenger
            )
        }
    }
}
