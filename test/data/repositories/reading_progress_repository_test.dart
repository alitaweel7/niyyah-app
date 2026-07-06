import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aya_unlock/data/datasources/local/app_database.dart';
import 'package:aya_unlock/data/repositories/reading_progress_repository.dart';

void main() {
  late AppDatabase db;
  late ReadingProgressRepository repo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ReadingProgressRepository(db);

    await db.into(db.userPreferences).insert(
      UserPreferencesCompanion.insert(),
    );
  });

  tearDown(() => db.close());

  group('ReadingProgressRepository', () {
    test('records reading and increments on repeat', () async {
      await repo.recordReading(
        contentType: 'quran',
        contentId: 94,
        readingSeconds: 120,
      );

      var progress = await repo.getProgressByType('quran');
      expect(progress, hasLength(1));
      expect(progress.first.timesRead, 1);
      expect(progress.first.totalReadingSeconds, 120);

      // Read again
      await repo.recordReading(
        contentType: 'quran',
        contentId: 94,
        readingSeconds: 60,
      );

      progress = await repo.getProgressByType('quran');
      expect(progress, hasLength(1));
      expect(progress.first.timesRead, 2);
      expect(progress.first.totalReadingSeconds, 180);
    });

    test('tracks different content types separately', () async {
      await repo.recordReading(
        contentType: 'quran',
        contentId: 1,
        readingSeconds: 100,
      );
      await repo.recordReading(
        contentType: 'dua',
        contentId: 5,
        readingSeconds: 50,
      );

      final quranCount = await repo.getUniqueContentCount('quran');
      final duaCount = await repo.getUniqueContentCount('dua');
      expect(quranCount, 1);
      expect(duaCount, 1);

      final total = await repo.getTotalReadingSeconds();
      expect(total, 150);
    });

    test('toggles favorite and memorized', () async {
      await repo.recordReading(
        contentType: 'dua',
        contentId: 10,
        readingSeconds: 30,
      );

      final items = await repo.getProgressByType('dua');
      expect(items.first.isFavorite, false);

      await repo.toggleFavorite(items.first.id, true);
      final favorites = await repo.getFavorites();
      expect(favorites, hasLength(1));

      await repo.toggleMemorized(items.first.id, true);
      final updated = await repo.getProgressByType('dua');
      expect(updated.first.isMemorized, true);
    });

    test('tracks surah progress and completion', () async {
      // Read 7 ayahs of surah 1 (Al-Fatiha has 7 ayahs)
      for (var i = 0; i < 7; i++) {
        await repo.recordSurahAyahRead(1, 7);
      }

      final progress = await repo.getAllSurahProgress();
      expect(progress, hasLength(1));
      expect(progress.first.ayahsRead, 7);
      expect(progress.first.isCompleted, true);
      expect(progress.first.completedAt, isNotNull);

      final completedCount = await repo.getCompletedSurahCount();
      expect(completedCount, 1);

      final totalAyahs = await repo.getTotalAyahsRead();
      expect(totalAyahs, 7);
    });
  });
}
