import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/repositories/blocked_app_repository.dart';
import '../data/repositories/gate_session_repository.dart';
import '../data/repositories/preferences_repository.dart';
import 'platform/app_gate_service.dart';

/// Starts platform gating on launch and (on Android, eventually) routes
/// gated-app detections to the gate screen.
///
/// NOTE: unlock granting and re-locking are deliberately NOT handled here. On
/// iOS the gate screen calls [AppGateService.grantTemporaryUnlock] directly and
/// re-locking is owned entirely by the native layer — it must never depend on
/// the Flutter engine being alive.
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

  /// Stop listening and clean up.
  void dispose() {
    _subscription?.cancel();
  }
}
