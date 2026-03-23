abstract final class AppConstants {
  static const String appName = 'Aya Unlock';
  static const String tagline = 'Open with intention';

  // Gate timer presets (seconds)
  static const List<int> gateTimerPresets = [60, 180, 300, 600];
  static const int defaultGateTimerSeconds = 300; // 5 minutes

  // Unlock window presets (seconds)
  static const int defaultUnlockWindowSeconds = 600; // 10 minutes
  static const int minUnlockWindowSeconds = 300; // 5 minutes
  static const int maxUnlockWindowSeconds = 1800; // 30 minutes

  // Free tier limits
  static const int freeMaxBlockedApps = 3;

  // Default blocked app package names
  static const Map<String, String> defaultBlockableApps = {
    'com.instagram.android': 'Instagram',
    'com.zhiliaoapp.musically': 'TikTok',
    'com.twitter.android': 'X',
    'com.snapchat.android': 'Snapchat',
    'com.facebook.katana': 'Facebook',
    'com.google.android.youtube': 'YouTube',
  };

  // iOS bundle identifiers for the same apps
  static const Map<String, String> defaultBlockableAppsIOS = {
    'com.burbn.instagram': 'Instagram',
    'com.zhiliaoapp.musically': 'TikTok',
    'com.atebits.Tweetie2': 'X',
    'com.toyopagroup.picaboo': 'Snapchat',
    'com.facebook.Facebook': 'Facebook',
    'com.google.ios.youtube': 'YouTube',
  };

  // Quran data
  static const int totalSurahs = 114;
  static const int totalAyahs = 6236;
  static const int totalJuz = 30;

  // Short surahs for gate defaults (Juz Amma)
  static const List<int> shortSurahNumbers = [
    112, // Al-Ikhlas
    113, // Al-Falaq
    114, // An-Nas
    1, // Al-Fatiha
    108, // Al-Kawthar
    107, // Al-Ma'un
    106, // Quraysh
    105, // Al-Fil
    104, // Al-Humazah
    103, // Al-Asr
    102, // At-Takathur
    101, // Al-Qari'ah
    99, // Az-Zalzalah
    97, // Al-Qadr
    96, // Al-Alaq
    95, // At-Tin
    94, // Ash-Sharh
    93, // Ad-Duha
    91, // Ash-Shams
    87, // Al-A'la
  ];

  // Pause mode presets
  static const List<Duration> pausePresets = [
    Duration(hours: 1),
    Duration(hours: 3),
    Duration(hours: 8), // "Until tomorrow" approximation
  ];

  // Database
  static const String quranDbName = 'quran.db';
  static const String appDbName = 'aya_unlock.db';

  // Tanzil attribution
  static const String tanzilAttribution =
      'Quran text provided by Tanzil.net (tanzil.net) under CC-BY-3.0 license.';
}
