import 'package:go_router/go_router.dart';

import '../../features/app_selection/screens/app_selection_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/gate/screens/gate_picker_screen.dart';
import '../../features/gate/screens/gate_screen.dart';
import '../../features/history/screens/history_screen.dart';
import '../../features/learning/screens/learning_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/qibla/screens/qibla_screen.dart';
import '../../features/settings/screens/notification_settings_screen.dart';
import '../../features/settings/screens/privacy_policy_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../shared/widgets/main_shell.dart';

abstract final class AppRoutes {
  static const onboarding = '/onboarding';
  static const dashboard = '/dashboard';
  static const learning = '/learning';
  static const history = '/history';
  static const settings = '/settings';
  static const gate = '/gate';
  static const appSelection = '/app-selection';
  static const privacyPolicy = '/privacy-policy';
  static const notificationSettings = '/notification-settings';
  static const qibla = '/qibla';
}

GoRouter createRouter({required bool onboardingCompleted}) {
  return GoRouter(
    initialLocation:
        onboardingCompleted ? AppRoutes.dashboard : AppRoutes.onboarding,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.learning,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LearningScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.history,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HistoryScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.settings,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.gate,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final skipPicker = extra?['skipPicker'] == true;
          final contentType = extra?['contentType'] as String?;

          // If notification set skip_picker + content_type, go straight to reading
          if (skipPicker && contentType != null) {
            return GateScreen(
              blockedAppId: extra?['blockedAppId'] as int?,
              blockedAppName: extra?['blockedAppName'] as String?,
              initialContentType: contentType,
            );
          }

          return GatePickerScreen(
            blockedAppId: extra?['blockedAppId'] as int?,
            blockedAppName: extra?['blockedAppName'] as String?,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.appSelection,
        builder: (context, state) => const AppSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: AppRoutes.notificationSettings,
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.qibla,
        builder: (context, state) => const QiblaScreen(),
      ),
    ],
  );
}
