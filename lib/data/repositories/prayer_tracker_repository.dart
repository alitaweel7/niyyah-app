import 'package:drift/drift.dart';

import '../../core/utils/streak_logic.dart';
import '../datasources/local/app_database.dart';

/// Tracks which of the five daily obligatory prayers the user has marked as
/// prayed, per day, and computes a daily prayer streak.
class PrayerTrackerRepository {
  PrayerTrackerRepository(this._db);

  final AppDatabase _db;

  /// The five obligatory prayers, in order.
  static const List<String> prayers = [
    'fajr',
    'dhuhr',
    'asr',
    'maghrib',
    'isha',
  ];

  /// Local date key 'YYYY-MM-DD' (canonical implementation: streak_logic.dart).
  static String dateKey(DateTime d) => formatStreakDate(d);

  Future<void> markPrayed(String date, String prayer) async {
    await _db.into(_db.prayerLogs).insert(
          PrayerLogsCompanion.insert(
            date: date,
            prayer: prayer,
            prayedAt: DateTime.now().toIso8601String(),
          ),
          mode: InsertMode.insertOrIgnore, // unique (date, prayer)
        );
  }

  Future<void> unmarkPrayed(String date, String prayer) async {
    await (_db.delete(_db.prayerLogs)
          ..where((t) => t.date.equals(date) & t.prayer.equals(prayer)))
        .go();
  }

  Future<void> togglePrayed(String date, String prayer, bool prayed) =>
      prayed ? markPrayed(date, prayer) : unmarkPrayed(date, prayer);

  /// Live set of prayers marked for [date].
  Stream<Set<String>> watchPrayedForDate(String date) {
    return (_db.select(_db.prayerLogs)..where((t) => t.date.equals(date)))
        .watch()
        .map((rows) => rows.map((r) => r.prayer).toSet());
  }

  Future<Set<String>> getPrayedForDate(String date) async {
    final rows = await (_db.select(_db.prayerLogs)
          ..where((t) => t.date.equals(date)))
        .get();
    return rows.map((r) => r.prayer).toSet();
  }

  /// Consecutive days where all five prayers were logged. Today is allowed to
  /// be incomplete without breaking the streak (it just isn't counted yet).
  Future<int> getPrayerStreak() async {
    final rows = await _db.select(_db.prayerLogs).get();
    final byDate = <String, Set<String>>{};
    for (final r in rows) {
      byDate.putIfAbsent(r.date, () => <String>{}).add(r.prayer);
    }
    var streak = 0;
    var day = DateTime.now();
    if (!_allPrayed(byDate[dateKey(day)])) {
      day = day.subtract(const Duration(days: 1));
    }
    while (_allPrayed(byDate[dateKey(day)])) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }

  bool _allPrayed(Set<String>? set) =>
      set != null && prayers.every(set.contains);
}
