/// Abstract interface for platform-specific app gating.
///
/// Android implementation: UsageStatsManager + foreground service + overlay
/// iOS implementation: FamilyControls + ManagedSettings + DeviceActivityMonitor
abstract class AppGateService {
  /// Check if the required platform permissions have been granted.
  Future<bool> hasPermissions();

  /// Request the required platform permissions from the user.
  /// Returns true if all permissions were granted.
  Future<bool> requestPermissions();

  /// Start monitoring and gating the specified apps.
  /// [packageNames] is a list of app package/bundle identifiers to gate.
  Future<void> startGating(List<String> packageNames);

  /// Stop all gating. No apps will be blocked.
  Future<void> stopGating();

  /// Grant a temporary unlock for a specific app.
  /// The app will be accessible for [duration].
  Future<void> grantTemporaryUnlock(String packageName, Duration duration);

  /// Revoke an active unlock for a specific app.
  Future<void> revokeUnlock(String packageName);

  /// Stream that emits the package name of a gated app when the user
  /// attempts to open it. Used to trigger the gate screen.
  Stream<String> get gatedAppDetected;

  /// Whether the gating service is currently running.
  Future<bool> isRunning();
}
