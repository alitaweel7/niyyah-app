import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/quran/quran_database.dart';
import '../../data/repositories/blocked_app_repository.dart';
import '../../data/repositories/dua_repository.dart';
import '../../data/repositories/gate_session_repository.dart';
import '../../data/repositories/preferences_repository.dart';
import '../../data/repositories/quran_repository.dart';
import '../../data/repositories/hadith_repository.dart';
import '../../data/repositories/reading_progress_repository.dart';
import '../../data/repositories/prayer_tracker_repository.dart';
import '../../services/location_service.dart';
import '../../services/prayer_times_service.dart';
import '../../services/islamic_reminders_service.dart';
import '../../services/platform/app_gate_service.dart';
import '../../services/platform/app_gate_service_impl.dart';
import '../../services/platform/app_gate_service_stub.dart';
import '../../services/unlock_manager.dart';

// ── Databases ───────────────────────────────────────────────────────────────

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final quranDatabaseProvider = Provider<QuranDatabase>((ref) {
  final db = QuranDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// ── Repositories ────────────────────────────────────────────────────────────

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return PreferencesRepository(ref.watch(appDatabaseProvider));
});

final quranRepositoryProvider = Provider<QuranRepository>((ref) {
  return QuranRepository(ref.watch(quranDatabaseProvider));
});

final duaRepositoryProvider = Provider<DuaRepository>((ref) {
  return DuaRepository(ref.watch(quranDatabaseProvider));
});

final gateSessionRepositoryProvider = Provider<GateSessionRepository>((ref) {
  return GateSessionRepository(ref.watch(appDatabaseProvider));
});

final blockedAppRepositoryProvider = Provider<BlockedAppRepository>((ref) {
  return BlockedAppRepository(ref.watch(appDatabaseProvider));
});

final readingProgressRepositoryProvider =
    Provider<ReadingProgressRepository>((ref) {
  return ReadingProgressRepository(ref.watch(appDatabaseProvider));
});

final prayerTrackerRepositoryProvider =
    Provider<PrayerTrackerRepository>((ref) {
  return PrayerTrackerRepository(ref.watch(appDatabaseProvider));
});

final hadithRepositoryProvider = Provider<HadithRepository>((ref) {
  return HadithRepository(ref.watch(quranDatabaseProvider));
});

// ── Platform Services ───────────────────────────────────────────────────

final appGateServiceProvider = Provider<AppGateService>((ref) {
  if (kIsWeb) return StubAppGateService();
  return MethodChannelAppGateService();
});

// ── Preferences Stream ──────────────────────────────────────────────────────

final preferencesStreamProvider = StreamProvider((ref) {
  return ref.watch(preferencesRepositoryProvider).watchPreferences();
});

// ── Blocked Apps Stream ─────────────────────────────────────────────────────

final blockedAppsStreamProvider = StreamProvider((ref) {
  return ref.watch(blockedAppRepositoryProvider).watchActiveBlockedApps();
});

// ── Dashboard Stats ────────────────────────────────────────────────────

final todayGateCountProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(gateSessionRepositoryProvider).getTodayGateCount();
});

final todayReadingSecondsProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(gateSessionRepositoryProvider).getTodayTotalReadingSeconds();
});

// ── Learning Stats ─────────────────────────────────────────────────────

final totalAyahsReadProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(readingProgressRepositoryProvider).getDistinctAyahsRead();
});

final completedSurahCountProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(readingProgressRepositoryProvider).getCompletedSurahCount();
});

final duasReadCountProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(readingProgressRepositoryProvider).getUniqueContentCount('dua');
});

final surahProgressListProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(readingProgressRepositoryProvider).getAllSurahProgress();
});

final totalReadingSecondsProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(readingProgressRepositoryProvider).getTotalReadingSeconds();
});

/// Aggregated, accurate Quran reading progress derived from distinct read ayahs.
class QuranProgress {
  const QuranProgress({
    required this.distinctAyahsRead,
    required this.completedSurahNumbers,
  });

  final int distinctAyahsRead;
  final List<int> completedSurahNumbers;

  static const int totalAyahs = 6236;
  int get completedSurahCount => completedSurahNumbers.length;
  double get percent => totalAyahs == 0 ? 0 : distinctAyahsRead / totalAyahs;
}

final quranProgressProvider =
    FutureProvider.autoDispose<QuranProgress>((ref) async {
  final repo = ref.watch(readingProgressRepositoryProvider);
  final quranRepo = ref.watch(quranRepositoryProvider);
  final distinct = await repo.getDistinctAyahsRead();
  final counts = await repo.getReadAyahCountsBySurah();
  final surahs = await quranRepo.getAllSurahs();
  final completed = <int>[
    for (final s in surahs)
      if ((counts[s.number] ?? 0) >= s.ayahCount) s.number,
  ]..sort();
  return QuranProgress(
    distinctAyahsRead: distinct,
    completedSurahNumbers: completed,
  );
});

// ── History ────────────────────────────────────────────────────────────

final recentSessionsProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(gateSessionRepositoryProvider).getRecentSessions(limit: 50);
});

// ── Location ──────────────────────────────────────────────────────────

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

/// Fetches the user's location once and caches the result.
/// Auto-disposes so it re-runs when the dashboard is revisited.
final userLocationProvider = FutureProvider.autoDispose<UserLocation>((ref) {
  return ref.watch(locationServiceProvider).getCurrentLocation();
});

// ── Prayer Times (location-aware) ─────────────────────────────────────

final prayerTimesProvider = FutureProvider.autoDispose<PrayerTimesResult?>((ref) async {
  final location = await ref.watch(userLocationProvider.future);
  final prefs = await ref.watch(preferencesStreamProvider.future);
  final service = PrayerTimesService();
  return service.getTodayPrayerTimes(
    latitude: location.latitude,
    longitude: location.longitude,
    calculationMethod: prefs.prayerCalculationMethod,
    countryCode: location.countryCode,
    madhab: prefs.madhab,
  );
});

// ── Prayer Tracker ─────────────────────────────────────────────────────

/// Live set of prayer names ('fajr'..'isha') the user has marked today.
final todayPrayerLogProvider = StreamProvider.autoDispose<Set<String>>((ref) {
  final today = PrayerTrackerRepository.dateKey(DateTime.now());
  return ref.watch(prayerTrackerRepositoryProvider).watchPrayedForDate(today);
});

/// Consecutive days where all five prayers were logged.
final prayerStreakProvider = FutureProvider.autoDispose<int>((ref) {
  ref.watch(todayPrayerLogProvider); // recompute when today's log changes
  return ref.watch(prayerTrackerRepositoryProvider).getPrayerStreak();
});

// ── Islamic Reminders ──────────────────────────────────────────────────

final islamicRemindersServiceProvider = Provider<IslamicRemindersService>((ref) {
  return IslamicRemindersService(
    preferencesRepo: ref.watch(preferencesRepositoryProvider),
  );
});

// ── Unlock Manager ─────────────────────────────────────────────────────

/// Global callback that gets set by the app's root widget to navigate
/// to the gate screen when a gated app is detected.
void Function(int blockedAppId, String appName)? onGateTriggeredCallback;

final unlockManagerProvider = Provider<UnlockManager>((ref) {
  final manager = UnlockManager(
    gateService: ref.watch(appGateServiceProvider),
    gateSessionRepo: ref.watch(gateSessionRepositoryProvider),
    blockedAppRepo: ref.watch(blockedAppRepositoryProvider),
    preferencesRepo: ref.watch(preferencesRepositoryProvider),
    onGateTriggered: (blockedAppId, appName) {
      onGateTriggeredCallback?.call(blockedAppId, appName);
    },
  );
  ref.onDispose(() => manager.dispose());
  return manager;
});
