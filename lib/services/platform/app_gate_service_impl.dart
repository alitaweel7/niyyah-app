import 'dart:async';

import 'package:flutter/services.dart';

import 'app_gate_service.dart';

/// Platform channel implementation of [AppGateService].
/// Communicates with native Android (Kotlin) and iOS (Swift) code.
class MethodChannelAppGateService implements AppGateService {
  static const _methodChannel = MethodChannel('com.ayaunlock/gate');
  static const _eventChannel = EventChannel('com.ayaunlock/gate_events');

  StreamController<String>? _detectionController;

  @override
  Future<bool> hasPermissions() async {
    final result = await _methodChannel.invokeMethod<bool>('hasPermissions');
    return result ?? false;
  }

  @override
  Future<bool> requestPermissions() async {
    final result =
        await _methodChannel.invokeMethod<bool>('requestPermissions');
    return result ?? false;
  }

  @override
  Future<void> startGating(List<String> packageNames) async {
    await _methodChannel.invokeMethod('startGating', {
      'packageNames': packageNames,
    });
    _startListening();
  }

  @override
  Future<void> stopGating() async {
    await _methodChannel.invokeMethod('stopGating');
    _stopListening();
  }

  @override
  Future<void> grantTemporaryUnlock(
      String packageName, Duration duration) async {
    await _methodChannel.invokeMethod('grantTemporaryUnlock', {
      'packageName': packageName,
      'durationSeconds': duration.inSeconds,
    });
  }

  @override
  Future<void> revokeUnlock(String packageName) async {
    await _methodChannel.invokeMethod('revokeUnlock', {
      'packageName': packageName,
    });
  }

  @override
  Stream<String> get gatedAppDetected {
    _detectionController ??= StreamController<String>.broadcast();
    return _detectionController!.stream;
  }

  @override
  Future<bool> isRunning() async {
    final result = await _methodChannel.invokeMethod<bool>('isRunning');
    return result ?? false;
  }

  @override
  Future<int> showAppPicker() async {
    final result = await _methodChannel.invokeMethod<int>('showAppPicker');
    return result ?? 0;
  }

  @override
  Future<bool> checkGateRequested() async {
    final result = await _methodChannel.invokeMethod<bool>('checkGateRequested');
    return result ?? false;
  }

  @override
  Future<bool> openApp(String urlScheme) async {
    final result = await _methodChannel.invokeMethod<bool>('openApp', {
      'url': urlScheme,
    });
    return result ?? false;
  }

  @override
  Future<String?> getLastBlockedAppName() async {
    return await _methodChannel.invokeMethod<String>('getLastBlockedAppName');
  }

  @override
  Future<void> syncPrefsToAppGroup({
    required int gateDurationSeconds,
    required int unlockDurationSeconds,
    String? preferredContentType,
    String? localeCode,
  }) async {
    await _methodChannel.invokeMethod('syncPrefsToAppGroup', {
      'gateDurationSeconds': gateDurationSeconds,
      'unlockDurationSeconds': unlockDurationSeconds,
      'preferredContentType': ?preferredContentType,
      'localeCode': ?localeCode,
    });
  }

  @override
  Future<Map<String, dynamic>> getGateNavigationInfo() async {
    final result = await _methodChannel.invokeMethod<Map>('getGateNavigationInfo');
    if (result != null) {
      return Map<String, dynamic>.from(result);
    }
    return {};
  }

  @override
  Future<void> syncShieldAyahs(String ayahsJson) async {
    await _methodChannel.invokeMethod('syncShieldAyahs', {'ayahs': ayahsJson});
  }

  void _startListening() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      if (event is String && _detectionController != null) {
        _detectionController!.add(event);
      }
    });
  }

  void _stopListening() {
    _detectionController?.close();
    _detectionController = null;
  }
}
