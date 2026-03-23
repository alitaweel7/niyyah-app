import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/app_constants.dart';

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

// ── Database ────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  QuranAyahs,
  QuranSurahs,
  Duas,
])
class QuranDatabase extends _$QuranDatabase {
  QuranDatabase() : super(_openQuranDb());

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

LazyDatabase _openQuranDb() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, AppConstants.quranDbName));

    if (!await file.exists()) {
      // Copy bundled database from assets
      final data = await rootBundle.load('assets/quran/${AppConstants.quranDbName}');
      final bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
    }

    return NativeDatabase.createInBackground(file);
  });
}
