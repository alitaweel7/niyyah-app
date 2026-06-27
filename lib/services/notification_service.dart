import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Manages local notifications for unlock expiry warnings and gate completions.
class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  /// Initialize the notification plugin. Call once at app startup.
  Future<void> initialize() async {
    if (kIsWeb || _initialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings);
    _initialized = true;
  }

  /// Schedule a notification warning that an unlock is about to expire.
  Future<void> scheduleUnlockExpiryWarning({
    required int id,
    required String appName,
    required Duration delay,
  }) async {
    if (kIsWeb || !_initialized) return;

    // Show the warning 1 minute before expiry
    final warningDelay = delay - const Duration(minutes: 1);
    if (warningDelay.isNegative) return;

    await _plugin.show(
      id,
      'Unlock expiring soon',
      'Your $appName unlock expires in 1 minute',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'unlock_expiry',
          'Unlock Expiry',
          channelDescription: 'Warnings when app unlock windows are about to expire',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  /// Show a notification that an app has been re-locked.
  Future<void> showRelockNotification({
    required int id,
    required String appName,
  }) async {
    if (kIsWeb || !_initialized) return;

    await _plugin.show(
      id,
      'App gated again',
      '$appName is gated again. Set your niyyah before you scroll.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'gate_status',
          'Gate Status',
          channelDescription: 'Notifications about app gating status',
          importance: Importance.low,
          priority: Priority.low,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  /// Cancel a specific notification.
  Future<void> cancel(int id) async {
    if (kIsWeb || !_initialized) return;
    await _plugin.cancel(id);
  }

  /// Cancel all notifications.
  Future<void> cancelAll() async {
    if (kIsWeb || !_initialized) return;
    await _plugin.cancelAll();
  }
}
