enum GateContentType {
  quran('quran', 'Quran'),
  dua('dua', 'Duas'),
  prophetStory('prophet_story', 'Prophet Stories'),
  sahabahStory('sahabah_story', 'Sahabah Stories'),
  islamicHistory('islamic_history', 'Islamic History'),
  islamicTeaching('islamic_teaching', 'Islamic Teachings');

  const GateContentType(this.dbValue, this.displayName);

  final String dbValue;
  final String displayName;

  static GateContentType fromDbValue(String value) {
    return GateContentType.values.firstWhere(
      (e) => e.dbValue == value,
      orElse: () => GateContentType.quran,
    );
  }

  bool get isFree => this == quran || this == dua || this == islamicTeaching;
  bool get isPremium => !isFree;
}

enum QuranMode {
  shortSurah('short_surah', 'Short Surah'),
  randomAyah('random_ayah', 'Random Ayah'),
  sequential('sequential', 'Sequential Reading');

  const QuranMode(this.dbValue, this.displayName);

  final String dbValue;
  final String displayName;

  static QuranMode fromDbValue(String value) {
    return QuranMode.values.firstWhere(
      (e) => e.dbValue == value,
      orElse: () => QuranMode.shortSurah,
    );
  }
}
