import 'dart:math';

import 'package:drift/drift.dart';

import '../datasources/quran/quran_database.dart';

class HadithRepository {
  HadithRepository(this._db);

  final QuranDatabase _db;
  final _random = Random();

  /// Get a random hadith/teaching.
  Future<IslamicTeaching> getRandomHadith() async {
    final count = await (_db.selectOnly(_db.islamicTeachings)
          ..addColumns([_db.islamicTeachings.id.count()]))
        .getSingle();
    final total = count.read(_db.islamicTeachings.id.count()) ?? 0;

    if (total == 0) throw Exception('No hadiths in database');

    final offset = _random.nextInt(total);
    final result = await (_db.select(_db.islamicTeachings)
          ..limit(1, offset: offset))
        .getSingle();
    return result;
  }

  /// Get a random hadith by category.
  Future<IslamicTeaching> getRandomHadithByCategory(String category) async {
    final hadiths = await (_db.select(_db.islamicTeachings)
          ..where((t) => t.category.equals(category)))
        .get();

    if (hadiths.isEmpty) return getRandomHadith();
    return hadiths[_random.nextInt(hadiths.length)];
  }

  /// Get all hadiths for a specific category.
  Future<List<IslamicTeaching>> getHadithsByCategory(String category) {
    return (_db.select(_db.islamicTeachings)
          ..where((t) => t.category.equals(category))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  /// Get total hadith count.
  Future<int> getTotalCount() async {
    final result = await _db.customSelect(
      'SELECT COUNT(*) as count FROM islamic_teachings',
    ).getSingle();
    return result.read<int>('count');
  }

  /// Get all categories with counts.
  Future<Map<String, int>> getCategoryCounts() async {
    final results = await _db.customSelect(
      'SELECT category, COUNT(*) as count FROM islamic_teachings GROUP BY category ORDER BY count DESC',
    ).get();

    return {
      for (final row in results)
        row.read<String>('category'): row.read<int>('count'),
    };
  }

  /// Get a sequential hadith (for continuous reading).
  /// Returns hadiths starting from the given ID.
  Future<List<IslamicTeaching>> getSequentialHadiths(int fromId,
      {int count = 5}) async {
    return (_db.select(_db.islamicTeachings)
          ..where((t) => t.id.isBiggerOrEqualValue(fromId))
          ..orderBy([(t) => OrderingTerm.asc(t.id)])
          ..limit(count))
        .get();
  }
}
