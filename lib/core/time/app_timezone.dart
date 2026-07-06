import 'package:flutter/foundation.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Initializes the timezone database and sets `tz.local` to the device's IANA
/// timezone.
///
/// Without this, `tz.local` defaults to UTC, which makes every scheduled
/// notification (prayer times, adhkar, etc.) fire at the wrong instant — e.g.
/// 3 hours off in Amman. Call once at app startup before anything schedules
/// notifications.
class AppTimezone {
  AppTimezone._();

  static bool _initialized = false;

  static Future<void> ensureInitialized() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (e) {
      // Fall back to the UTC default if the device timezone can't be resolved.
      debugPrint('AppTimezone: could not resolve device timezone: $e');
    }
    _initialized = true;
  }
}
