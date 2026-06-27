import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/repositories/blocked_app_repository.dart';
import '../data/repositories/gate_session_repository.dart';
import '../data/repositories/preferences_repository.dart';
import 'platform/app_gate_service.dart';

/// Coordinates the gate → unlock → re-lock lifecycle.
///
/// Listens to [AppGateService.gatedAppDetected] and triggers gate navigation.
/// After a gate is completed, grants temporary unlocks and schedules re-locking.
class UnlockManager {
  UnlockManager({
    required this.gateService,
    required this.gateSessionRepo,
    required this.blockedAppRepo,
    required this.preferencesRepo,
    required this.onGateTriggered,
  });

  final AppGateService gateService;
  final GateSessionRepository gateSessionRepo;
  final BlockedAppRepository blockedAppRepo;
  final PreferencesRepository preferencesRepo;

  /// Called when a gated app is detected. The callback should navigate
  /// to the gate screen with the blocked app info.
  final void Function(int blockedAppId, String appName) onGateTriggered;

  StreamSubscription<String>? _subscription;
  final Map<String, Timer> _unlockTimers = {};

  /// Start listening for gated app launches.
  Future<void> initialize() async {
    final apps = await blockedAppRepo.getActiveBlockedApps();
    if (apps.isEmpty) return;

    // Ensure we have Screen Time / usage permissions before gating
    final hasPerms = await gateService.hasPermissions();
    if (!hasPerms) {
      final granted = await gateService.requestPermissions();
      if (!granted) {
        debugPrint('UnlockManager: permissions not granted, skipping gating');
        return;
      }
    }

    final packageNames = apps.map((a) => a.packageName).toList();
    await gateService.startGating(packageNames);

    _subscription = gateService.gatedAppDetected.listen(_onAppDetected);
  }

  void _onAppDetected(String packageName) async {
    // Check if there's an active unlock for this app
    final app = await blockedAppRepo.findByPackageName(packageName);
    if (app == null) return;

    final activeUnlock =
        await gateSessionRepo.getActiveUnlockForApp(app.id);
    if (activeUnlock != null) return; // Already unlocked

    // Check if gating is paused
    final prefs = await preferencesRepo.getPreferences();
    if (prefs.pauseUntilTimestamp != null) {
      final pauseEnd = DateTime.fromMillisecondsSinceEpoch(
          prefs.pauseUntilTimestamp! * 1000);
      if (DateTime.now().isBefore(pauseEnd)) return; // Paused
    }

    onGateTriggered(app.id, app.displayName);
  }

  /// Grant a temporary unlock after gate completion.
  Future<void> grantUnlock({
    required int gateSessionId,
    required int blockedAppId,
    required String packageName,
  }) async {
    final prefs = await preferencesRepo.getPreferences();
    final duration = Duration(seconds: prefs.unlockDurationSeconds);

    // Record in DB
    await gateSessionRepo.createUnlockSession(
      gateSessionId: gateSessionId,
      blockedAppId: blockedAppId,
      durationSeconds: prefs.unlockDurationSeconds,
    );

    // Tell platform to unlock
    await gateService.grantTemporaryUnlock(packageName, duration);

    // Schedule re-lock
    _unlockTimers[packageName]?.cancel();
    _unlockTimers[packageName] = Timer(duration, () {
      _revokeUnlock(packageName);
    });
  }

  Future<void> _revokeUnlock(String packageName) async {
    await gateService.revokeUnlock(packageName);
    _unlockTimers.remove(packageName);
    debugPrint('UnlockManager: re-locked $packageName');
  }

  /// Stop listening and clean up.
  void dispose() {
    _subscription?.cancel();
    for (final timer in _unlockTimers.values) {
      timer.cancel();
    }
    _unlockTimers.clear();
  }
}
