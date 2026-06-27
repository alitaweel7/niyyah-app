import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aya_unlock/data/datasources/local/app_database.dart';
import 'package:aya_unlock/data/models/gate_content_type.dart';
import 'package:aya_unlock/data/repositories/preferences_repository.dart';

void main() {
  late AppDatabase db;
  late PreferencesRepository repo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = PreferencesRepository(db);
  });

  tearDown(() => db.close());

  group('PreferencesRepository', () {
    test('returns default preferences', () async {
      final prefs = await repo.getPreferences();
      expect(prefs.gateDurationSeconds, 300);
      expect(prefs.unlockDurationSeconds, 600);
      expect(prefs.showTranslation, true);
      expect(prefs.themeMode, 'system');
      expect(prefs.onboardingCompleted, false);
      expect(prefs.streakCurrent, 0);
    });

    test('updates gate duration', () async {
      await repo.updateGateDuration(60);
      final prefs = await repo.getPreferences();
      expect(prefs.gateDurationSeconds, 60);
    });

    test('updates content categories', () async {
      await repo.updateContentCategories([
        GateContentType.quran,
        GateContentType.dua,
      ]);
      final prefs = await repo.getPreferences();
      expect(prefs.gateContentCategories, 'quran,dua');
    });

    test('updates quran mode', () async {
      await repo.updateQuranMode(QuranMode.sequential);
      final prefs = await repo.getPreferences();
      expect(prefs.quranMode, 'sequential');
    });

    test('completes onboarding', () async {
      await repo.completeOnboarding();
      final prefs = await repo.getPreferences();
      expect(prefs.onboardingCompleted, true);
    });

    test('updates streak', () async {
      await repo.updateStreak(5, '2026-03-24');
      final prefs = await repo.getPreferences();
      expect(prefs.streakCurrent, 5);
      expect(prefs.streakLastDate, '2026-03-24');
    });

    test('sets and clears pause', () async {
      final future = DateTime.now().add(const Duration(hours: 1));
      final timestamp = future.millisecondsSinceEpoch ~/ 1000;
      await repo.setPauseUntil(timestamp);

      var prefs = await repo.getPreferences();
      expect(prefs.pauseUntilTimestamp, timestamp);

      await repo.setPauseUntil(null);
      prefs = await repo.getPreferences();
      expect(prefs.pauseUntilTimestamp, isNull);
    });
  });
}
