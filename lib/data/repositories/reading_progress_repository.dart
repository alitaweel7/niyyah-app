import 'package:drift/drift.dart';

import '../datasources/local/app_database.dart';
import '../datasources/quran/quran_database.dart';

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

  // ── Read Ayahs (distinct — the source of truth for true completion) ────

  /// Marks the given ayahs as read. Idempotent: re-reading the same ayahs
  /// never inflates progress (insertOrIgnore on the globalAyahId primary key).
  Future<void> markAyahsRead(List<QuranAyah> ayahs) async {
    if (ayahs.isEmpty) return;
    final now = DateTime.now().toIso8601String();
    await _db.batch((b) {
      b.insertAll(
        _db.readAyahs,
        ayahs.map((a) => ReadAyahsCompanion.insert(
              globalAyahId: Value(a.id),
              surahNumber: a.surah,
              ayahNumber: a.ayah,
              firstReadAt: now,
            )),
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  /// Count of distinct ayahs ever read — numerator for "% of the Quran read".
  Future<int> getDistinctAyahsRead() async {
    final result = await _db
        .customSelect('SELECT COUNT(*) as count FROM read_ayahs')
        .getSingle();
    return result.read<int>('count');
  }

  /// Distinct read-ayah counts grouped by surah (for completion + ordered view).
  Future<Map<int, int>> getReadAyahCountsBySurah() async {
    final rows = await _db
        .customSelect(
            'SELECT surah_number AS s, COUNT(*) AS c FROM read_ayahs GROUP BY surah_number')
        .get();
    return {for (final r in rows) r.read<int>('s'): r.read<int>('c')};
  }

  // ── Reading Events (append-only timeline) ─────────────────────────────

  Future<void> logReadingEvent({
    required String contentType,
    int? surahNumber,
    int? ayahStart,
    int? ayahEnd,
    int? duaId,
    required int seconds,
  }) async {
    await _db.into(_db.readingEvents).insert(
          ReadingEventsCompanion.insert(
            contentType: contentType,
            surahNumber: Value(surahNumber),
            ayahStart: Value(ayahStart),
            ayahEnd: Value(ayahEnd),
            duaId: Value(duaId),
            readAt: DateTime.now().toIso8601String(),
            seconds: Value(seconds),
          ),
        );
  }

  Future<List<ReadingEvent>> getRecentEvents({int limit = 50}) {
    return (_db.select(_db.readingEvents)
          ..orderBy([(t) => OrderingTerm.desc(t.readAt)])
          ..limit(limit))
        .get();
  }

  // ── One-time backfill (preserve pre-v5 progress) ──────────────────────

  Future<bool> hasAnyReadAyahs() async => (await getDistinctAyahsRead()) > 0;

  /// Pre-v5 only stored per-surah counts (not which ayahs). Approximate that
  /// history into the new distinct model by marking the first N ayahs of each
  /// surah read — which also maps it into Quran order, as the owner wants.
  Future<void> backfillFromSurahProgress(
      Future<List<QuranAyah>> Function(int surah) ayahsForSurah) async {
    final rows = await _db.select(_db.surahProgress).get();
    for (final row in rows) {
      if (row.ayahsRead <= 0) continue;
      final ayahs = await ayahsForSurah(row.surahNumber);
      if (ayahs.isEmpty) continue;
      await markAyahsRead(ayahs.take(row.ayahsRead).toList());
    }
  }
}
