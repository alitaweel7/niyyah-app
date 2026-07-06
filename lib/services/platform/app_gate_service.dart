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

  /// Show the platform-native app picker (iOS: FamilyActivityPicker).
  /// Returns the number of apps/categories selected.
  Future<int> showAppPicker();

  /// Check if the shield action extension signaled that a gate reading is needed.
  Future<bool> checkGateRequested();

  /// Open an app by URL scheme (e.g., "instagram://").
  Future<bool> openApp(String urlScheme);

  /// Get the name of the last app that was shielded (saved by ShieldConfigurationExtension).
  Future<String?> getLastBlockedAppName();

  /// Sync key preferences to App Groups so shield extensions can display them
  /// (and native notifications can follow the in-app language).
  Future<void> syncPrefsToAppGroup({
    required int gateDurationSeconds,
    required int unlockDurationSeconds,
    String? preferredContentType,
    String? localeCode,
  });

  /// Get navigation info set by the notification tap (skip_picker, content_type, blocked_app_name).
  Future<Map<String, dynamic>> getGateNavigationInfo();

  /// Sync a small set of short ayahs (a JSON array of {"ar","en"} objects) to
  /// App Groups so the iOS shield can display a rotating ayah.
  Future<void> syncShieldAyahs(String ayahsJson);
}
