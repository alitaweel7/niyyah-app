import 'dart:async';

import 'app_gate_service.dart';

/// Stub implementation of [AppGateService] for web and testing.
/// All methods are no-ops. The gated app detection stream never emits.
class StubAppGateService implements AppGateService {
  final _controller = StreamController<String>.broadcast();

  @override
  Future<bool> hasPermissions() async => true;

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<void> startGating(List<String> packageNames) async {}

  @override
  Future<void> stopGating() async {}

  @override
  Future<void> grantTemporaryUnlock(
      String packageName, Duration duration) async {}

  @override
  Future<void> revokeUnlock(String packageName) async {}

  @override
  Stream<String> get gatedAppDetected => _controller.stream;

  @override
  Future<bool> isRunning() async => false;

  @override
  Future<int> showAppPicker() async => 0;

  @override
  Future<bool> checkGateRequested() async => false;

  @override
  Future<bool> openApp(String urlScheme) async => false;

  @override
  Future<String?> getLastBlockedAppName() async => null;

  @override
  Future<void> syncPrefsToAppGroup({
    required int gateDurationSeconds,
    required int unlockDurationSeconds,
    String? preferredContentType,
    String? localeCode,
  }) async {}

  @override
  Future<Map<String, dynamic>> getGateNavigationInfo() async => {};

  @override
  Future<void> syncShieldAyahs(String ayahsJson) async {}
}
