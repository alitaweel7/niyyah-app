import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aya_unlock/data/datasources/local/app_database.dart';
import 'package:aya_unlock/data/repositories/gate_session_repository.dart';

void main() {
  late AppDatabase db;
  late GateSessionRepository repo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = GateSessionRepository(db);

    // Insert default preferences (needed by schema)
    await db.into(db.userPreferences).insert(
      UserPreferencesCompanion.insert(),
    );
  });

  tearDown(() => db.close());

  group('GateSessionRepository', () {
    test('creates and completes a gate session', () async {
      final sessionId = await repo.createGateSession(
        durationSeconds: 300,
        gateContentType: 'quran',
        quranSurah: 1,
        quranAyahStart: 1,
        quranAyahEnd: 7,
      );

      expect(sessionId, greaterThan(0));

      await repo.completeGateSession(
        sessionId: sessionId,
        actualDurationSeconds: 310,
        extraReadingSeconds: 10,
        continuedReading: true,
      );

      final sessions = await repo.getRecentSessions(limit: 10);
      expect(sessions, hasLength(1));
      expect(sessions.first.wasCompleted, isTrue);
      expect(sessions.first.actualDurationSeconds, 310);
      expect(sessions.first.extraReadingSeconds, 10);
      expect(sessions.first.continuedReading, isTrue);
    });

    test('getTodayGateCount returns correct count', () async {
      // Create 3 sessions, complete 2
      final id1 = await repo.createGateSession(
        durationSeconds: 60,
        gateContentType: 'quran',
      );
      await repo.completeGateSession(sessionId: id1, actualDurationSeconds: 60);

      final id2 = await repo.createGateSession(
        durationSeconds: 60,
        gateContentType: 'dua',
      );
      await repo.completeGateSession(sessionId: id2, actualDurationSeconds: 65);

      // Third session not completed (abandoned)
      await repo.createGateSession(
        durationSeconds: 300,
        gateContentType: 'quran',
      );

      final count = await repo.getTodayGateCount();
      expect(count, 2); // Only completed sessions
    });

    test('getTodayTotalReadingSeconds sums correctly', () async {
      final id1 = await repo.createGateSession(
        durationSeconds: 60,
        gateContentType: 'quran',
      );
      await repo.completeGateSession(
        sessionId: id1,
        actualDurationSeconds: 60,
        extraReadingSeconds: 30,
      );

      final id2 = await repo.createGateSession(
        durationSeconds: 120,
        gateContentType: 'dua',
      );
      await repo.completeGateSession(
        sessionId: id2,
        actualDurationSeconds: 120,
        extraReadingSeconds: 0,
      );

      final total = await repo.getTodayTotalReadingSeconds();
      expect(total, 210); // 60+30 + 120+0
    });

    test('unlock session lifecycle', () async {
      // Add a blocked app first
      final appId = await db.into(db.blockedApps).insert(
        BlockedAppsCompanion.insert(
          packageName: 'com.instagram.android',
          displayName: 'Instagram',
          platform: 'android',
          createdAt: DateTime.now().toIso8601String(),
        ),
      );

      final gateId = await repo.createGateSession(
        blockedAppId: appId,
        durationSeconds: 300,
        gateContentType: 'quran',
      );
      await repo.completeGateSession(sessionId: gateId, actualDurationSeconds: 300);

      // Create unlock
      await repo.createUnlockSession(
        gateSessionId: gateId,
        blockedAppId: appId,
        durationSeconds: 600,
      );

      final active = await repo.getActiveUnlockForApp(appId);
      expect(active, isNotNull);

      // Get all active
      final allActive = await repo.getActiveUnlocks();
      expect(allActive, hasLength(1));

      // Expire
      await repo.expireUnlockSession(active!.id);
      final afterExpire = await repo.getActiveUnlockForApp(appId);
      expect(afterExpire, isNull);
    });
  });
}
