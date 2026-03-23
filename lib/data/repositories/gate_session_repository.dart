import 'package:drift/drift.dart';

import '../datasources/local/app_database.dart';

class GateSessionRepository {
  GateSessionRepository(this._db);

  final AppDatabase _db;

  // ── Gate Sessions ─────────────────────────────────────────────────────

  Future<int> createGateSession({
    int? blockedAppId,
    required int durationSeconds,
    required String gateContentType,
    int? quranSurah,
    int? quranAyahStart,
    int? quranAyahEnd,
    int? duaId,
    int? storyId,
    int? teachingId,
    int? sahabahStoryId,
    int? historyId,
  }) async {
    return _db.into(_db.gateSessions).insert(
      GateSessionsCompanion.insert(
        blockedAppId: Value(blockedAppId),
        startedAt: DateTime.now().toIso8601String(),
        durationSeconds: durationSeconds,
        gateContentType: gateContentType,
        quranSurah: Value(quranSurah),
        quranAyahStart: Value(quranAyahStart),
        quranAyahEnd: Value(quranAyahEnd),
        duaId: Value(duaId),
        storyId: Value(storyId),
        teachingId: Value(teachingId),
        sahabahStoryId: Value(sahabahStoryId),
        historyId: Value(historyId),
      ),
    );
  }

  Future<void> completeGateSession({
    required int sessionId,
    required int actualDurationSeconds,
    int extraReadingSeconds = 0,
    bool continuedReading = false,
  }) async {
    await (_db.update(_db.gateSessions)
          ..where((t) => t.id.equals(sessionId)))
        .write(GateSessionsCompanion(
      completedAt: Value(DateTime.now().toIso8601String()),
      actualDurationSeconds: Value(actualDurationSeconds),
      extraReadingSeconds: Value(extraReadingSeconds),
      wasCompleted: const Value(true),
      continuedReading: Value(continuedReading),
    ));
  }

  Future<List<GateSession>> getSessionsForDate(DateTime date) async {
    final dateStr = _dateString(date);
    return (_db.select(_db.gateSessions)
          ..where((t) => t.startedAt.like('$dateStr%'))
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .get();
  }

  Future<List<GateSession>> getRecentSessions({int limit = 50}) {
    return (_db.select(_db.gateSessions)
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
          ..limit(limit))
        .get();
  }

  Future<List<GateSession>> getCompletedSessionsForDate(DateTime date) async {
    final dateStr = _dateString(date);
    return (_db.select(_db.gateSessions)
          ..where(
              (t) => t.startedAt.like('$dateStr%') & t.wasCompleted.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .get();
  }

  // ── Stats ─────────────────────────────────────────────────────────────

  Future<int> getTodayGateCount() async {
    final dateStr = _dateString(DateTime.now());
    final result = await _db.customSelect(
      'SELECT COUNT(*) as count FROM gate_sessions WHERE started_at LIKE ? AND was_completed = 1',
      variables: [Variable.withString('$dateStr%')],
    ).getSingle();
    return result.read<int>('count');
  }

  Future<int> getTodayTotalReadingSeconds() async {
    final dateStr = _dateString(DateTime.now());
    final result = await _db.customSelect(
      'SELECT COALESCE(SUM(COALESCE(actual_duration_seconds, 0) + extra_reading_seconds), 0) as total '
      'FROM gate_sessions WHERE started_at LIKE ? AND was_completed = 1',
      variables: [Variable.withString('$dateStr%')],
    ).getSingle();
    return result.read<int>('total');
  }

  Future<int> getTotalExtraReadingSeconds() async {
    final result = await _db.customSelect(
      'SELECT COALESCE(SUM(extra_reading_seconds), 0) as total FROM gate_sessions',
    ).getSingle();
    return result.read<int>('total');
  }

  // ── Unlock Sessions ───────────────────────────────────────────────────

  Future<int> createUnlockSession({
    required int gateSessionId,
    required int blockedAppId,
    required int durationSeconds,
  }) async {
    final now = DateTime.now();
    final expiresAt = now.add(Duration(seconds: durationSeconds));

    return _db.into(_db.unlockSessions).insert(
      UnlockSessionsCompanion.insert(
        gateSessionId: gateSessionId,
        blockedAppId: blockedAppId,
        startedAt: now.toIso8601String(),
        expiresAt: expiresAt.toIso8601String(),
      ),
    );
  }

  Future<UnlockSession?> getActiveUnlockForApp(int blockedAppId) async {
    final now = DateTime.now().toIso8601String();
    final results = await (_db.select(_db.unlockSessions)
          ..where((t) =>
              t.blockedAppId.equals(blockedAppId) &
              t.isActive.equals(true) &
              t.expiresAt.isBiggerThanValue(now)))
        .get();
    return results.isEmpty ? null : results.first;
  }

  Future<List<UnlockSession>> getActiveUnlocks() async {
    final now = DateTime.now().toIso8601String();
    return (_db.select(_db.unlockSessions)
          ..where(
              (t) => t.isActive.equals(true) & t.expiresAt.isBiggerThanValue(now)))
        .get();
  }

  Future<void> expireUnlockSession(int sessionId) async {
    await (_db.update(_db.unlockSessions)
          ..where((t) => t.id.equals(sessionId)))
        .write(const UnlockSessionsCompanion(
      isActive: Value(false),
    ));
  }

  Future<void> expireAllUnlocks() async {
    await (_db.update(_db.unlockSessions)
          ..where((t) => t.isActive.equals(true)))
        .write(const UnlockSessionsCompanion(
      isActive: Value(false),
    ));
  }

  // ── Helpers ───────────────────────────────────────────────────────────

  String _dateString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
