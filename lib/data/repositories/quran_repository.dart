import 'dart:math';

import 'package:drift/drift.dart';

import '../../core/constants/app_constants.dart';
import '../datasources/quran/quran_database.dart';

class QuranRepository {
  QuranRepository(this._db);

  final QuranDatabase _db;
  final _random = Random();

  // ── Surahs ──────────────────────────────────────────────────────────────

  Future<List<QuranSurah>> getAllSurahs() {
    return _db.select(_db.quranSurahs).get();
  }

  Future<QuranSurah> getSurah(int number) {
    return (_db.select(_db.quranSurahs)
          ..where((t) => t.number.equals(number)))
        .getSingle();
  }

  // ── Ayahs ───────────────────────────────────────────────────────────────

  Future<List<QuranAyah>> getAyahsForSurah(int surahNumber) {
    return (_db.select(_db.quranAyahs)
          ..where((t) => t.surah.equals(surahNumber))
          ..orderBy([(t) => OrderingTerm.asc(t.ayah)]))
        .get();
  }

  Future<List<QuranAyah>> getAyahRange(int surah, int startAyah, int endAyah) {
    return (_db.select(_db.quranAyahs)
          ..where((t) =>
              t.surah.equals(surah) &
              t.ayah.isBiggerOrEqualValue(startAyah) &
              t.ayah.isSmallerOrEqualValue(endAyah))
          ..orderBy([(t) => OrderingTerm.asc(t.ayah)]))
        .get();
  }

  Future<QuranAyah> getAyah(int surah, int ayah) {
    return (_db.select(_db.quranAyahs)
          ..where((t) => t.surah.equals(surah) & t.ayah.equals(ayah)))
        .getSingle();
  }

  // ── Content selection for gates ─────────────────────────────────────────

  /// Returns a random short surah (from Juz Amma defaults)
  Future<ShortSurahContent> getRandomShortSurah() async {
    final surahNumber = AppConstants
        .shortSurahNumbers[_random.nextInt(AppConstants.shortSurahNumbers.length)];
    final surah = await getSurah(surahNumber);
    final ayahs = await getAyahsForSurah(surahNumber);
    return ShortSurahContent(surah: surah, ayahs: ayahs);
  }

  /// Returns a random ayah from the entire Quran
  Future<RandomAyahContent> getRandomAyah() async {
    final id = _random.nextInt(AppConstants.totalAyahs) + 1;
    final ayah = await (_db.select(_db.quranAyahs)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    final surah = await getSurah(ayah.surah);
    return RandomAyahContent(surah: surah, ayah: ayah);
  }

  /// Returns the next ayah(s) for sequential reading
  Future<SequentialContent> getSequentialContent(
      int surahNumber, int ayahNumber,
      {int count = 5}) async {
    final ayahs = <QuranAyah>[];
    var currentSurah = surahNumber;
    var currentAyah = ayahNumber;

    while (ayahs.length < count) {
      final results = await (_db.select(_db.quranAyahs)
            ..where((t) =>
                t.surah.equals(currentSurah) &
                t.ayah.isBiggerOrEqualValue(currentAyah))
            ..orderBy([(t) => OrderingTerm.asc(t.ayah)])
            ..limit(count - ayahs.length))
          .get();

      ayahs.addAll(results);

      if (ayahs.length < count) {
        // Move to next surah
        currentSurah++;
        currentAyah = 1;
        if (currentSurah > AppConstants.totalSurahs) {
          currentSurah = 1; // wrap around
        }
      }
    }

    final surah = await getSurah(ayahs.first.surah);
    final nextSurah = ayahs.last.surah;
    final nextAyah = ayahs.last.ayah + 1;

    return SequentialContent(
      surah: surah,
      ayahs: ayahs,
      nextSurah: nextSurah,
      nextAyah: nextAyah,
    );
  }

  // ── Translations ────────────────────────────────────────────────────────

  /// Get translation text for a specific ayah in a given language.
  Future<String?> getTranslation(int ayahId, String languageCode) async {
    if (languageCode == 'en') {
      final ayah = await (_db.select(_db.quranAyahs)
            ..where((t) => t.id.equals(ayahId)))
          .getSingleOrNull();
      return ayah?.textTranslationEn;
    }

    final result = await (_db.select(_db.quranTranslations)
          ..where((t) =>
              t.ayahId.equals(ayahId) &
              t.languageCode.equals(languageCode)))
        .getSingleOrNull();
    return result?.translationText;
  }

  /// Get translations for multiple ayahs at once (batch).
  Future<Map<int, String>> getTranslationsForAyahs(
      List<int> ayahIds, String languageCode) async {
    if (languageCode == 'en') {
      final ayahs = await (_db.select(_db.quranAyahs)
            ..where((t) => t.id.isIn(ayahIds)))
          .get();
      return {
        for (final a in ayahs)
          if (a.textTranslationEn != null) a.id: a.textTranslationEn!,
      };
    }

    final results = await (_db.select(_db.quranTranslations)
          ..where((t) =>
              t.ayahId.isIn(ayahIds) &
              t.languageCode.equals(languageCode)))
        .get();
    return {for (final r in results) r.ayahId: r.translationText};
  }

  /// Get list of available translation languages.
  Future<List<AvailableLanguage>> getAvailableLanguages() {
    return (_db.select(_db.availableLanguages)
          ..where((t) => t.isDownloaded.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.displayName)]))
        .get();
  }
}

// ── Content models ────────────────────────────────────────────────────────

class ShortSurahContent {
  const ShortSurahContent({required this.surah, required this.ayahs});
  final QuranSurah surah;
  final List<QuranAyah> ayahs;
}

class RandomAyahContent {
  const RandomAyahContent({required this.surah, required this.ayah});
  final QuranSurah surah;
  final QuranAyah ayah;
}

class SequentialContent {
  const SequentialContent({
    required this.surah,
    required this.ayahs,
    required this.nextSurah,
    required this.nextAyah,
  });
  final QuranSurah surah;
  final List<QuranAyah> ayahs;
  final int nextSurah;
  final int nextAyah;
}
