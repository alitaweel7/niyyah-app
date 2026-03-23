import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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

// ── Database ────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  UserPreferences,
  BlockedApps,
  GateSessions,
  UnlockSessions,
  ReadingProgress,
  SurahProgress,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

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
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, AppConstants.appDbName));
    return NativeDatabase.createInBackground(file);
  });
}
