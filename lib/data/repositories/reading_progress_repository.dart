import 'package:drift/drift.dart';

import '../datasources/local/app_database.dart';

class ReadingProgressRepository {
  ReadingProgressRepository(this._db);

  final AppDatabase _db;

  // ── Reading Progress ──────────────────────────────────────────────────

  Future<void> recordReading({
    required String contentType,
    required int contentId,
    required int readingSeconds,
  }) async {
    final existing = await (_db.select(_db.readingProgress)
          ..where((t) =>
              t.contentType.equals(contentType) &
              t.contentId.equals(contentId)))
        .get();

    final now = DateTime.now().toIso8601String();

    if (existing.isEmpty) {
      await _db.into(_db.readingProgress).insert(
        ReadingProgressCompanion.insert(
          contentType: contentType,
          contentId: contentId,
          firstReadAt: now,
          lastReadAt: now,
          totalReadingSeconds: Value(readingSeconds),
        ),
      );
    } else {
      await (_db.update(_db.readingProgress)
            ..where((t) => t.id.equals(existing.first.id)))
          .write(ReadingProgressCompanion(
        lastReadAt: Value(now),
        timesRead: Value(existing.first.timesRead + 1),
        totalReadingSeconds:
            Value(existing.first.totalReadingSeconds + readingSeconds),
      ));
    }
  }

  Future<void> toggleFavorite(int progressId, bool isFavorite) async {
    await (_db.update(_db.readingProgress)
          ..where((t) => t.id.equals(progressId)))
        .write(ReadingProgressCompanion(isFavorite: Value(isFavorite)));
  }

  Future<void> toggleMemorized(int progressId, bool isMemorized) async {
    await (_db.update(_db.readingProgress)
          ..where((t) => t.id.equals(progressId)))
        .write(ReadingProgressCompanion(isMemorized: Value(isMemorized)));
  }

  Future<List<ReadingProgressData>> getProgressByType(String contentType) {
    return (_db.select(_db.readingProgress)
          ..where((t) => t.contentType.equals(contentType))
          ..orderBy([(t) => OrderingTerm.desc(t.lastReadAt)]))
        .get();
  }

  Future<List<ReadingProgressData>> getFavorites() {
    return (_db.select(_db.readingProgress)
          ..where((t) => t.isFavorite.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.lastReadAt)]))
        .get();
  }

  Future<int> getTotalReadingSeconds() async {
    final result = await _db.customSelect(
      'SELECT COALESCE(SUM(total_reading_seconds), 0) as total FROM reading_progress',
    ).getSingle();
    return result.read<int>('total');
  }

  Future<int> getUniqueContentCount(String contentType) async {
    final result = await _db.customSelect(
      'SELECT COUNT(*) as count FROM reading_progress WHERE content_type = ?',
      variables: [Variable.withString(contentType)],
    ).getSingle();
    return result.read<int>('count');
  }

  // ── Surah Progress ────────────────────────────────────────────────────

  Future<void> recordSurahAyahRead(int surahNumber, int totalAyahs) async {
    final existing = await (_db.select(_db.surahProgress)
          ..where((t) => t.surahNumber.equals(surahNumber)))
        .get();

    if (existing.isEmpty) {
      await _db.into(_db.surahProgress).insert(
        SurahProgressCompanion.insert(
          surahNumber: Value(surahNumber),
          totalAyahs: totalAyahs,
          ayahsRead: const Value(1),
        ),
      );
    } else {
      final newCount = existing.first.ayahsRead + 1;
      final isCompleted = newCount >= totalAyahs;
      await (_db.update(_db.surahProgress)
            ..where((t) => t.surahNumber.equals(surahNumber)))
          .write(SurahProgressCompanion(
        ayahsRead: Value(newCount),
        isCompleted: Value(isCompleted),
        completedAt: isCompleted
            ? Value(DateTime.now().toIso8601String())
            : const Value.absent(),
      ));
    }
  }

  Future<List<SurahProgressData>> getAllSurahProgress() {
    return (_db.select(_db.surahProgress)
          ..orderBy([(t) => OrderingTerm.asc(t.surahNumber)]))
        .get();
  }

  Future<int> getCompletedSurahCount() async {
    final result = await _db.customSelect(
      'SELECT COUNT(*) as count FROM surah_progress WHERE is_completed = 1',
    ).getSingle();
    return result.read<int>('count');
  }

  Future<int> getTotalAyahsRead() async {
    final result = await _db.customSelect(
      'SELECT COALESCE(SUM(ayahs_read), 0) as total FROM surah_progress',
    ).getSingle();
    return result.read<int>('total');
  }
}
