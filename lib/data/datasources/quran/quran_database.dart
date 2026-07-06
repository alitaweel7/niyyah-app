import 'package:drift/drift.dart';

import 'quran_connection.dart' as conn;

part 'quran_database.g.dart';

// ── Quran Tables (read-only, bundled) ───────────────────────────────────────

class QuranAyahs extends Table {
  IntColumn get id => integer()();
  IntColumn get surah => integer()();
  IntColumn get ayah => integer()();
  TextColumn get textUthmani => text()();
  TextColumn get textTranslationEn => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class QuranSurahs extends Table {
  IntColumn get number => integer()();
  TextColumn get nameArabic => text()();
  TextColumn get nameEnglish => text()();
  TextColumn get nameTransliteration => text()();
  IntColumn get ayahCount => integer()();
  TextColumn get revelationType => text()();
  IntColumn get revelationOrder => integer()();

  @override
  Set<Column> get primaryKey => {number};
}

class Duas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get titleArabic => text()();
  TextColumn get titleEnglish => text()();
  TextColumn get textArabic => text()();
  TextColumn get textTranslationEn => text()();
  TextColumn get source => text()();
  TextColumn get category => text()();
  BoolColumn get isFromQuran =>
      boolean().withDefault(const Constant(false))();
}

class IslamicTeachings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get hadithArabic => text().nullable()();
  TextColumn get hadithTranslation => text().nullable()();
  TextColumn get explanation => text()();
  TextColumn get sourceReference => text()();
  TextColumn get category => text()();
  BoolColumn get isPremium =>
      boolean().withDefault(const Constant(false))();
}

class QuranTranslations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ayahId => integer()();
  TextColumn get languageCode => text()();
  TextColumn get translationText => text()();
}

class AvailableLanguages extends Table {
  TextColumn get code => text()();
  TextColumn get displayName => text()();
  BoolColumn get isDownloaded =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {code};
}

class ProphetStories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get prophetNameArabic => text()();
  TextColumn get prophetNameEnglish => text()();
  IntColumn get segmentNumber => integer()();
  IntColumn get totalSegments => integer()();
  TextColumn get title => text()();
  TextColumn get bodyText => text()();
  TextColumn get sourceReference => text()();
  BoolColumn get isPremium =>
      boolean().withDefault(const Constant(false))();
}

// ── Database ────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  QuranAyahs,
  QuranSurahs,
  Duas,
  IslamicTeachings,
  ProphetStories,
  QuranTranslations,
  AvailableLanguages,
])
class QuranDatabase extends _$QuranDatabase {
  QuranDatabase() : super(conn.openQuranDb());

  QuranDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
    );
  }
}
