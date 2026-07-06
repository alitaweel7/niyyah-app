import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/time/app_timezone.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set tz.local to the device timezone so prayer/adhkar notifications fire at
  // the correct local instant (not UTC).
  await AppTimezone.ensureInitialized();

  await NotificationService().initialize();

  runApp(
    const ProviderScope(
      child: AyaUnlockApp(),
    ),
  );
}
