import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/di/providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';

/// Loads preferences once at startup via Future (not stream).
final _initPrefsProvider = FutureProvider((ref) async {
  final prefs = await ref.read(preferencesRepositoryProvider).getPreferences();

  // One-time backfill: pre-v5 builds only stored per-surah read counts. Map
  // that history into the new distinct-ayah model (first N ayahs per surah) so
  // existing users keep their progress, in Quran order. Runs only while the
  // new ReadAyahs table is still empty.
  try {
    final progressRepo = ref.read(readingProgressRepositoryProvider);
    if (!await progressRepo.hasAnyReadAyahs()) {
      final quranRepo = ref.read(quranRepositoryProvider);
      await progressRepo.backfillFromSurahProgress(quranRepo.getAyahsForSurah);
    }
  } catch (e) {
    debugPrint('ReadAyahs backfill skipped: $e');
  }

  return prefs;
});

/// A small curated set of short ayahs shown (rotating, one per day) on the iOS
/// shield over a gated app, synced to the App Group for the shield extension.
const List<Map<String, String>> _shieldAyahs = [
  {'ar': 'إِنَّ مَعَ الْعُسْرِ يُسْرًا', 'en': 'Indeed, with hardship comes ease. (94:6)'},
  {'ar': 'فَاذْكُرُونِي أَذْكُرْكُمْ', 'en': 'So remember Me; I will remember you. (2:152)'},
  {'ar': 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ', 'en': 'In the remembrance of Allah hearts find rest. (13:28)'},
  {'ar': 'وَهُوَ مَعَكُمْ أَيْنَ مَا كُنتُمْ', 'en': 'And He is with you wherever you are. (57:4)'},
  {'ar': 'إِنَّ اللَّهَ مَعَ الصَّابِرِينَ', 'en': 'Indeed, Allah is with the patient. (2:153)'},
  {'ar': 'وَقُل رَّبِّ زِدْنِي عِلْمًا', 'en': 'And say: My Lord, increase me in knowledge. (20:114)'},
  {'ar': 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ', 'en': 'Sufficient for us is Allah, the best Disposer of affairs. (3:173)'},
  {'ar': 'وَاللَّهُ خَيْرٌ حَافِظًا', 'en': 'And Allah is the best Guardian. (12:64)'},
  {'ar': 'وَبَشِّرِ الصَّابِرِينَ', 'en': 'And give glad tidings to the patient. (2:155)'},
  {'ar': 'رَبِّ اشْرَحْ لِي صَدْرِي', 'en': 'My Lord, expand for me my chest. (20:25)'},
  {'ar': 'وَتَوَكَّلْ عَلَى اللَّهِ', 'en': 'And put your trust in Allah. (33:3)'},
  {'ar': 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا', 'en': 'For indeed, with hardship comes ease. (94:5)'},
];

class AyaUnlockApp extends ConsumerStatefulWidget {
  const AyaUnlockApp({super.key});

  @override
  ConsumerState<AyaUnlockApp> createState() => _AyaUnlockAppState();
}

class _AyaUnlockAppState extends ConsumerState<AyaUnlockApp>
    with WidgetsBindingObserver {
  final _navigatorKey = GlobalKey<NavigatorState>();
  GoRouter? _router;
  bool _unlockManagerInitialized = false;
  bool _hasCheckedGateOnLaunch = false;
  DateTime? _lastAutoGateNav;
  bool _remindersScheduled = false;

  /// Tracks which date we last scheduled prayer notifications for.
  /// Re-schedules whenever the date changes (new day) or app resumes.
  String? _lastScheduledDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshPrayerRemindersIfNeeded();
      // On resume, only navigate if the shield button was tapped (App Groups flag).
      // This prevents annoying auto-navigation every time the user opens Niyyah.
      if (Platform.isIOS) {
        _checkGateRequestedFlag();
      }
    }
  }

  /// Targeted check: only navigates if the ShieldActionExtension set the flag
  /// via App Groups. Used on resume to avoid false positives.
  Future<void> _checkGateRequestedFlag() async {
    if (_lastAutoGateNav != null &&
        DateTime.now().difference(_lastAutoGateNav!).inSeconds < 120) {
      return;
    }
    try {
      final gateService = ref.read(appGateServiceProvider);
      final requested = await gateService.checkGateRequested();
      if (requested) {
        debugPrint('Gate flag detected — navigating to gate screen');
        _navigateToGate();
      }
    } catch (e) {
      debugPrint('Gate flag check failed: $e');
    }
  }

  /// Broad check for cold start: navigates if the user has gated apps
  /// and permissions. Fallback for when App Groups aren't set up.
  Future<void> _checkForGateRequest() async {
    if (_lastAutoGateNav != null &&
        DateTime.now().difference(_lastAutoGateNav!).inSeconds < 120) {
      return;
    }

    try {
      // First try the targeted flag (most reliable)
      final gateService = ref.read(appGateServiceProvider);
      final requested = await gateService.checkGateRequested();
      if (requested) {
        debugPrint('Gate flag detected on cold start — navigating');
        _navigateToGate();
        return;
      }

      // Fallback: check if user has gated apps + permissions
      final blockedAppRepo = ref.read(blockedAppRepositoryProvider);
      final apps = await blockedAppRepo.getActiveBlockedApps();
      if (apps.isEmpty) return;

      final hasPerms = await gateService.hasPermissions();
      if (!hasPerms) return;

      debugPrint('Cold start with gated apps — navigating to gate screen');
      _navigateToGate();
    } catch (e) {
      debugPrint('Gate request check failed: $e');
    }
  }

  Future<void> _navigateToGate() async {
    if (!mounted || _router == null) return;
    _lastAutoGateNav = DateTime.now();

    // Check if the notification tap set skip_picker and content_type
    Map<String, dynamic> navInfo = {};
    try {
      final gateService = ref.read(appGateServiceProvider);
      navInfo = await gateService.getGateNavigationInfo();
    } catch (e) {
      debugPrint('Gate navigation info fetch failed: $e');
    }

    if (!mounted) return;
    final skipPicker = navInfo['skip_picker'] == true;
    final contentType = navInfo['content_type'] as String?;
    final blockedAppName = navInfo['blocked_app_name'] as String?;

    // Navigate straight into the reading screen (no artificial delay).
    _router!.push(AppRoutes.gate, extra: {
      if (blockedAppName != null) 'blockedAppName': blockedAppName,
      if (skipPicker && contentType != null) 'skipPicker': true,
      if (contentType != null) 'contentType': contentType,
    });
  }

  bool _prefsSynced = false;

  void _syncPrefsToShield(dynamic prefs) {
    if (_prefsSynced) return;
    _prefsSynced = true;
    try {
      // Extract preferred content type from gateContentCategories
      final categories = (prefs.gateContentCategories as String).split(',');
      final preferredContent = categories.isNotEmpty ? categories.first : 'quran';

      final gateService = ref.read(appGateServiceProvider);
      gateService.syncPrefsToAppGroup(
        gateDurationSeconds: prefs.gateDurationSeconds,
        unlockDurationSeconds: prefs.unlockDurationSeconds,
        preferredContentType: preferredContent,
      );
      // Sync the rotating shield ayahs so the iOS shield can show one.
      gateService.syncShieldAyahs(jsonEncode(_shieldAyahs));
    } catch (e) {
      debugPrint('Sync prefs to App Group failed: $e');
    }
  }

  void _initUnlockManager() {
    if (_unlockManagerInitialized) return;
    _unlockManagerInitialized = true;

    // Set the global callback for gate navigation
    onGateTriggeredCallback = (blockedAppId, appName) {
      _navigatorKey.currentState?.pushNamed(
        AppRoutes.gate,
        arguments: {
          'blockedAppId': blockedAppId,
          'blockedAppName': appName,
        },
      );
    };

    // Initialize the unlock manager (starts listening for gated app events)
    ref.read(unlockManagerProvider).initialize();
  }

  void _scheduleIslamicReminders() {
    if (_remindersScheduled) return;
    _remindersScheduled = true;

    _lastScheduledDate = _todayString();

    // Schedule Islamic reminders asynchronously (best-effort)
    ref.read(islamicRemindersServiceProvider).scheduleAll();
  }

  /// Re-schedule prayer notifications if the date has changed since
  /// the last time we scheduled (i.e. a new day has started).
  void _refreshPrayerRemindersIfNeeded() {
    final today = _todayString();
    if (_lastScheduledDate != today) {
      _lastScheduledDate = today;
      debugPrint('New day detected — re-scheduling prayer reminders');
      ref.read(islamicRemindersServiceProvider).scheduleAll();
    }
  }

  static String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    final initAsync = ref.watch(_initPrefsProvider);

    return initAsync.when(
      loading: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: Scaffold(
          backgroundColor: AppColors.backgroundLight,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_stories, size: 48, color: AppColors.primaryLight),
                const SizedBox(height: 16),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
      error: (e, st) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text('Error initializing: $e\n\n$st',
                  textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
      data: (prefs) {
        // After init, watch the stream for live updates
        final prefsStream = ref.watch(preferencesStreamProvider);
        final currentPrefs = prefsStream.valueOrNull ?? prefs;

        final themeMode = switch (currentPrefs.themeMode) {
          'light' => ThemeMode.light,
          'dark' => ThemeMode.dark,
          _ => ThemeMode.system,
        };

        // Initialize unlock manager and schedule notifications once onboarding is complete
        if (currentPrefs.onboardingCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _initUnlockManager();
            _scheduleIslamicReminders();
            // Sync preferences to App Groups so shield extensions can read them
            if (Platform.isIOS) {
              _syncPrefsToShield(currentPrefs);
            }
            // Check if we should auto-navigate to gate on launch
            if (Platform.isIOS && !_hasCheckedGateOnLaunch) {
              _hasCheckedGateOnLaunch = true;
              _checkForGateRequest();
            }
          });
        }

        _router ??= createRouter(
          onboardingCompleted: currentPrefs.onboardingCompleted,
        );

        return MaterialApp.router(
          title: 'Niyyah',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
          locale: Locale(currentPrefs.localeCode),
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: _router,
        );
      },
    );
  }
}
