// Helpers for handling the Basmala (بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ) at
// the start of a surah.
//
// Background: in the bundled `quran.db`, the Basmala is mistakenly merged into
// the text of ayah 1 for (almost) every surah — e.g. Surah 87 ayah 1 is stored
// as "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ سَبِّحِ ٱسْمَ رَبِّكَ ٱلْأَعْلَىٰ".
// Per the mushaf, the Basmala belongs on its own line *above* ayah 1 (and is
// not itself numbered), except:
//   • Surah 1 (Al-Fatiha) — the Basmala genuinely *is* ayah 1, and
//   • Surah 9 (At-Tawbah) — which has no Basmala at all.
//
// So at display time we strip the merged Basmala from ayah 1 and render it
// separately via [kBasmala]. The strip is diacritic-insensitive (so it also
// catches the stored variant "بِّسْمِ" in surahs 95 & 97) and self-correcting
// (if the data is ever cleaned, the first four words simply won't match and
// nothing is removed).

/// The Basmala in Uthmani script, for rendering as a standalone header line.
const String kBasmala = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';

/// Whether a separate Basmala header line should be shown at the start of
/// [surah]. True for every surah except Al-Fatiha (1) and At-Tawbah (9).
bool showBasmalaHeader(int surah) => surah != 1 && surah != 9;

// Arabic combining marks / Quranic annotation signs / tatweel.
final RegExp _diacritics = RegExp(
  '[ؐ-ًؚ-ٰٟۖ-ۜ۟-۪ۤۧۨ-ۭـ]',
);

/// Strip diacritics and normalise the alef variants so two Arabic strings can
/// be compared by their bare letters.
String _normalize(String s) => s
    .replaceAll(_diacritics, '')
    .replaceAll('ٱ', 'ا') // ٱ alef-wasla → ا
    .replaceAll('أ', 'ا') // أ → ا
    .replaceAll('إ', 'ا') // إ → ا
    .replaceAll('آ', 'ا'); // آ → ا

// Bare-letter form of the Basmala: "بسم الله الرحمن الرحيم".
final String _basmalaCore = _normalize(kBasmala);

/// If [text] (ayah 1 of [surah]) begins with a merged Basmala, return it with
/// that Basmala removed; otherwise return [text] unchanged. Leaves Al-Fatiha
/// and At-Tawbah untouched.
String stripLeadingBasmala(int surah, String text) {
  if (surah == 1 || surah == 9) return text;
  final words = text.split(RegExp(r'\s+'));
  if (words.length <= 4) return text; // Basmala is 4 words; ayah must add more
  final firstFour = words.take(4).join(' ');
  if (_normalize(firstFour) == _basmalaCore) {
    return words.skip(4).join(' ');
  }
  return text;
}
