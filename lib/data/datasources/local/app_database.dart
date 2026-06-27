import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../../core/constants/app_constants.dart';

part 'app_database.g.dart';

// ── Tables ──────────────────────────────────────────────────────────────────

class UserPreferences extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get gateDurationSeconds =>
      integer().withDefault(const Constant(300))();
  IntColumn get unlockDurationSeconds =>
      integer().withDefault(const Constant(600))();
  TextColumn get gateContentCategories =>
      text().withDefault(const Constant('quran,dua'))();
  TextColumn get quranMode =>
      text().withDefault(const Constant('short_surah'))();
  BoolColumn get showTranslation =>
      boolean().withDefault(const Constant(true))();
  RealColumn get quranFontSize =>
      real().withDefault(const Constant(28.0))();
  TextColumn get translationLanguage =>
      text().withDefault(const Constant('en'))();
  TextColumn get themeMode =>
      text().withDefault(const Constant('system'))();
  IntColumn get pauseUntilTimestamp => integer().nullable()();
  IntColumn get sequentialPositionSurah =>
      integer().withDefault(const Constant(1))();
  IntColumn get sequentialPositionAyah =>
      integer().withDefault(const Constant(1))();
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();
  IntColumn get streakCurrent =>
      integer().withDefault(const Constant(0))();
  TextColumn get streakLastDate => text().nullable()();

  // Notification preferences
  BoolColumn get notifyPrayerTimes =>
      boolean().withDefault(const Constant(true))();
  IntColumn get notifyPrayerAdvanceMinutes =>
      integer().withDefault(const Constant(0))();
  BoolColumn get notifyFridayKahf =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyFastingDays =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyMorningAdhkar =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyEveningAdhkar =>
      boolean().withDefault(const Constant(true))();

  // Extended notification preferences (v3)
  BoolColumn get notifyBedtimeDua =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifySurahMulk =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyDuhaReminder =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyTahajjud =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyDhikrAfterPrayer =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get notifyDuaForParents =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyFridaySalawat =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyFridayDuaHour =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyDidYouKnow =>
      boolean().withDefault(const Constant(true))();
  IntColumn get bedtimeHour =>
      integer().withDefault(const Constant(22))();
  IntColumn get bedtimeMinute =>
      integer().withDefault(const Constant(0))();

  // Prayer calculation method (v4) — 'auto' uses location-based detection
  TextColumn get prayerCalculationMethod =>
      text().withDefault(const Constant('auto'))();

  // Asr madhab (v5): 'shafi' (earlier Asr) or 'hanafi' (later Asr)
  TextColumn get madhab =>
      text().withDefault(const Constant('shafi'))();

  // App UI language (v7): 'en' or 'ar'
  TextColumn get localeCode =>
      text().withDefault(const Constant('en'))();

  @override
  Set<Column> get primaryKey => {id};
}

class BlockedApps extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get packageName => text()();
  TextColumn get displayName => text()();
  TextColumn get iconKey => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get platform => text()();
  TextColumn get createdAt => text()();
}

class GateSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get blockedAppId =>
      integer().nullable().references(BlockedApps, #id)();
  TextColumn get startedAt => text()();
  TextColumn get completedAt => text().nullable()();
  IntColumn get durationSeconds => integer()();
  IntColumn get actualDurationSeconds => integer().nullable()();
  TextColumn get gateContentType => text()();
  IntColumn get quranSurah => integer().nullable()();
  IntColumn get quranAyahStart => integer().nullable()();
  IntColumn get quranAyahEnd => integer().nullable()();
  IntColumn get duaId => integer().nullable()();
  IntColumn get storyId => integer().nullable()();
  IntColumn get teachingId => integer().nullable()();
  IntColumn get sahabahStoryId => integer().nullable()();
  IntColumn get historyId => integer().nullable()();
  IntColumn get extraReadingSeconds =>
      integer().withDefault(const Constant(0))();
  BoolColumn get wasCompleted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get continuedReading =>
      boolean().withDefault(const Constant(false))();
}

class UnlockSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get gateSessionId =>
      integer().references(GateSessions, #id)();
  IntColumn get blockedAppId =>
      integer().references(BlockedApps, #id)();
  TextColumn get startedAt => text()();
  TextColumn get expiresAt => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class ReadingProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contentType => text()();
  IntColumn get contentId => integer()();
  TextColumn get firstReadAt => text()();
  TextColumn get lastReadAt => text()();
  IntColumn get timesRead => integer().withDefault(const Constant(1))();
  IntColumn get totalReadingSeconds =>
      integer().withDefault(const Constant(0))();
  BoolColumn get isFavorite =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isMemorized =>
      boolean().withDefault(const Constant(false))();
}

class SurahProgress extends Table {
  IntColumn get surahNumber => integer()();
  IntColumn get ayahsRead => integer().withDefault(const Constant(0))();
  IntColumn get totalAyahs => integer()();
  BoolColumn get isCompleted =>
      boolean().withDefault(const Constant(false))();
  TextColumn get completedAt => text().nullable()();

  @override
  Set<Column> get primaryKey => {surahNumber};
}

/// Distinct ayahs the user has actually read (v5).
/// [globalAyahId] is the 1..6236 id from the bundled Quran DB (QuranAyah.id),
/// so true Quran completion = count(ReadAyahs) / 6236. Insert is idempotent
/// (ignore conflicts) so re-reading never inflates progress.
class ReadAyahs extends Table {
  IntColumn get globalAyahId => integer()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  TextColumn get firstReadAt => text()();

  @override
  Set<Column> get primaryKey => {globalAyahId};
}

/// Append-only log of reading activity (v5) — powers an accurate ordered
/// timeline regardless of sequential vs random mode.
class ReadingEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contentType => text()(); // 'quran' | 'dua' | ...
  IntColumn get surahNumber => integer().nullable()();
  IntColumn get ayahStart => integer().nullable()();
  IntColumn get ayahEnd => integer().nullable()();
  IntColumn get duaId => integer().nullable()();
  TextColumn get readAt => text()();
  IntColumn get seconds => integer().withDefault(const Constant(0))();
}

/// Logs which of the day's five obligatory prayers the user marked as prayed (v6).
class PrayerLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()(); // local 'YYYY-MM-DD'
  TextColumn get prayer => text()(); // fajr | dhuhr | asr | maghrib | isha
  TextColumn get prayedAt => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {date, prayer}
      ];
}

// ── Database ────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  UserPreferences,
  BlockedApps,
  GateSessions,
  UnlockSessions,
  ReadingProgress,
  SurahProgress,
  ReadAyahs,
  ReadingEvents,
  PrayerLogs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Insert default preferences row
        await into(userPreferences).insert(
          UserPreferencesCompanion.insert(),
        );
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Add notification preference columns
          await m.addColumn(userPreferences, userPreferences.notifyPrayerTimes);
          await m.addColumn(userPreferences, userPreferences.notifyPrayerAdvanceMinutes);
          await m.addColumn(userPreferences, userPreferences.notifyFridayKahf);
          await m.addColumn(userPreferences, userPreferences.notifyFastingDays);
          await m.addColumn(userPreferences, userPreferences.notifyMorningAdhkar);
          await m.addColumn(userPreferences, userPreferences.notifyEveningAdhkar);
        }
        if (from < 3) {
          // Add extended notification preference columns
          await m.addColumn(userPreferences, userPreferences.notifyBedtimeDua);
          await m.addColumn(userPreferences, userPreferences.notifySurahMulk);
          await m.addColumn(userPreferences, userPreferences.notifyDuhaReminder);
          await m.addColumn(userPreferences, userPreferences.notifyTahajjud);
          await m.addColumn(userPreferences, userPreferences.notifyDhikrAfterPrayer);
          await m.addColumn(userPreferences, userPreferences.notifyDuaForParents);
          await m.addColumn(userPreferences, userPreferences.notifyFridaySalawat);
          await m.addColumn(userPreferences, userPreferences.notifyFridayDuaHour);
          await m.addColumn(userPreferences, userPreferences.notifyDidYouKnow);
          await m.addColumn(userPreferences, userPreferences.bedtimeHour);
          await m.addColumn(userPreferences, userPreferences.bedtimeMinute);
        }
        if (from < 4) {
          await m.addColumn(userPreferences, userPreferences.prayerCalculationMethod);
        }
        if (from < 5) {
          await m.addColumn(userPreferences, userPreferences.madhab);
          await m.createTable(readAyahs);
          await m.createTable(readingEvents);
        }
        if (from < 6) {
          await m.createTable(prayerLogs);
        }
        if (from < 7) {
          await m.addColumn(userPreferences, userPreferences.localeCode);
        }
      },
    );
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: AppConstants.appDbName,
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}
