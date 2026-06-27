// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _gateDurationSecondsMeta =
      const VerificationMeta('gateDurationSeconds');
  @override
  late final GeneratedColumn<int> gateDurationSeconds = GeneratedColumn<int>(
    'gate_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(300),
  );
  static const VerificationMeta _unlockDurationSecondsMeta =
      const VerificationMeta('unlockDurationSeconds');
  @override
  late final GeneratedColumn<int> unlockDurationSeconds = GeneratedColumn<int>(
    'unlock_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(600),
  );
  static const VerificationMeta _gateContentCategoriesMeta =
      const VerificationMeta('gateContentCategories');
  @override
  late final GeneratedColumn<String> gateContentCategories =
      GeneratedColumn<String>(
        'gate_content_categories',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('quran,dua'),
      );
  static const VerificationMeta _quranModeMeta = const VerificationMeta(
    'quranMode',
  );
  @override
  late final GeneratedColumn<String> quranMode = GeneratedColumn<String>(
    'quran_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('short_surah'),
  );
  static const VerificationMeta _showTranslationMeta = const VerificationMeta(
    'showTranslation',
  );
  @override
  late final GeneratedColumn<bool> showTranslation = GeneratedColumn<bool>(
    'show_translation',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_translation" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _quranFontSizeMeta = const VerificationMeta(
    'quranFontSize',
  );
  @override
  late final GeneratedColumn<double> quranFontSize = GeneratedColumn<double>(
    'quran_font_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(28.0),
  );
  static const VerificationMeta _translationLanguageMeta =
      const VerificationMeta('translationLanguage');
  @override
  late final GeneratedColumn<String> translationLanguage =
      GeneratedColumn<String>(
        'translation_language',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('en'),
      );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _pauseUntilTimestampMeta =
      const VerificationMeta('pauseUntilTimestamp');
  @override
  late final GeneratedColumn<int> pauseUntilTimestamp = GeneratedColumn<int>(
    'pause_until_timestamp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sequentialPositionSurahMeta =
      const VerificationMeta('sequentialPositionSurah');
  @override
  late final GeneratedColumn<int> sequentialPositionSurah =
      GeneratedColumn<int>(
        'sequential_position_surah',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(1),
      );
  static const VerificationMeta _sequentialPositionAyahMeta =
      const VerificationMeta('sequentialPositionAyah');
  @override
  late final GeneratedColumn<int> sequentialPositionAyah = GeneratedColumn<int>(
    'sequential_position_ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _streakCurrentMeta = const VerificationMeta(
    'streakCurrent',
  );
  @override
  late final GeneratedColumn<int> streakCurrent = GeneratedColumn<int>(
    'streak_current',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _streakLastDateMeta = const VerificationMeta(
    'streakLastDate',
  );
  @override
  late final GeneratedColumn<String> streakLastDate = GeneratedColumn<String>(
    'streak_last_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notifyPrayerTimesMeta = const VerificationMeta(
    'notifyPrayerTimes',
  );
  @override
  late final GeneratedColumn<bool> notifyPrayerTimes = GeneratedColumn<bool>(
    'notify_prayer_times',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_prayer_times" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyPrayerAdvanceMinutesMeta =
      const VerificationMeta('notifyPrayerAdvanceMinutes');
  @override
  late final GeneratedColumn<int> notifyPrayerAdvanceMinutes =
      GeneratedColumn<int>(
        'notify_prayer_advance_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _notifyFridayKahfMeta = const VerificationMeta(
    'notifyFridayKahf',
  );
  @override
  late final GeneratedColumn<bool> notifyFridayKahf = GeneratedColumn<bool>(
    'notify_friday_kahf',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_friday_kahf" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyFastingDaysMeta = const VerificationMeta(
    'notifyFastingDays',
  );
  @override
  late final GeneratedColumn<bool> notifyFastingDays = GeneratedColumn<bool>(
    'notify_fasting_days',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_fasting_days" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyMorningAdhkarMeta =
      const VerificationMeta('notifyMorningAdhkar');
  @override
  late final GeneratedColumn<bool> notifyMorningAdhkar = GeneratedColumn<bool>(
    'notify_morning_adhkar',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_morning_adhkar" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyEveningAdhkarMeta =
      const VerificationMeta('notifyEveningAdhkar');
  @override
  late final GeneratedColumn<bool> notifyEveningAdhkar = GeneratedColumn<bool>(
    'notify_evening_adhkar',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_evening_adhkar" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyBedtimeDuaMeta = const VerificationMeta(
    'notifyBedtimeDua',
  );
  @override
  late final GeneratedColumn<bool> notifyBedtimeDua = GeneratedColumn<bool>(
    'notify_bedtime_dua',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_bedtime_dua" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifySurahMulkMeta = const VerificationMeta(
    'notifySurahMulk',
  );
  @override
  late final GeneratedColumn<bool> notifySurahMulk = GeneratedColumn<bool>(
    'notify_surah_mulk',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_surah_mulk" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyDuhaReminderMeta =
      const VerificationMeta('notifyDuhaReminder');
  @override
  late final GeneratedColumn<bool> notifyDuhaReminder = GeneratedColumn<bool>(
    'notify_duha_reminder',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_duha_reminder" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyTahajjudMeta = const VerificationMeta(
    'notifyTahajjud',
  );
  @override
  late final GeneratedColumn<bool> notifyTahajjud = GeneratedColumn<bool>(
    'notify_tahajjud',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_tahajjud" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyDhikrAfterPrayerMeta =
      const VerificationMeta('notifyDhikrAfterPrayer');
  @override
  late final GeneratedColumn<bool> notifyDhikrAfterPrayer =
      GeneratedColumn<bool>(
        'notify_dhikr_after_prayer',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notify_dhikr_after_prayer" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _notifyDuaForParentsMeta =
      const VerificationMeta('notifyDuaForParents');
  @override
  late final GeneratedColumn<bool> notifyDuaForParents = GeneratedColumn<bool>(
    'notify_dua_for_parents',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_dua_for_parents" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyFridaySalawatMeta =
      const VerificationMeta('notifyFridaySalawat');
  @override
  late final GeneratedColumn<bool> notifyFridaySalawat = GeneratedColumn<bool>(
    'notify_friday_salawat',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_friday_salawat" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyFridayDuaHourMeta =
      const VerificationMeta('notifyFridayDuaHour');
  @override
  late final GeneratedColumn<bool> notifyFridayDuaHour = GeneratedColumn<bool>(
    'notify_friday_dua_hour',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_friday_dua_hour" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyDidYouKnowMeta = const VerificationMeta(
    'notifyDidYouKnow',
  );
  @override
  late final GeneratedColumn<bool> notifyDidYouKnow = GeneratedColumn<bool>(
    'notify_did_you_know',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_did_you_know" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _bedtimeHourMeta = const VerificationMeta(
    'bedtimeHour',
  );
  @override
  late final GeneratedColumn<int> bedtimeHour = GeneratedColumn<int>(
    'bedtime_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(22),
  );
  static const VerificationMeta _bedtimeMinuteMeta = const VerificationMeta(
    'bedtimeMinute',
  );
  @override
  late final GeneratedColumn<int> bedtimeMinute = GeneratedColumn<int>(
    'bedtime_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _prayerCalculationMethodMeta =
      const VerificationMeta('prayerCalculationMethod');
  @override
  late final GeneratedColumn<String> prayerCalculationMethod =
      GeneratedColumn<String>(
        'prayer_calculation_method',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('auto'),
      );
  static const VerificationMeta _madhabMeta = const VerificationMeta('madhab');
  @override
  late final GeneratedColumn<String> madhab = GeneratedColumn<String>(
    'madhab',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('shafi'),
  );
  static const VerificationMeta _localeCodeMeta = const VerificationMeta(
    'localeCode',
  );
  @override
  late final GeneratedColumn<String> localeCode = GeneratedColumn<String>(
    'locale_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gateDurationSeconds,
    unlockDurationSeconds,
    gateContentCategories,
    quranMode,
    showTranslation,
    quranFontSize,
    translationLanguage,
    themeMode,
    pauseUntilTimestamp,
    sequentialPositionSurah,
    sequentialPositionAyah,
    onboardingCompleted,
    streakCurrent,
    streakLastDate,
    notifyPrayerTimes,
    notifyPrayerAdvanceMinutes,
    notifyFridayKahf,
    notifyFastingDays,
    notifyMorningAdhkar,
    notifyEveningAdhkar,
    notifyBedtimeDua,
    notifySurahMulk,
    notifyDuhaReminder,
    notifyTahajjud,
    notifyDhikrAfterPrayer,
    notifyDuaForParents,
    notifyFridaySalawat,
    notifyFridayDuaHour,
    notifyDidYouKnow,
    bedtimeHour,
    bedtimeMinute,
    prayerCalculationMethod,
    madhab,
    localeCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gate_duration_seconds')) {
      context.handle(
        _gateDurationSecondsMeta,
        gateDurationSeconds.isAcceptableOrUnknown(
          data['gate_duration_seconds']!,
          _gateDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('unlock_duration_seconds')) {
      context.handle(
        _unlockDurationSecondsMeta,
        unlockDurationSeconds.isAcceptableOrUnknown(
          data['unlock_duration_seconds']!,
          _unlockDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('gate_content_categories')) {
      context.handle(
        _gateContentCategoriesMeta,
        gateContentCategories.isAcceptableOrUnknown(
          data['gate_content_categories']!,
          _gateContentCategoriesMeta,
        ),
      );
    }
    if (data.containsKey('quran_mode')) {
      context.handle(
        _quranModeMeta,
        quranMode.isAcceptableOrUnknown(data['quran_mode']!, _quranModeMeta),
      );
    }
    if (data.containsKey('show_translation')) {
      context.handle(
        _showTranslationMeta,
        showTranslation.isAcceptableOrUnknown(
          data['show_translation']!,
          _showTranslationMeta,
        ),
      );
    }
    if (data.containsKey('quran_font_size')) {
      context.handle(
        _quranFontSizeMeta,
        quranFontSize.isAcceptableOrUnknown(
          data['quran_font_size']!,
          _quranFontSizeMeta,
        ),
      );
    }
    if (data.containsKey('translation_language')) {
      context.handle(
        _translationLanguageMeta,
        translationLanguage.isAcceptableOrUnknown(
          data['translation_language']!,
          _translationLanguageMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('pause_until_timestamp')) {
      context.handle(
        _pauseUntilTimestampMeta,
        pauseUntilTimestamp.isAcceptableOrUnknown(
          data['pause_until_timestamp']!,
          _pauseUntilTimestampMeta,
        ),
      );
    }
    if (data.containsKey('sequential_position_surah')) {
      context.handle(
        _sequentialPositionSurahMeta,
        sequentialPositionSurah.isAcceptableOrUnknown(
          data['sequential_position_surah']!,
          _sequentialPositionSurahMeta,
        ),
      );
    }
    if (data.containsKey('sequential_position_ayah')) {
      context.handle(
        _sequentialPositionAyahMeta,
        sequentialPositionAyah.isAcceptableOrUnknown(
          data['sequential_position_ayah']!,
          _sequentialPositionAyahMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    if (data.containsKey('streak_current')) {
      context.handle(
        _streakCurrentMeta,
        streakCurrent.isAcceptableOrUnknown(
          data['streak_current']!,
          _streakCurrentMeta,
        ),
      );
    }
    if (data.containsKey('streak_last_date')) {
      context.handle(
        _streakLastDateMeta,
        streakLastDate.isAcceptableOrUnknown(
          data['streak_last_date']!,
          _streakLastDateMeta,
        ),
      );
    }
    if (data.containsKey('notify_prayer_times')) {
      context.handle(
        _notifyPrayerTimesMeta,
        notifyPrayerTimes.isAcceptableOrUnknown(
          data['notify_prayer_times']!,
          _notifyPrayerTimesMeta,
        ),
      );
    }
    if (data.containsKey('notify_prayer_advance_minutes')) {
      context.handle(
        _notifyPrayerAdvanceMinutesMeta,
        notifyPrayerAdvanceMinutes.isAcceptableOrUnknown(
          data['notify_prayer_advance_minutes']!,
          _notifyPrayerAdvanceMinutesMeta,
        ),
      );
    }
    if (data.containsKey('notify_friday_kahf')) {
      context.handle(
        _notifyFridayKahfMeta,
        notifyFridayKahf.isAcceptableOrUnknown(
          data['notify_friday_kahf']!,
          _notifyFridayKahfMeta,
        ),
      );
    }
    if (data.containsKey('notify_fasting_days')) {
      context.handle(
        _notifyFastingDaysMeta,
        notifyFastingDays.isAcceptableOrUnknown(
          data['notify_fasting_days']!,
          _notifyFastingDaysMeta,
        ),
      );
    }
    if (data.containsKey('notify_morning_adhkar')) {
      context.handle(
        _notifyMorningAdhkarMeta,
        notifyMorningAdhkar.isAcceptableOrUnknown(
          data['notify_morning_adhkar']!,
          _notifyMorningAdhkarMeta,
        ),
      );
    }
    if (data.containsKey('notify_evening_adhkar')) {
      context.handle(
        _notifyEveningAdhkarMeta,
        notifyEveningAdhkar.isAcceptableOrUnknown(
          data['notify_evening_adhkar']!,
          _notifyEveningAdhkarMeta,
        ),
      );
    }
    if (data.containsKey('notify_bedtime_dua')) {
      context.handle(
        _notifyBedtimeDuaMeta,
        notifyBedtimeDua.isAcceptableOrUnknown(
          data['notify_bedtime_dua']!,
          _notifyBedtimeDuaMeta,
        ),
      );
    }
    if (data.containsKey('notify_surah_mulk')) {
      context.handle(
        _notifySurahMulkMeta,
        notifySurahMulk.isAcceptableOrUnknown(
          data['notify_surah_mulk']!,
          _notifySurahMulkMeta,
        ),
      );
    }
    if (data.containsKey('notify_duha_reminder')) {
      context.handle(
        _notifyDuhaReminderMeta,
        notifyDuhaReminder.isAcceptableOrUnknown(
          data['notify_duha_reminder']!,
          _notifyDuhaReminderMeta,
        ),
      );
    }
    if (data.containsKey('notify_tahajjud')) {
      context.handle(
        _notifyTahajjudMeta,
        notifyTahajjud.isAcceptableOrUnknown(
          data['notify_tahajjud']!,
          _notifyTahajjudMeta,
        ),
      );
    }
    if (data.containsKey('notify_dhikr_after_prayer')) {
      context.handle(
        _notifyDhikrAfterPrayerMeta,
        notifyDhikrAfterPrayer.isAcceptableOrUnknown(
          data['notify_dhikr_after_prayer']!,
          _notifyDhikrAfterPrayerMeta,
        ),
      );
    }
    if (data.containsKey('notify_dua_for_parents')) {
      context.handle(
        _notifyDuaForParentsMeta,
        notifyDuaForParents.isAcceptableOrUnknown(
          data['notify_dua_for_parents']!,
          _notifyDuaForParentsMeta,
        ),
      );
    }
    if (data.containsKey('notify_friday_salawat')) {
      context.handle(
        _notifyFridaySalawatMeta,
        notifyFridaySalawat.isAcceptableOrUnknown(
          data['notify_friday_salawat']!,
          _notifyFridaySalawatMeta,
        ),
      );
    }
    if (data.containsKey('notify_friday_dua_hour')) {
      context.handle(
        _notifyFridayDuaHourMeta,
        notifyFridayDuaHour.isAcceptableOrUnknown(
          data['notify_friday_dua_hour']!,
          _notifyFridayDuaHourMeta,
        ),
      );
    }
    if (data.containsKey('notify_did_you_know')) {
      context.handle(
        _notifyDidYouKnowMeta,
        notifyDidYouKnow.isAcceptableOrUnknown(
          data['notify_did_you_know']!,
          _notifyDidYouKnowMeta,
        ),
      );
    }
    if (data.containsKey('bedtime_hour')) {
      context.handle(
        _bedtimeHourMeta,
        bedtimeHour.isAcceptableOrUnknown(
          data['bedtime_hour']!,
          _bedtimeHourMeta,
        ),
      );
    }
    if (data.containsKey('bedtime_minute')) {
      context.handle(
        _bedtimeMinuteMeta,
        bedtimeMinute.isAcceptableOrUnknown(
          data['bedtime_minute']!,
          _bedtimeMinuteMeta,
        ),
      );
    }
    if (data.containsKey('prayer_calculation_method')) {
      context.handle(
        _prayerCalculationMethodMeta,
        prayerCalculationMethod.isAcceptableOrUnknown(
          data['prayer_calculation_method']!,
          _prayerCalculationMethodMeta,
        ),
      );
    }
    if (data.containsKey('madhab')) {
      context.handle(
        _madhabMeta,
        madhab.isAcceptableOrUnknown(data['madhab']!, _madhabMeta),
      );
    }
    if (data.containsKey('locale_code')) {
      context.handle(
        _localeCodeMeta,
        localeCode.isAcceptableOrUnknown(data['locale_code']!, _localeCodeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      gateDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gate_duration_seconds'],
      )!,
      unlockDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unlock_duration_seconds'],
      )!,
      gateContentCategories: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gate_content_categories'],
      )!,
      quranMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quran_mode'],
      )!,
      showTranslation: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_translation'],
      )!,
      quranFontSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quran_font_size'],
      )!,
      translationLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_language'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      pauseUntilTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pause_until_timestamp'],
      ),
      sequentialPositionSurah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequential_position_surah'],
      )!,
      sequentialPositionAyah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequential_position_ayah'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      streakCurrent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_current'],
      )!,
      streakLastDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}streak_last_date'],
      ),
      notifyPrayerTimes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_prayer_times'],
      )!,
      notifyPrayerAdvanceMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notify_prayer_advance_minutes'],
      )!,
      notifyFridayKahf: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_friday_kahf'],
      )!,
      notifyFastingDays: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_fasting_days'],
      )!,
      notifyMorningAdhkar: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_morning_adhkar'],
      )!,
      notifyEveningAdhkar: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_evening_adhkar'],
      )!,
      notifyBedtimeDua: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_bedtime_dua'],
      )!,
      notifySurahMulk: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_surah_mulk'],
      )!,
      notifyDuhaReminder: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_duha_reminder'],
      )!,
      notifyTahajjud: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_tahajjud'],
      )!,
      notifyDhikrAfterPrayer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_dhikr_after_prayer'],
      )!,
      notifyDuaForParents: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_dua_for_parents'],
      )!,
      notifyFridaySalawat: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_friday_salawat'],
      )!,
      notifyFridayDuaHour: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_friday_dua_hour'],
      )!,
      notifyDidYouKnow: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_did_you_know'],
      )!,
      bedtimeHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bedtime_hour'],
      )!,
      bedtimeMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bedtime_minute'],
      )!,
      prayerCalculationMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prayer_calculation_method'],
      )!,
      madhab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}madhab'],
      )!,
      localeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale_code'],
      )!,
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreference extends DataClass implements Insertable<UserPreference> {
  final int id;
  final int gateDurationSeconds;
  final int unlockDurationSeconds;
  final String gateContentCategories;
  final String quranMode;
  final bool showTranslation;
  final double quranFontSize;
  final String translationLanguage;
  final String themeMode;
  final int? pauseUntilTimestamp;
  final int sequentialPositionSurah;
  final int sequentialPositionAyah;
  final bool onboardingCompleted;
  final int streakCurrent;
  final String? streakLastDate;
  final bool notifyPrayerTimes;
  final int notifyPrayerAdvanceMinutes;
  final bool notifyFridayKahf;
  final bool notifyFastingDays;
  final bool notifyMorningAdhkar;
  final bool notifyEveningAdhkar;
  final bool notifyBedtimeDua;
  final bool notifySurahMulk;
  final bool notifyDuhaReminder;
  final bool notifyTahajjud;
  final bool notifyDhikrAfterPrayer;
  final bool notifyDuaForParents;
  final bool notifyFridaySalawat;
  final bool notifyFridayDuaHour;
  final bool notifyDidYouKnow;
  final int bedtimeHour;
  final int bedtimeMinute;
  final String prayerCalculationMethod;
  final String madhab;
  final String localeCode;
  const UserPreference({
    required this.id,
    required this.gateDurationSeconds,
    required this.unlockDurationSeconds,
    required this.gateContentCategories,
    required this.quranMode,
    required this.showTranslation,
    required this.quranFontSize,
    required this.translationLanguage,
    required this.themeMode,
    this.pauseUntilTimestamp,
    required this.sequentialPositionSurah,
    required this.sequentialPositionAyah,
    required this.onboardingCompleted,
    required this.streakCurrent,
    this.streakLastDate,
    required this.notifyPrayerTimes,
    required this.notifyPrayerAdvanceMinutes,
    required this.notifyFridayKahf,
    required this.notifyFastingDays,
    required this.notifyMorningAdhkar,
    required this.notifyEveningAdhkar,
    required this.notifyBedtimeDua,
    required this.notifySurahMulk,
    required this.notifyDuhaReminder,
    required this.notifyTahajjud,
    required this.notifyDhikrAfterPrayer,
    required this.notifyDuaForParents,
    required this.notifyFridaySalawat,
    required this.notifyFridayDuaHour,
    required this.notifyDidYouKnow,
    required this.bedtimeHour,
    required this.bedtimeMinute,
    required this.prayerCalculationMethod,
    required this.madhab,
    required this.localeCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gate_duration_seconds'] = Variable<int>(gateDurationSeconds);
    map['unlock_duration_seconds'] = Variable<int>(unlockDurationSeconds);
    map['gate_content_categories'] = Variable<String>(gateContentCategories);
    map['quran_mode'] = Variable<String>(quranMode);
    map['show_translation'] = Variable<bool>(showTranslation);
    map['quran_font_size'] = Variable<double>(quranFontSize);
    map['translation_language'] = Variable<String>(translationLanguage);
    map['theme_mode'] = Variable<String>(themeMode);
    if (!nullToAbsent || pauseUntilTimestamp != null) {
      map['pause_until_timestamp'] = Variable<int>(pauseUntilTimestamp);
    }
    map['sequential_position_surah'] = Variable<int>(sequentialPositionSurah);
    map['sequential_position_ayah'] = Variable<int>(sequentialPositionAyah);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['streak_current'] = Variable<int>(streakCurrent);
    if (!nullToAbsent || streakLastDate != null) {
      map['streak_last_date'] = Variable<String>(streakLastDate);
    }
    map['notify_prayer_times'] = Variable<bool>(notifyPrayerTimes);
    map['notify_prayer_advance_minutes'] = Variable<int>(
      notifyPrayerAdvanceMinutes,
    );
    map['notify_friday_kahf'] = Variable<bool>(notifyFridayKahf);
    map['notify_fasting_days'] = Variable<bool>(notifyFastingDays);
    map['notify_morning_adhkar'] = Variable<bool>(notifyMorningAdhkar);
    map['notify_evening_adhkar'] = Variable<bool>(notifyEveningAdhkar);
    map['notify_bedtime_dua'] = Variable<bool>(notifyBedtimeDua);
    map['notify_surah_mulk'] = Variable<bool>(notifySurahMulk);
    map['notify_duha_reminder'] = Variable<bool>(notifyDuhaReminder);
    map['notify_tahajjud'] = Variable<bool>(notifyTahajjud);
    map['notify_dhikr_after_prayer'] = Variable<bool>(notifyDhikrAfterPrayer);
    map['notify_dua_for_parents'] = Variable<bool>(notifyDuaForParents);
    map['notify_friday_salawat'] = Variable<bool>(notifyFridaySalawat);
    map['notify_friday_dua_hour'] = Variable<bool>(notifyFridayDuaHour);
    map['notify_did_you_know'] = Variable<bool>(notifyDidYouKnow);
    map['bedtime_hour'] = Variable<int>(bedtimeHour);
    map['bedtime_minute'] = Variable<int>(bedtimeMinute);
    map['prayer_calculation_method'] = Variable<String>(
      prayerCalculationMethod,
    );
    map['madhab'] = Variable<String>(madhab);
    map['locale_code'] = Variable<String>(localeCode);
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      id: Value(id),
      gateDurationSeconds: Value(gateDurationSeconds),
      unlockDurationSeconds: Value(unlockDurationSeconds),
      gateContentCategories: Value(gateContentCategories),
      quranMode: Value(quranMode),
      showTranslation: Value(showTranslation),
      quranFontSize: Value(quranFontSize),
      translationLanguage: Value(translationLanguage),
      themeMode: Value(themeMode),
      pauseUntilTimestamp: pauseUntilTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(pauseUntilTimestamp),
      sequentialPositionSurah: Value(sequentialPositionSurah),
      sequentialPositionAyah: Value(sequentialPositionAyah),
      onboardingCompleted: Value(onboardingCompleted),
      streakCurrent: Value(streakCurrent),
      streakLastDate: streakLastDate == null && nullToAbsent
          ? const Value.absent()
          : Value(streakLastDate),
      notifyPrayerTimes: Value(notifyPrayerTimes),
      notifyPrayerAdvanceMinutes: Value(notifyPrayerAdvanceMinutes),
      notifyFridayKahf: Value(notifyFridayKahf),
      notifyFastingDays: Value(notifyFastingDays),
      notifyMorningAdhkar: Value(notifyMorningAdhkar),
      notifyEveningAdhkar: Value(notifyEveningAdhkar),
      notifyBedtimeDua: Value(notifyBedtimeDua),
      notifySurahMulk: Value(notifySurahMulk),
      notifyDuhaReminder: Value(notifyDuhaReminder),
      notifyTahajjud: Value(notifyTahajjud),
      notifyDhikrAfterPrayer: Value(notifyDhikrAfterPrayer),
      notifyDuaForParents: Value(notifyDuaForParents),
      notifyFridaySalawat: Value(notifyFridaySalawat),
      notifyFridayDuaHour: Value(notifyFridayDuaHour),
      notifyDidYouKnow: Value(notifyDidYouKnow),
      bedtimeHour: Value(bedtimeHour),
      bedtimeMinute: Value(bedtimeMinute),
      prayerCalculationMethod: Value(prayerCalculationMethod),
      madhab: Value(madhab),
      localeCode: Value(localeCode),
    );
  }

  factory UserPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreference(
      id: serializer.fromJson<int>(json['id']),
      gateDurationSeconds: serializer.fromJson<int>(
        json['gateDurationSeconds'],
      ),
      unlockDurationSeconds: serializer.fromJson<int>(
        json['unlockDurationSeconds'],
      ),
      gateContentCategories: serializer.fromJson<String>(
        json['gateContentCategories'],
      ),
      quranMode: serializer.fromJson<String>(json['quranMode']),
      showTranslation: serializer.fromJson<bool>(json['showTranslation']),
      quranFontSize: serializer.fromJson<double>(json['quranFontSize']),
      translationLanguage: serializer.fromJson<String>(
        json['translationLanguage'],
      ),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      pauseUntilTimestamp: serializer.fromJson<int?>(
        json['pauseUntilTimestamp'],
      ),
      sequentialPositionSurah: serializer.fromJson<int>(
        json['sequentialPositionSurah'],
      ),
      sequentialPositionAyah: serializer.fromJson<int>(
        json['sequentialPositionAyah'],
      ),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      streakCurrent: serializer.fromJson<int>(json['streakCurrent']),
      streakLastDate: serializer.fromJson<String?>(json['streakLastDate']),
      notifyPrayerTimes: serializer.fromJson<bool>(json['notifyPrayerTimes']),
      notifyPrayerAdvanceMinutes: serializer.fromJson<int>(
        json['notifyPrayerAdvanceMinutes'],
      ),
      notifyFridayKahf: serializer.fromJson<bool>(json['notifyFridayKahf']),
      notifyFastingDays: serializer.fromJson<bool>(json['notifyFastingDays']),
      notifyMorningAdhkar: serializer.fromJson<bool>(
        json['notifyMorningAdhkar'],
      ),
      notifyEveningAdhkar: serializer.fromJson<bool>(
        json['notifyEveningAdhkar'],
      ),
      notifyBedtimeDua: serializer.fromJson<bool>(json['notifyBedtimeDua']),
      notifySurahMulk: serializer.fromJson<bool>(json['notifySurahMulk']),
      notifyDuhaReminder: serializer.fromJson<bool>(json['notifyDuhaReminder']),
      notifyTahajjud: serializer.fromJson<bool>(json['notifyTahajjud']),
      notifyDhikrAfterPrayer: serializer.fromJson<bool>(
        json['notifyDhikrAfterPrayer'],
      ),
      notifyDuaForParents: serializer.fromJson<bool>(
        json['notifyDuaForParents'],
      ),
      notifyFridaySalawat: serializer.fromJson<bool>(
        json['notifyFridaySalawat'],
      ),
      notifyFridayDuaHour: serializer.fromJson<bool>(
        json['notifyFridayDuaHour'],
      ),
      notifyDidYouKnow: serializer.fromJson<bool>(json['notifyDidYouKnow']),
      bedtimeHour: serializer.fromJson<int>(json['bedtimeHour']),
      bedtimeMinute: serializer.fromJson<int>(json['bedtimeMinute']),
      prayerCalculationMethod: serializer.fromJson<String>(
        json['prayerCalculationMethod'],
      ),
      madhab: serializer.fromJson<String>(json['madhab']),
      localeCode: serializer.fromJson<String>(json['localeCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gateDurationSeconds': serializer.toJson<int>(gateDurationSeconds),
      'unlockDurationSeconds': serializer.toJson<int>(unlockDurationSeconds),
      'gateContentCategories': serializer.toJson<String>(gateContentCategories),
      'quranMode': serializer.toJson<String>(quranMode),
      'showTranslation': serializer.toJson<bool>(showTranslation),
      'quranFontSize': serializer.toJson<double>(quranFontSize),
      'translationLanguage': serializer.toJson<String>(translationLanguage),
      'themeMode': serializer.toJson<String>(themeMode),
      'pauseUntilTimestamp': serializer.toJson<int?>(pauseUntilTimestamp),
      'sequentialPositionSurah': serializer.toJson<int>(
        sequentialPositionSurah,
      ),
      'sequentialPositionAyah': serializer.toJson<int>(sequentialPositionAyah),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'streakCurrent': serializer.toJson<int>(streakCurrent),
      'streakLastDate': serializer.toJson<String?>(streakLastDate),
      'notifyPrayerTimes': serializer.toJson<bool>(notifyPrayerTimes),
      'notifyPrayerAdvanceMinutes': serializer.toJson<int>(
        notifyPrayerAdvanceMinutes,
      ),
      'notifyFridayKahf': serializer.toJson<bool>(notifyFridayKahf),
      'notifyFastingDays': serializer.toJson<bool>(notifyFastingDays),
      'notifyMorningAdhkar': serializer.toJson<bool>(notifyMorningAdhkar),
      'notifyEveningAdhkar': serializer.toJson<bool>(notifyEveningAdhkar),
      'notifyBedtimeDua': serializer.toJson<bool>(notifyBedtimeDua),
      'notifySurahMulk': serializer.toJson<bool>(notifySurahMulk),
      'notifyDuhaReminder': serializer.toJson<bool>(notifyDuhaReminder),
      'notifyTahajjud': serializer.toJson<bool>(notifyTahajjud),
      'notifyDhikrAfterPrayer': serializer.toJson<bool>(notifyDhikrAfterPrayer),
      'notifyDuaForParents': serializer.toJson<bool>(notifyDuaForParents),
      'notifyFridaySalawat': serializer.toJson<bool>(notifyFridaySalawat),
      'notifyFridayDuaHour': serializer.toJson<bool>(notifyFridayDuaHour),
      'notifyDidYouKnow': serializer.toJson<bool>(notifyDidYouKnow),
      'bedtimeHour': serializer.toJson<int>(bedtimeHour),
      'bedtimeMinute': serializer.toJson<int>(bedtimeMinute),
      'prayerCalculationMethod': serializer.toJson<String>(
        prayerCalculationMethod,
      ),
      'madhab': serializer.toJson<String>(madhab),
      'localeCode': serializer.toJson<String>(localeCode),
    };
  }

  UserPreference copyWith({
    int? id,
    int? gateDurationSeconds,
    int? unlockDurationSeconds,
    String? gateContentCategories,
    String? quranMode,
    bool? showTranslation,
    double? quranFontSize,
    String? translationLanguage,
    String? themeMode,
    Value<int?> pauseUntilTimestamp = const Value.absent(),
    int? sequentialPositionSurah,
    int? sequentialPositionAyah,
    bool? onboardingCompleted,
    int? streakCurrent,
    Value<String?> streakLastDate = const Value.absent(),
    bool? notifyPrayerTimes,
    int? notifyPrayerAdvanceMinutes,
    bool? notifyFridayKahf,
    bool? notifyFastingDays,
    bool? notifyMorningAdhkar,
    bool? notifyEveningAdhkar,
    bool? notifyBedtimeDua,
    bool? notifySurahMulk,
    bool? notifyDuhaReminder,
    bool? notifyTahajjud,
    bool? notifyDhikrAfterPrayer,
    bool? notifyDuaForParents,
    bool? notifyFridaySalawat,
    bool? notifyFridayDuaHour,
    bool? notifyDidYouKnow,
    int? bedtimeHour,
    int? bedtimeMinute,
    String? prayerCalculationMethod,
    String? madhab,
    String? localeCode,
  }) => UserPreference(
    id: id ?? this.id,
    gateDurationSeconds: gateDurationSeconds ?? this.gateDurationSeconds,
    unlockDurationSeconds: unlockDurationSeconds ?? this.unlockDurationSeconds,
    gateContentCategories: gateContentCategories ?? this.gateContentCategories,
    quranMode: quranMode ?? this.quranMode,
    showTranslation: showTranslation ?? this.showTranslation,
    quranFontSize: quranFontSize ?? this.quranFontSize,
    translationLanguage: translationLanguage ?? this.translationLanguage,
    themeMode: themeMode ?? this.themeMode,
    pauseUntilTimestamp: pauseUntilTimestamp.present
        ? pauseUntilTimestamp.value
        : this.pauseUntilTimestamp,
    sequentialPositionSurah:
        sequentialPositionSurah ?? this.sequentialPositionSurah,
    sequentialPositionAyah:
        sequentialPositionAyah ?? this.sequentialPositionAyah,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    streakCurrent: streakCurrent ?? this.streakCurrent,
    streakLastDate: streakLastDate.present
        ? streakLastDate.value
        : this.streakLastDate,
    notifyPrayerTimes: notifyPrayerTimes ?? this.notifyPrayerTimes,
    notifyPrayerAdvanceMinutes:
        notifyPrayerAdvanceMinutes ?? this.notifyPrayerAdvanceMinutes,
    notifyFridayKahf: notifyFridayKahf ?? this.notifyFridayKahf,
    notifyFastingDays: notifyFastingDays ?? this.notifyFastingDays,
    notifyMorningAdhkar: notifyMorningAdhkar ?? this.notifyMorningAdhkar,
    notifyEveningAdhkar: notifyEveningAdhkar ?? this.notifyEveningAdhkar,
    notifyBedtimeDua: notifyBedtimeDua ?? this.notifyBedtimeDua,
    notifySurahMulk: notifySurahMulk ?? this.notifySurahMulk,
    notifyDuhaReminder: notifyDuhaReminder ?? this.notifyDuhaReminder,
    notifyTahajjud: notifyTahajjud ?? this.notifyTahajjud,
    notifyDhikrAfterPrayer:
        notifyDhikrAfterPrayer ?? this.notifyDhikrAfterPrayer,
    notifyDuaForParents: notifyDuaForParents ?? this.notifyDuaForParents,
    notifyFridaySalawat: notifyFridaySalawat ?? this.notifyFridaySalawat,
    notifyFridayDuaHour: notifyFridayDuaHour ?? this.notifyFridayDuaHour,
    notifyDidYouKnow: notifyDidYouKnow ?? this.notifyDidYouKnow,
    bedtimeHour: bedtimeHour ?? this.bedtimeHour,
    bedtimeMinute: bedtimeMinute ?? this.bedtimeMinute,
    prayerCalculationMethod:
        prayerCalculationMethod ?? this.prayerCalculationMethod,
    madhab: madhab ?? this.madhab,
    localeCode: localeCode ?? this.localeCode,
  );
  UserPreference copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreference(
      id: data.id.present ? data.id.value : this.id,
      gateDurationSeconds: data.gateDurationSeconds.present
          ? data.gateDurationSeconds.value
          : this.gateDurationSeconds,
      unlockDurationSeconds: data.unlockDurationSeconds.present
          ? data.unlockDurationSeconds.value
          : this.unlockDurationSeconds,
      gateContentCategories: data.gateContentCategories.present
          ? data.gateContentCategories.value
          : this.gateContentCategories,
      quranMode: data.quranMode.present ? data.quranMode.value : this.quranMode,
      showTranslation: data.showTranslation.present
          ? data.showTranslation.value
          : this.showTranslation,
      quranFontSize: data.quranFontSize.present
          ? data.quranFontSize.value
          : this.quranFontSize,
      translationLanguage: data.translationLanguage.present
          ? data.translationLanguage.value
          : this.translationLanguage,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      pauseUntilTimestamp: data.pauseUntilTimestamp.present
          ? data.pauseUntilTimestamp.value
          : this.pauseUntilTimestamp,
      sequentialPositionSurah: data.sequentialPositionSurah.present
          ? data.sequentialPositionSurah.value
          : this.sequentialPositionSurah,
      sequentialPositionAyah: data.sequentialPositionAyah.present
          ? data.sequentialPositionAyah.value
          : this.sequentialPositionAyah,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      streakCurrent: data.streakCurrent.present
          ? data.streakCurrent.value
          : this.streakCurrent,
      streakLastDate: data.streakLastDate.present
          ? data.streakLastDate.value
          : this.streakLastDate,
      notifyPrayerTimes: data.notifyPrayerTimes.present
          ? data.notifyPrayerTimes.value
          : this.notifyPrayerTimes,
      notifyPrayerAdvanceMinutes: data.notifyPrayerAdvanceMinutes.present
          ? data.notifyPrayerAdvanceMinutes.value
          : this.notifyPrayerAdvanceMinutes,
      notifyFridayKahf: data.notifyFridayKahf.present
          ? data.notifyFridayKahf.value
          : this.notifyFridayKahf,
      notifyFastingDays: data.notifyFastingDays.present
          ? data.notifyFastingDays.value
          : this.notifyFastingDays,
      notifyMorningAdhkar: data.notifyMorningAdhkar.present
          ? data.notifyMorningAdhkar.value
          : this.notifyMorningAdhkar,
      notifyEveningAdhkar: data.notifyEveningAdhkar.present
          ? data.notifyEveningAdhkar.value
          : this.notifyEveningAdhkar,
      notifyBedtimeDua: data.notifyBedtimeDua.present
          ? data.notifyBedtimeDua.value
          : this.notifyBedtimeDua,
      notifySurahMulk: data.notifySurahMulk.present
          ? data.notifySurahMulk.value
          : this.notifySurahMulk,
      notifyDuhaReminder: data.notifyDuhaReminder.present
          ? data.notifyDuhaReminder.value
          : this.notifyDuhaReminder,
      notifyTahajjud: data.notifyTahajjud.present
          ? data.notifyTahajjud.value
          : this.notifyTahajjud,
      notifyDhikrAfterPrayer: data.notifyDhikrAfterPrayer.present
          ? data.notifyDhikrAfterPrayer.value
          : this.notifyDhikrAfterPrayer,
      notifyDuaForParents: data.notifyDuaForParents.present
          ? data.notifyDuaForParents.value
          : this.notifyDuaForParents,
      notifyFridaySalawat: data.notifyFridaySalawat.present
          ? data.notifyFridaySalawat.value
          : this.notifyFridaySalawat,
      notifyFridayDuaHour: data.notifyFridayDuaHour.present
          ? data.notifyFridayDuaHour.value
          : this.notifyFridayDuaHour,
      notifyDidYouKnow: data.notifyDidYouKnow.present
          ? data.notifyDidYouKnow.value
          : this.notifyDidYouKnow,
      bedtimeHour: data.bedtimeHour.present
          ? data.bedtimeHour.value
          : this.bedtimeHour,
      bedtimeMinute: data.bedtimeMinute.present
          ? data.bedtimeMinute.value
          : this.bedtimeMinute,
      prayerCalculationMethod: data.prayerCalculationMethod.present
          ? data.prayerCalculationMethod.value
          : this.prayerCalculationMethod,
      madhab: data.madhab.present ? data.madhab.value : this.madhab,
      localeCode: data.localeCode.present
          ? data.localeCode.value
          : this.localeCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreference(')
          ..write('id: $id, ')
          ..write('gateDurationSeconds: $gateDurationSeconds, ')
          ..write('unlockDurationSeconds: $unlockDurationSeconds, ')
          ..write('gateContentCategories: $gateContentCategories, ')
          ..write('quranMode: $quranMode, ')
          ..write('showTranslation: $showTranslation, ')
          ..write('quranFontSize: $quranFontSize, ')
          ..write('translationLanguage: $translationLanguage, ')
          ..write('themeMode: $themeMode, ')
          ..write('pauseUntilTimestamp: $pauseUntilTimestamp, ')
          ..write('sequentialPositionSurah: $sequentialPositionSurah, ')
          ..write('sequentialPositionAyah: $sequentialPositionAyah, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('streakCurrent: $streakCurrent, ')
          ..write('streakLastDate: $streakLastDate, ')
          ..write('notifyPrayerTimes: $notifyPrayerTimes, ')
          ..write('notifyPrayerAdvanceMinutes: $notifyPrayerAdvanceMinutes, ')
          ..write('notifyFridayKahf: $notifyFridayKahf, ')
          ..write('notifyFastingDays: $notifyFastingDays, ')
          ..write('notifyMorningAdhkar: $notifyMorningAdhkar, ')
          ..write('notifyEveningAdhkar: $notifyEveningAdhkar, ')
          ..write('notifyBedtimeDua: $notifyBedtimeDua, ')
          ..write('notifySurahMulk: $notifySurahMulk, ')
          ..write('notifyDuhaReminder: $notifyDuhaReminder, ')
          ..write('notifyTahajjud: $notifyTahajjud, ')
          ..write('notifyDhikrAfterPrayer: $notifyDhikrAfterPrayer, ')
          ..write('notifyDuaForParents: $notifyDuaForParents, ')
          ..write('notifyFridaySalawat: $notifyFridaySalawat, ')
          ..write('notifyFridayDuaHour: $notifyFridayDuaHour, ')
          ..write('notifyDidYouKnow: $notifyDidYouKnow, ')
          ..write('bedtimeHour: $bedtimeHour, ')
          ..write('bedtimeMinute: $bedtimeMinute, ')
          ..write('prayerCalculationMethod: $prayerCalculationMethod, ')
          ..write('madhab: $madhab, ')
          ..write('localeCode: $localeCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    gateDurationSeconds,
    unlockDurationSeconds,
    gateContentCategories,
    quranMode,
    showTranslation,
    quranFontSize,
    translationLanguage,
    themeMode,
    pauseUntilTimestamp,
    sequentialPositionSurah,
    sequentialPositionAyah,
    onboardingCompleted,
    streakCurrent,
    streakLastDate,
    notifyPrayerTimes,
    notifyPrayerAdvanceMinutes,
    notifyFridayKahf,
    notifyFastingDays,
    notifyMorningAdhkar,
    notifyEveningAdhkar,
    notifyBedtimeDua,
    notifySurahMulk,
    notifyDuhaReminder,
    notifyTahajjud,
    notifyDhikrAfterPrayer,
    notifyDuaForParents,
    notifyFridaySalawat,
    notifyFridayDuaHour,
    notifyDidYouKnow,
    bedtimeHour,
    bedtimeMinute,
    prayerCalculationMethod,
    madhab,
    localeCode,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreference &&
          other.id == this.id &&
          other.gateDurationSeconds == this.gateDurationSeconds &&
          other.unlockDurationSeconds == this.unlockDurationSeconds &&
          other.gateContentCategories == this.gateContentCategories &&
          other.quranMode == this.quranMode &&
          other.showTranslation == this.showTranslation &&
          other.quranFontSize == this.quranFontSize &&
          other.translationLanguage == this.translationLanguage &&
          other.themeMode == this.themeMode &&
          other.pauseUntilTimestamp == this.pauseUntilTimestamp &&
          other.sequentialPositionSurah == this.sequentialPositionSurah &&
          other.sequentialPositionAyah == this.sequentialPositionAyah &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.streakCurrent == this.streakCurrent &&
          other.streakLastDate == this.streakLastDate &&
          other.notifyPrayerTimes == this.notifyPrayerTimes &&
          other.notifyPrayerAdvanceMinutes == this.notifyPrayerAdvanceMinutes &&
          other.notifyFridayKahf == this.notifyFridayKahf &&
          other.notifyFastingDays == this.notifyFastingDays &&
          other.notifyMorningAdhkar == this.notifyMorningAdhkar &&
          other.notifyEveningAdhkar == this.notifyEveningAdhkar &&
          other.notifyBedtimeDua == this.notifyBedtimeDua &&
          other.notifySurahMulk == this.notifySurahMulk &&
          other.notifyDuhaReminder == this.notifyDuhaReminder &&
          other.notifyTahajjud == this.notifyTahajjud &&
          other.notifyDhikrAfterPrayer == this.notifyDhikrAfterPrayer &&
          other.notifyDuaForParents == this.notifyDuaForParents &&
          other.notifyFridaySalawat == this.notifyFridaySalawat &&
          other.notifyFridayDuaHour == this.notifyFridayDuaHour &&
          other.notifyDidYouKnow == this.notifyDidYouKnow &&
          other.bedtimeHour == this.bedtimeHour &&
          other.bedtimeMinute == this.bedtimeMinute &&
          other.prayerCalculationMethod == this.prayerCalculationMethod &&
          other.madhab == this.madhab &&
          other.localeCode == this.localeCode);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreference> {
  final Value<int> id;
  final Value<int> gateDurationSeconds;
  final Value<int> unlockDurationSeconds;
  final Value<String> gateContentCategories;
  final Value<String> quranMode;
  final Value<bool> showTranslation;
  final Value<double> quranFontSize;
  final Value<String> translationLanguage;
  final Value<String> themeMode;
  final Value<int?> pauseUntilTimestamp;
  final Value<int> sequentialPositionSurah;
  final Value<int> sequentialPositionAyah;
  final Value<bool> onboardingCompleted;
  final Value<int> streakCurrent;
  final Value<String?> streakLastDate;
  final Value<bool> notifyPrayerTimes;
  final Value<int> notifyPrayerAdvanceMinutes;
  final Value<bool> notifyFridayKahf;
  final Value<bool> notifyFastingDays;
  final Value<bool> notifyMorningAdhkar;
  final Value<bool> notifyEveningAdhkar;
  final Value<bool> notifyBedtimeDua;
  final Value<bool> notifySurahMulk;
  final Value<bool> notifyDuhaReminder;
  final Value<bool> notifyTahajjud;
  final Value<bool> notifyDhikrAfterPrayer;
  final Value<bool> notifyDuaForParents;
  final Value<bool> notifyFridaySalawat;
  final Value<bool> notifyFridayDuaHour;
  final Value<bool> notifyDidYouKnow;
  final Value<int> bedtimeHour;
  final Value<int> bedtimeMinute;
  final Value<String> prayerCalculationMethod;
  final Value<String> madhab;
  final Value<String> localeCode;
  const UserPreferencesCompanion({
    this.id = const Value.absent(),
    this.gateDurationSeconds = const Value.absent(),
    this.unlockDurationSeconds = const Value.absent(),
    this.gateContentCategories = const Value.absent(),
    this.quranMode = const Value.absent(),
    this.showTranslation = const Value.absent(),
    this.quranFontSize = const Value.absent(),
    this.translationLanguage = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.pauseUntilTimestamp = const Value.absent(),
    this.sequentialPositionSurah = const Value.absent(),
    this.sequentialPositionAyah = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.streakCurrent = const Value.absent(),
    this.streakLastDate = const Value.absent(),
    this.notifyPrayerTimes = const Value.absent(),
    this.notifyPrayerAdvanceMinutes = const Value.absent(),
    this.notifyFridayKahf = const Value.absent(),
    this.notifyFastingDays = const Value.absent(),
    this.notifyMorningAdhkar = const Value.absent(),
    this.notifyEveningAdhkar = const Value.absent(),
    this.notifyBedtimeDua = const Value.absent(),
    this.notifySurahMulk = const Value.absent(),
    this.notifyDuhaReminder = const Value.absent(),
    this.notifyTahajjud = const Value.absent(),
    this.notifyDhikrAfterPrayer = const Value.absent(),
    this.notifyDuaForParents = const Value.absent(),
    this.notifyFridaySalawat = const Value.absent(),
    this.notifyFridayDuaHour = const Value.absent(),
    this.notifyDidYouKnow = const Value.absent(),
    this.bedtimeHour = const Value.absent(),
    this.bedtimeMinute = const Value.absent(),
    this.prayerCalculationMethod = const Value.absent(),
    this.madhab = const Value.absent(),
    this.localeCode = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    this.id = const Value.absent(),
    this.gateDurationSeconds = const Value.absent(),
    this.unlockDurationSeconds = const Value.absent(),
    this.gateContentCategories = const Value.absent(),
    this.quranMode = const Value.absent(),
    this.showTranslation = const Value.absent(),
    this.quranFontSize = const Value.absent(),
    this.translationLanguage = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.pauseUntilTimestamp = const Value.absent(),
    this.sequentialPositionSurah = const Value.absent(),
    this.sequentialPositionAyah = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.streakCurrent = const Value.absent(),
    this.streakLastDate = const Value.absent(),
    this.notifyPrayerTimes = const Value.absent(),
    this.notifyPrayerAdvanceMinutes = const Value.absent(),
    this.notifyFridayKahf = const Value.absent(),
    this.notifyFastingDays = const Value.absent(),
    this.notifyMorningAdhkar = const Value.absent(),
    this.notifyEveningAdhkar = const Value.absent(),
    this.notifyBedtimeDua = const Value.absent(),
    this.notifySurahMulk = const Value.absent(),
    this.notifyDuhaReminder = const Value.absent(),
    this.notifyTahajjud = const Value.absent(),
    this.notifyDhikrAfterPrayer = const Value.absent(),
    this.notifyDuaForParents = const Value.absent(),
    this.notifyFridaySalawat = const Value.absent(),
    this.notifyFridayDuaHour = const Value.absent(),
    this.notifyDidYouKnow = const Value.absent(),
    this.bedtimeHour = const Value.absent(),
    this.bedtimeMinute = const Value.absent(),
    this.prayerCalculationMethod = const Value.absent(),
    this.madhab = const Value.absent(),
    this.localeCode = const Value.absent(),
  });
  static Insertable<UserPreference> custom({
    Expression<int>? id,
    Expression<int>? gateDurationSeconds,
    Expression<int>? unlockDurationSeconds,
    Expression<String>? gateContentCategories,
    Expression<String>? quranMode,
    Expression<bool>? showTranslation,
    Expression<double>? quranFontSize,
    Expression<String>? translationLanguage,
    Expression<String>? themeMode,
    Expression<int>? pauseUntilTimestamp,
    Expression<int>? sequentialPositionSurah,
    Expression<int>? sequentialPositionAyah,
    Expression<bool>? onboardingCompleted,
    Expression<int>? streakCurrent,
    Expression<String>? streakLastDate,
    Expression<bool>? notifyPrayerTimes,
    Expression<int>? notifyPrayerAdvanceMinutes,
    Expression<bool>? notifyFridayKahf,
    Expression<bool>? notifyFastingDays,
    Expression<bool>? notifyMorningAdhkar,
    Expression<bool>? notifyEveningAdhkar,
    Expression<bool>? notifyBedtimeDua,
    Expression<bool>? notifySurahMulk,
    Expression<bool>? notifyDuhaReminder,
    Expression<bool>? notifyTahajjud,
    Expression<bool>? notifyDhikrAfterPrayer,
    Expression<bool>? notifyDuaForParents,
    Expression<bool>? notifyFridaySalawat,
    Expression<bool>? notifyFridayDuaHour,
    Expression<bool>? notifyDidYouKnow,
    Expression<int>? bedtimeHour,
    Expression<int>? bedtimeMinute,
    Expression<String>? prayerCalculationMethod,
    Expression<String>? madhab,
    Expression<String>? localeCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gateDurationSeconds != null)
        'gate_duration_seconds': gateDurationSeconds,
      if (unlockDurationSeconds != null)
        'unlock_duration_seconds': unlockDurationSeconds,
      if (gateContentCategories != null)
        'gate_content_categories': gateContentCategories,
      if (quranMode != null) 'quran_mode': quranMode,
      if (showTranslation != null) 'show_translation': showTranslation,
      if (quranFontSize != null) 'quran_font_size': quranFontSize,
      if (translationLanguage != null)
        'translation_language': translationLanguage,
      if (themeMode != null) 'theme_mode': themeMode,
      if (pauseUntilTimestamp != null)
        'pause_until_timestamp': pauseUntilTimestamp,
      if (sequentialPositionSurah != null)
        'sequential_position_surah': sequentialPositionSurah,
      if (sequentialPositionAyah != null)
        'sequential_position_ayah': sequentialPositionAyah,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (streakCurrent != null) 'streak_current': streakCurrent,
      if (streakLastDate != null) 'streak_last_date': streakLastDate,
      if (notifyPrayerTimes != null) 'notify_prayer_times': notifyPrayerTimes,
      if (notifyPrayerAdvanceMinutes != null)
        'notify_prayer_advance_minutes': notifyPrayerAdvanceMinutes,
      if (notifyFridayKahf != null) 'notify_friday_kahf': notifyFridayKahf,
      if (notifyFastingDays != null) 'notify_fasting_days': notifyFastingDays,
      if (notifyMorningAdhkar != null)
        'notify_morning_adhkar': notifyMorningAdhkar,
      if (notifyEveningAdhkar != null)
        'notify_evening_adhkar': notifyEveningAdhkar,
      if (notifyBedtimeDua != null) 'notify_bedtime_dua': notifyBedtimeDua,
      if (notifySurahMulk != null) 'notify_surah_mulk': notifySurahMulk,
      if (notifyDuhaReminder != null)
        'notify_duha_reminder': notifyDuhaReminder,
      if (notifyTahajjud != null) 'notify_tahajjud': notifyTahajjud,
      if (notifyDhikrAfterPrayer != null)
        'notify_dhikr_after_prayer': notifyDhikrAfterPrayer,
      if (notifyDuaForParents != null)
        'notify_dua_for_parents': notifyDuaForParents,
      if (notifyFridaySalawat != null)
        'notify_friday_salawat': notifyFridaySalawat,
      if (notifyFridayDuaHour != null)
        'notify_friday_dua_hour': notifyFridayDuaHour,
      if (notifyDidYouKnow != null) 'notify_did_you_know': notifyDidYouKnow,
      if (bedtimeHour != null) 'bedtime_hour': bedtimeHour,
      if (bedtimeMinute != null) 'bedtime_minute': bedtimeMinute,
      if (prayerCalculationMethod != null)
        'prayer_calculation_method': prayerCalculationMethod,
      if (madhab != null) 'madhab': madhab,
      if (localeCode != null) 'locale_code': localeCode,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<int>? id,
    Value<int>? gateDurationSeconds,
    Value<int>? unlockDurationSeconds,
    Value<String>? gateContentCategories,
    Value<String>? quranMode,
    Value<bool>? showTranslation,
    Value<double>? quranFontSize,
    Value<String>? translationLanguage,
    Value<String>? themeMode,
    Value<int?>? pauseUntilTimestamp,
    Value<int>? sequentialPositionSurah,
    Value<int>? sequentialPositionAyah,
    Value<bool>? onboardingCompleted,
    Value<int>? streakCurrent,
    Value<String?>? streakLastDate,
    Value<bool>? notifyPrayerTimes,
    Value<int>? notifyPrayerAdvanceMinutes,
    Value<bool>? notifyFridayKahf,
    Value<bool>? notifyFastingDays,
    Value<bool>? notifyMorningAdhkar,
    Value<bool>? notifyEveningAdhkar,
    Value<bool>? notifyBedtimeDua,
    Value<bool>? notifySurahMulk,
    Value<bool>? notifyDuhaReminder,
    Value<bool>? notifyTahajjud,
    Value<bool>? notifyDhikrAfterPrayer,
    Value<bool>? notifyDuaForParents,
    Value<bool>? notifyFridaySalawat,
    Value<bool>? notifyFridayDuaHour,
    Value<bool>? notifyDidYouKnow,
    Value<int>? bedtimeHour,
    Value<int>? bedtimeMinute,
    Value<String>? prayerCalculationMethod,
    Value<String>? madhab,
    Value<String>? localeCode,
  }) {
    return UserPreferencesCompanion(
      id: id ?? this.id,
      gateDurationSeconds: gateDurationSeconds ?? this.gateDurationSeconds,
      unlockDurationSeconds:
          unlockDurationSeconds ?? this.unlockDurationSeconds,
      gateContentCategories:
          gateContentCategories ?? this.gateContentCategories,
      quranMode: quranMode ?? this.quranMode,
      showTranslation: showTranslation ?? this.showTranslation,
      quranFontSize: quranFontSize ?? this.quranFontSize,
      translationLanguage: translationLanguage ?? this.translationLanguage,
      themeMode: themeMode ?? this.themeMode,
      pauseUntilTimestamp: pauseUntilTimestamp ?? this.pauseUntilTimestamp,
      sequentialPositionSurah:
          sequentialPositionSurah ?? this.sequentialPositionSurah,
      sequentialPositionAyah:
          sequentialPositionAyah ?? this.sequentialPositionAyah,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      streakCurrent: streakCurrent ?? this.streakCurrent,
      streakLastDate: streakLastDate ?? this.streakLastDate,
      notifyPrayerTimes: notifyPrayerTimes ?? this.notifyPrayerTimes,
      notifyPrayerAdvanceMinutes:
          notifyPrayerAdvanceMinutes ?? this.notifyPrayerAdvanceMinutes,
      notifyFridayKahf: notifyFridayKahf ?? this.notifyFridayKahf,
      notifyFastingDays: notifyFastingDays ?? this.notifyFastingDays,
      notifyMorningAdhkar: notifyMorningAdhkar ?? this.notifyMorningAdhkar,
      notifyEveningAdhkar: notifyEveningAdhkar ?? this.notifyEveningAdhkar,
      notifyBedtimeDua: notifyBedtimeDua ?? this.notifyBedtimeDua,
      notifySurahMulk: notifySurahMulk ?? this.notifySurahMulk,
      notifyDuhaReminder: notifyDuhaReminder ?? this.notifyDuhaReminder,
      notifyTahajjud: notifyTahajjud ?? this.notifyTahajjud,
      notifyDhikrAfterPrayer:
          notifyDhikrAfterPrayer ?? this.notifyDhikrAfterPrayer,
      notifyDuaForParents: notifyDuaForParents ?? this.notifyDuaForParents,
      notifyFridaySalawat: notifyFridaySalawat ?? this.notifyFridaySalawat,
      notifyFridayDuaHour: notifyFridayDuaHour ?? this.notifyFridayDuaHour,
      notifyDidYouKnow: notifyDidYouKnow ?? this.notifyDidYouKnow,
      bedtimeHour: bedtimeHour ?? this.bedtimeHour,
      bedtimeMinute: bedtimeMinute ?? this.bedtimeMinute,
      prayerCalculationMethod:
          prayerCalculationMethod ?? this.prayerCalculationMethod,
      madhab: madhab ?? this.madhab,
      localeCode: localeCode ?? this.localeCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gateDurationSeconds.present) {
      map['gate_duration_seconds'] = Variable<int>(gateDurationSeconds.value);
    }
    if (unlockDurationSeconds.present) {
      map['unlock_duration_seconds'] = Variable<int>(
        unlockDurationSeconds.value,
      );
    }
    if (gateContentCategories.present) {
      map['gate_content_categories'] = Variable<String>(
        gateContentCategories.value,
      );
    }
    if (quranMode.present) {
      map['quran_mode'] = Variable<String>(quranMode.value);
    }
    if (showTranslation.present) {
      map['show_translation'] = Variable<bool>(showTranslation.value);
    }
    if (quranFontSize.present) {
      map['quran_font_size'] = Variable<double>(quranFontSize.value);
    }
    if (translationLanguage.present) {
      map['translation_language'] = Variable<String>(translationLanguage.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (pauseUntilTimestamp.present) {
      map['pause_until_timestamp'] = Variable<int>(pauseUntilTimestamp.value);
    }
    if (sequentialPositionSurah.present) {
      map['sequential_position_surah'] = Variable<int>(
        sequentialPositionSurah.value,
      );
    }
    if (sequentialPositionAyah.present) {
      map['sequential_position_ayah'] = Variable<int>(
        sequentialPositionAyah.value,
      );
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (streakCurrent.present) {
      map['streak_current'] = Variable<int>(streakCurrent.value);
    }
    if (streakLastDate.present) {
      map['streak_last_date'] = Variable<String>(streakLastDate.value);
    }
    if (notifyPrayerTimes.present) {
      map['notify_prayer_times'] = Variable<bool>(notifyPrayerTimes.value);
    }
    if (notifyPrayerAdvanceMinutes.present) {
      map['notify_prayer_advance_minutes'] = Variable<int>(
        notifyPrayerAdvanceMinutes.value,
      );
    }
    if (notifyFridayKahf.present) {
      map['notify_friday_kahf'] = Variable<bool>(notifyFridayKahf.value);
    }
    if (notifyFastingDays.present) {
      map['notify_fasting_days'] = Variable<bool>(notifyFastingDays.value);
    }
    if (notifyMorningAdhkar.present) {
      map['notify_morning_adhkar'] = Variable<bool>(notifyMorningAdhkar.value);
    }
    if (notifyEveningAdhkar.present) {
      map['notify_evening_adhkar'] = Variable<bool>(notifyEveningAdhkar.value);
    }
    if (notifyBedtimeDua.present) {
      map['notify_bedtime_dua'] = Variable<bool>(notifyBedtimeDua.value);
    }
    if (notifySurahMulk.present) {
      map['notify_surah_mulk'] = Variable<bool>(notifySurahMulk.value);
    }
    if (notifyDuhaReminder.present) {
      map['notify_duha_reminder'] = Variable<bool>(notifyDuhaReminder.value);
    }
    if (notifyTahajjud.present) {
      map['notify_tahajjud'] = Variable<bool>(notifyTahajjud.value);
    }
    if (notifyDhikrAfterPrayer.present) {
      map['notify_dhikr_after_prayer'] = Variable<bool>(
        notifyDhikrAfterPrayer.value,
      );
    }
    if (notifyDuaForParents.present) {
      map['notify_dua_for_parents'] = Variable<bool>(notifyDuaForParents.value);
    }
    if (notifyFridaySalawat.present) {
      map['notify_friday_salawat'] = Variable<bool>(notifyFridaySalawat.value);
    }
    if (notifyFridayDuaHour.present) {
      map['notify_friday_dua_hour'] = Variable<bool>(notifyFridayDuaHour.value);
    }
    if (notifyDidYouKnow.present) {
      map['notify_did_you_know'] = Variable<bool>(notifyDidYouKnow.value);
    }
    if (bedtimeHour.present) {
      map['bedtime_hour'] = Variable<int>(bedtimeHour.value);
    }
    if (bedtimeMinute.present) {
      map['bedtime_minute'] = Variable<int>(bedtimeMinute.value);
    }
    if (prayerCalculationMethod.present) {
      map['prayer_calculation_method'] = Variable<String>(
        prayerCalculationMethod.value,
      );
    }
    if (madhab.present) {
      map['madhab'] = Variable<String>(madhab.value);
    }
    if (localeCode.present) {
      map['locale_code'] = Variable<String>(localeCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('gateDurationSeconds: $gateDurationSeconds, ')
          ..write('unlockDurationSeconds: $unlockDurationSeconds, ')
          ..write('gateContentCategories: $gateContentCategories, ')
          ..write('quranMode: $quranMode, ')
          ..write('showTranslation: $showTranslation, ')
          ..write('quranFontSize: $quranFontSize, ')
          ..write('translationLanguage: $translationLanguage, ')
          ..write('themeMode: $themeMode, ')
          ..write('pauseUntilTimestamp: $pauseUntilTimestamp, ')
          ..write('sequentialPositionSurah: $sequentialPositionSurah, ')
          ..write('sequentialPositionAyah: $sequentialPositionAyah, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('streakCurrent: $streakCurrent, ')
          ..write('streakLastDate: $streakLastDate, ')
          ..write('notifyPrayerTimes: $notifyPrayerTimes, ')
          ..write('notifyPrayerAdvanceMinutes: $notifyPrayerAdvanceMinutes, ')
          ..write('notifyFridayKahf: $notifyFridayKahf, ')
          ..write('notifyFastingDays: $notifyFastingDays, ')
          ..write('notifyMorningAdhkar: $notifyMorningAdhkar, ')
          ..write('notifyEveningAdhkar: $notifyEveningAdhkar, ')
          ..write('notifyBedtimeDua: $notifyBedtimeDua, ')
          ..write('notifySurahMulk: $notifySurahMulk, ')
          ..write('notifyDuhaReminder: $notifyDuhaReminder, ')
          ..write('notifyTahajjud: $notifyTahajjud, ')
          ..write('notifyDhikrAfterPrayer: $notifyDhikrAfterPrayer, ')
          ..write('notifyDuaForParents: $notifyDuaForParents, ')
          ..write('notifyFridaySalawat: $notifyFridaySalawat, ')
          ..write('notifyFridayDuaHour: $notifyFridayDuaHour, ')
          ..write('notifyDidYouKnow: $notifyDidYouKnow, ')
          ..write('bedtimeHour: $bedtimeHour, ')
          ..write('bedtimeMinute: $bedtimeMinute, ')
          ..write('prayerCalculationMethod: $prayerCalculationMethod, ')
          ..write('madhab: $madhab, ')
          ..write('localeCode: $localeCode')
          ..write(')'))
        .toString();
  }
}

class $BlockedAppsTable extends BlockedApps
    with TableInfo<$BlockedAppsTable, BlockedApp> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlockedAppsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _packageNameMeta = const VerificationMeta(
    'packageName',
  );
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
    'package_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    packageName,
    displayName,
    iconKey,
    isActive,
    platform,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blocked_apps';
  @override
  VerificationContext validateIntegrity(
    Insertable<BlockedApp> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('package_name')) {
      context.handle(
        _packageNameMeta,
        packageName.isAcceptableOrUnknown(
          data['package_name']!,
          _packageNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlockedApp map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlockedApp(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      packageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_name'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BlockedAppsTable createAlias(String alias) {
    return $BlockedAppsTable(attachedDatabase, alias);
  }
}

class BlockedApp extends DataClass implements Insertable<BlockedApp> {
  final int id;
  final String packageName;
  final String displayName;
  final String? iconKey;
  final bool isActive;
  final String platform;
  final String createdAt;
  const BlockedApp({
    required this.id,
    required this.packageName,
    required this.displayName,
    this.iconKey,
    required this.isActive,
    required this.platform,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['package_name'] = Variable<String>(packageName);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || iconKey != null) {
      map['icon_key'] = Variable<String>(iconKey);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['platform'] = Variable<String>(platform);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  BlockedAppsCompanion toCompanion(bool nullToAbsent) {
    return BlockedAppsCompanion(
      id: Value(id),
      packageName: Value(packageName),
      displayName: Value(displayName),
      iconKey: iconKey == null && nullToAbsent
          ? const Value.absent()
          : Value(iconKey),
      isActive: Value(isActive),
      platform: Value(platform),
      createdAt: Value(createdAt),
    );
  }

  factory BlockedApp.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlockedApp(
      id: serializer.fromJson<int>(json['id']),
      packageName: serializer.fromJson<String>(json['packageName']),
      displayName: serializer.fromJson<String>(json['displayName']),
      iconKey: serializer.fromJson<String?>(json['iconKey']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      platform: serializer.fromJson<String>(json['platform']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'packageName': serializer.toJson<String>(packageName),
      'displayName': serializer.toJson<String>(displayName),
      'iconKey': serializer.toJson<String?>(iconKey),
      'isActive': serializer.toJson<bool>(isActive),
      'platform': serializer.toJson<String>(platform),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  BlockedApp copyWith({
    int? id,
    String? packageName,
    String? displayName,
    Value<String?> iconKey = const Value.absent(),
    bool? isActive,
    String? platform,
    String? createdAt,
  }) => BlockedApp(
    id: id ?? this.id,
    packageName: packageName ?? this.packageName,
    displayName: displayName ?? this.displayName,
    iconKey: iconKey.present ? iconKey.value : this.iconKey,
    isActive: isActive ?? this.isActive,
    platform: platform ?? this.platform,
    createdAt: createdAt ?? this.createdAt,
  );
  BlockedApp copyWithCompanion(BlockedAppsCompanion data) {
    return BlockedApp(
      id: data.id.present ? data.id.value : this.id,
      packageName: data.packageName.present
          ? data.packageName.value
          : this.packageName,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      platform: data.platform.present ? data.platform.value : this.platform,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlockedApp(')
          ..write('id: $id, ')
          ..write('packageName: $packageName, ')
          ..write('displayName: $displayName, ')
          ..write('iconKey: $iconKey, ')
          ..write('isActive: $isActive, ')
          ..write('platform: $platform, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    packageName,
    displayName,
    iconKey,
    isActive,
    platform,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlockedApp &&
          other.id == this.id &&
          other.packageName == this.packageName &&
          other.displayName == this.displayName &&
          other.iconKey == this.iconKey &&
          other.isActive == this.isActive &&
          other.platform == this.platform &&
          other.createdAt == this.createdAt);
}

class BlockedAppsCompanion extends UpdateCompanion<BlockedApp> {
  final Value<int> id;
  final Value<String> packageName;
  final Value<String> displayName;
  final Value<String?> iconKey;
  final Value<bool> isActive;
  final Value<String> platform;
  final Value<String> createdAt;
  const BlockedAppsCompanion({
    this.id = const Value.absent(),
    this.packageName = const Value.absent(),
    this.displayName = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.isActive = const Value.absent(),
    this.platform = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BlockedAppsCompanion.insert({
    this.id = const Value.absent(),
    required String packageName,
    required String displayName,
    this.iconKey = const Value.absent(),
    this.isActive = const Value.absent(),
    required String platform,
    required String createdAt,
  }) : packageName = Value(packageName),
       displayName = Value(displayName),
       platform = Value(platform),
       createdAt = Value(createdAt);
  static Insertable<BlockedApp> custom({
    Expression<int>? id,
    Expression<String>? packageName,
    Expression<String>? displayName,
    Expression<String>? iconKey,
    Expression<bool>? isActive,
    Expression<String>? platform,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (packageName != null) 'package_name': packageName,
      if (displayName != null) 'display_name': displayName,
      if (iconKey != null) 'icon_key': iconKey,
      if (isActive != null) 'is_active': isActive,
      if (platform != null) 'platform': platform,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BlockedAppsCompanion copyWith({
    Value<int>? id,
    Value<String>? packageName,
    Value<String>? displayName,
    Value<String?>? iconKey,
    Value<bool>? isActive,
    Value<String>? platform,
    Value<String>? createdAt,
  }) {
    return BlockedAppsCompanion(
      id: id ?? this.id,
      packageName: packageName ?? this.packageName,
      displayName: displayName ?? this.displayName,
      iconKey: iconKey ?? this.iconKey,
      isActive: isActive ?? this.isActive,
      platform: platform ?? this.platform,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlockedAppsCompanion(')
          ..write('id: $id, ')
          ..write('packageName: $packageName, ')
          ..write('displayName: $displayName, ')
          ..write('iconKey: $iconKey, ')
          ..write('isActive: $isActive, ')
          ..write('platform: $platform, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $GateSessionsTable extends GateSessions
    with TableInfo<$GateSessionsTable, GateSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GateSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _blockedAppIdMeta = const VerificationMeta(
    'blockedAppId',
  );
  @override
  late final GeneratedColumn<int> blockedAppId = GeneratedColumn<int>(
    'blocked_app_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES blocked_apps (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<String> startedAt = GeneratedColumn<String>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<String> completedAt = GeneratedColumn<String>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualDurationSecondsMeta =
      const VerificationMeta('actualDurationSeconds');
  @override
  late final GeneratedColumn<int> actualDurationSeconds = GeneratedColumn<int>(
    'actual_duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gateContentTypeMeta = const VerificationMeta(
    'gateContentType',
  );
  @override
  late final GeneratedColumn<String> gateContentType = GeneratedColumn<String>(
    'gate_content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quranSurahMeta = const VerificationMeta(
    'quranSurah',
  );
  @override
  late final GeneratedColumn<int> quranSurah = GeneratedColumn<int>(
    'quran_surah',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quranAyahStartMeta = const VerificationMeta(
    'quranAyahStart',
  );
  @override
  late final GeneratedColumn<int> quranAyahStart = GeneratedColumn<int>(
    'quran_ayah_start',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quranAyahEndMeta = const VerificationMeta(
    'quranAyahEnd',
  );
  @override
  late final GeneratedColumn<int> quranAyahEnd = GeneratedColumn<int>(
    'quran_ayah_end',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _duaIdMeta = const VerificationMeta('duaId');
  @override
  late final GeneratedColumn<int> duaId = GeneratedColumn<int>(
    'dua_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _storyIdMeta = const VerificationMeta(
    'storyId',
  );
  @override
  late final GeneratedColumn<int> storyId = GeneratedColumn<int>(
    'story_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _teachingIdMeta = const VerificationMeta(
    'teachingId',
  );
  @override
  late final GeneratedColumn<int> teachingId = GeneratedColumn<int>(
    'teaching_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sahabahStoryIdMeta = const VerificationMeta(
    'sahabahStoryId',
  );
  @override
  late final GeneratedColumn<int> sahabahStoryId = GeneratedColumn<int>(
    'sahabah_story_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _historyIdMeta = const VerificationMeta(
    'historyId',
  );
  @override
  late final GeneratedColumn<int> historyId = GeneratedColumn<int>(
    'history_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _extraReadingSecondsMeta =
      const VerificationMeta('extraReadingSeconds');
  @override
  late final GeneratedColumn<int> extraReadingSeconds = GeneratedColumn<int>(
    'extra_reading_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _wasCompletedMeta = const VerificationMeta(
    'wasCompleted',
  );
  @override
  late final GeneratedColumn<bool> wasCompleted = GeneratedColumn<bool>(
    'was_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _continuedReadingMeta = const VerificationMeta(
    'continuedReading',
  );
  @override
  late final GeneratedColumn<bool> continuedReading = GeneratedColumn<bool>(
    'continued_reading',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("continued_reading" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    blockedAppId,
    startedAt,
    completedAt,
    durationSeconds,
    actualDurationSeconds,
    gateContentType,
    quranSurah,
    quranAyahStart,
    quranAyahEnd,
    duaId,
    storyId,
    teachingId,
    sahabahStoryId,
    historyId,
    extraReadingSeconds,
    wasCompleted,
    continuedReading,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gate_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<GateSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('blocked_app_id')) {
      context.handle(
        _blockedAppIdMeta,
        blockedAppId.isAcceptableOrUnknown(
          data['blocked_app_id']!,
          _blockedAppIdMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('actual_duration_seconds')) {
      context.handle(
        _actualDurationSecondsMeta,
        actualDurationSeconds.isAcceptableOrUnknown(
          data['actual_duration_seconds']!,
          _actualDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('gate_content_type')) {
      context.handle(
        _gateContentTypeMeta,
        gateContentType.isAcceptableOrUnknown(
          data['gate_content_type']!,
          _gateContentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gateContentTypeMeta);
    }
    if (data.containsKey('quran_surah')) {
      context.handle(
        _quranSurahMeta,
        quranSurah.isAcceptableOrUnknown(data['quran_surah']!, _quranSurahMeta),
      );
    }
    if (data.containsKey('quran_ayah_start')) {
      context.handle(
        _quranAyahStartMeta,
        quranAyahStart.isAcceptableOrUnknown(
          data['quran_ayah_start']!,
          _quranAyahStartMeta,
        ),
      );
    }
    if (data.containsKey('quran_ayah_end')) {
      context.handle(
        _quranAyahEndMeta,
        quranAyahEnd.isAcceptableOrUnknown(
          data['quran_ayah_end']!,
          _quranAyahEndMeta,
        ),
      );
    }
    if (data.containsKey('dua_id')) {
      context.handle(
        _duaIdMeta,
        duaId.isAcceptableOrUnknown(data['dua_id']!, _duaIdMeta),
      );
    }
    if (data.containsKey('story_id')) {
      context.handle(
        _storyIdMeta,
        storyId.isAcceptableOrUnknown(data['story_id']!, _storyIdMeta),
      );
    }
    if (data.containsKey('teaching_id')) {
      context.handle(
        _teachingIdMeta,
        teachingId.isAcceptableOrUnknown(data['teaching_id']!, _teachingIdMeta),
      );
    }
    if (data.containsKey('sahabah_story_id')) {
      context.handle(
        _sahabahStoryIdMeta,
        sahabahStoryId.isAcceptableOrUnknown(
          data['sahabah_story_id']!,
          _sahabahStoryIdMeta,
        ),
      );
    }
    if (data.containsKey('history_id')) {
      context.handle(
        _historyIdMeta,
        historyId.isAcceptableOrUnknown(data['history_id']!, _historyIdMeta),
      );
    }
    if (data.containsKey('extra_reading_seconds')) {
      context.handle(
        _extraReadingSecondsMeta,
        extraReadingSeconds.isAcceptableOrUnknown(
          data['extra_reading_seconds']!,
          _extraReadingSecondsMeta,
        ),
      );
    }
    if (data.containsKey('was_completed')) {
      context.handle(
        _wasCompletedMeta,
        wasCompleted.isAcceptableOrUnknown(
          data['was_completed']!,
          _wasCompletedMeta,
        ),
      );
    }
    if (data.containsKey('continued_reading')) {
      context.handle(
        _continuedReadingMeta,
        continuedReading.isAcceptableOrUnknown(
          data['continued_reading']!,
          _continuedReadingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GateSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GateSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      blockedAppId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}blocked_app_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_at'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      actualDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_duration_seconds'],
      ),
      gateContentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gate_content_type'],
      )!,
      quranSurah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quran_surah'],
      ),
      quranAyahStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quran_ayah_start'],
      ),
      quranAyahEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quran_ayah_end'],
      ),
      duaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dua_id'],
      ),
      storyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}story_id'],
      ),
      teachingId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}teaching_id'],
      ),
      sahabahStoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sahabah_story_id'],
      ),
      historyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}history_id'],
      ),
      extraReadingSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}extra_reading_seconds'],
      )!,
      wasCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_completed'],
      )!,
      continuedReading: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}continued_reading'],
      )!,
    );
  }

  @override
  $GateSessionsTable createAlias(String alias) {
    return $GateSessionsTable(attachedDatabase, alias);
  }
}

class GateSession extends DataClass implements Insertable<GateSession> {
  final int id;
  final int? blockedAppId;
  final String startedAt;
  final String? completedAt;
  final int durationSeconds;
  final int? actualDurationSeconds;
  final String gateContentType;
  final int? quranSurah;
  final int? quranAyahStart;
  final int? quranAyahEnd;
  final int? duaId;
  final int? storyId;
  final int? teachingId;
  final int? sahabahStoryId;
  final int? historyId;
  final int extraReadingSeconds;
  final bool wasCompleted;
  final bool continuedReading;
  const GateSession({
    required this.id,
    this.blockedAppId,
    required this.startedAt,
    this.completedAt,
    required this.durationSeconds,
    this.actualDurationSeconds,
    required this.gateContentType,
    this.quranSurah,
    this.quranAyahStart,
    this.quranAyahEnd,
    this.duaId,
    this.storyId,
    this.teachingId,
    this.sahabahStoryId,
    this.historyId,
    required this.extraReadingSeconds,
    required this.wasCompleted,
    required this.continuedReading,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || blockedAppId != null) {
      map['blocked_app_id'] = Variable<int>(blockedAppId);
    }
    map['started_at'] = Variable<String>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<String>(completedAt);
    }
    map['duration_seconds'] = Variable<int>(durationSeconds);
    if (!nullToAbsent || actualDurationSeconds != null) {
      map['actual_duration_seconds'] = Variable<int>(actualDurationSeconds);
    }
    map['gate_content_type'] = Variable<String>(gateContentType);
    if (!nullToAbsent || quranSurah != null) {
      map['quran_surah'] = Variable<int>(quranSurah);
    }
    if (!nullToAbsent || quranAyahStart != null) {
      map['quran_ayah_start'] = Variable<int>(quranAyahStart);
    }
    if (!nullToAbsent || quranAyahEnd != null) {
      map['quran_ayah_end'] = Variable<int>(quranAyahEnd);
    }
    if (!nullToAbsent || duaId != null) {
      map['dua_id'] = Variable<int>(duaId);
    }
    if (!nullToAbsent || storyId != null) {
      map['story_id'] = Variable<int>(storyId);
    }
    if (!nullToAbsent || teachingId != null) {
      map['teaching_id'] = Variable<int>(teachingId);
    }
    if (!nullToAbsent || sahabahStoryId != null) {
      map['sahabah_story_id'] = Variable<int>(sahabahStoryId);
    }
    if (!nullToAbsent || historyId != null) {
      map['history_id'] = Variable<int>(historyId);
    }
    map['extra_reading_seconds'] = Variable<int>(extraReadingSeconds);
    map['was_completed'] = Variable<bool>(wasCompleted);
    map['continued_reading'] = Variable<bool>(continuedReading);
    return map;
  }

  GateSessionsCompanion toCompanion(bool nullToAbsent) {
    return GateSessionsCompanion(
      id: Value(id),
      blockedAppId: blockedAppId == null && nullToAbsent
          ? const Value.absent()
          : Value(blockedAppId),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      durationSeconds: Value(durationSeconds),
      actualDurationSeconds: actualDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDurationSeconds),
      gateContentType: Value(gateContentType),
      quranSurah: quranSurah == null && nullToAbsent
          ? const Value.absent()
          : Value(quranSurah),
      quranAyahStart: quranAyahStart == null && nullToAbsent
          ? const Value.absent()
          : Value(quranAyahStart),
      quranAyahEnd: quranAyahEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(quranAyahEnd),
      duaId: duaId == null && nullToAbsent
          ? const Value.absent()
          : Value(duaId),
      storyId: storyId == null && nullToAbsent
          ? const Value.absent()
          : Value(storyId),
      teachingId: teachingId == null && nullToAbsent
          ? const Value.absent()
          : Value(teachingId),
      sahabahStoryId: sahabahStoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(sahabahStoryId),
      historyId: historyId == null && nullToAbsent
          ? const Value.absent()
          : Value(historyId),
      extraReadingSeconds: Value(extraReadingSeconds),
      wasCompleted: Value(wasCompleted),
      continuedReading: Value(continuedReading),
    );
  }

  factory GateSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GateSession(
      id: serializer.fromJson<int>(json['id']),
      blockedAppId: serializer.fromJson<int?>(json['blockedAppId']),
      startedAt: serializer.fromJson<String>(json['startedAt']),
      completedAt: serializer.fromJson<String?>(json['completedAt']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      actualDurationSeconds: serializer.fromJson<int?>(
        json['actualDurationSeconds'],
      ),
      gateContentType: serializer.fromJson<String>(json['gateContentType']),
      quranSurah: serializer.fromJson<int?>(json['quranSurah']),
      quranAyahStart: serializer.fromJson<int?>(json['quranAyahStart']),
      quranAyahEnd: serializer.fromJson<int?>(json['quranAyahEnd']),
      duaId: serializer.fromJson<int?>(json['duaId']),
      storyId: serializer.fromJson<int?>(json['storyId']),
      teachingId: serializer.fromJson<int?>(json['teachingId']),
      sahabahStoryId: serializer.fromJson<int?>(json['sahabahStoryId']),
      historyId: serializer.fromJson<int?>(json['historyId']),
      extraReadingSeconds: serializer.fromJson<int>(
        json['extraReadingSeconds'],
      ),
      wasCompleted: serializer.fromJson<bool>(json['wasCompleted']),
      continuedReading: serializer.fromJson<bool>(json['continuedReading']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'blockedAppId': serializer.toJson<int?>(blockedAppId),
      'startedAt': serializer.toJson<String>(startedAt),
      'completedAt': serializer.toJson<String?>(completedAt),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'actualDurationSeconds': serializer.toJson<int?>(actualDurationSeconds),
      'gateContentType': serializer.toJson<String>(gateContentType),
      'quranSurah': serializer.toJson<int?>(quranSurah),
      'quranAyahStart': serializer.toJson<int?>(quranAyahStart),
      'quranAyahEnd': serializer.toJson<int?>(quranAyahEnd),
      'duaId': serializer.toJson<int?>(duaId),
      'storyId': serializer.toJson<int?>(storyId),
      'teachingId': serializer.toJson<int?>(teachingId),
      'sahabahStoryId': serializer.toJson<int?>(sahabahStoryId),
      'historyId': serializer.toJson<int?>(historyId),
      'extraReadingSeconds': serializer.toJson<int>(extraReadingSeconds),
      'wasCompleted': serializer.toJson<bool>(wasCompleted),
      'continuedReading': serializer.toJson<bool>(continuedReading),
    };
  }

  GateSession copyWith({
    int? id,
    Value<int?> blockedAppId = const Value.absent(),
    String? startedAt,
    Value<String?> completedAt = const Value.absent(),
    int? durationSeconds,
    Value<int?> actualDurationSeconds = const Value.absent(),
    String? gateContentType,
    Value<int?> quranSurah = const Value.absent(),
    Value<int?> quranAyahStart = const Value.absent(),
    Value<int?> quranAyahEnd = const Value.absent(),
    Value<int?> duaId = const Value.absent(),
    Value<int?> storyId = const Value.absent(),
    Value<int?> teachingId = const Value.absent(),
    Value<int?> sahabahStoryId = const Value.absent(),
    Value<int?> historyId = const Value.absent(),
    int? extraReadingSeconds,
    bool? wasCompleted,
    bool? continuedReading,
  }) => GateSession(
    id: id ?? this.id,
    blockedAppId: blockedAppId.present ? blockedAppId.value : this.blockedAppId,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    actualDurationSeconds: actualDurationSeconds.present
        ? actualDurationSeconds.value
        : this.actualDurationSeconds,
    gateContentType: gateContentType ?? this.gateContentType,
    quranSurah: quranSurah.present ? quranSurah.value : this.quranSurah,
    quranAyahStart: quranAyahStart.present
        ? quranAyahStart.value
        : this.quranAyahStart,
    quranAyahEnd: quranAyahEnd.present ? quranAyahEnd.value : this.quranAyahEnd,
    duaId: duaId.present ? duaId.value : this.duaId,
    storyId: storyId.present ? storyId.value : this.storyId,
    teachingId: teachingId.present ? teachingId.value : this.teachingId,
    sahabahStoryId: sahabahStoryId.present
        ? sahabahStoryId.value
        : this.sahabahStoryId,
    historyId: historyId.present ? historyId.value : this.historyId,
    extraReadingSeconds: extraReadingSeconds ?? this.extraReadingSeconds,
    wasCompleted: wasCompleted ?? this.wasCompleted,
    continuedReading: continuedReading ?? this.continuedReading,
  );
  GateSession copyWithCompanion(GateSessionsCompanion data) {
    return GateSession(
      id: data.id.present ? data.id.value : this.id,
      blockedAppId: data.blockedAppId.present
          ? data.blockedAppId.value
          : this.blockedAppId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      actualDurationSeconds: data.actualDurationSeconds.present
          ? data.actualDurationSeconds.value
          : this.actualDurationSeconds,
      gateContentType: data.gateContentType.present
          ? data.gateContentType.value
          : this.gateContentType,
      quranSurah: data.quranSurah.present
          ? data.quranSurah.value
          : this.quranSurah,
      quranAyahStart: data.quranAyahStart.present
          ? data.quranAyahStart.value
          : this.quranAyahStart,
      quranAyahEnd: data.quranAyahEnd.present
          ? data.quranAyahEnd.value
          : this.quranAyahEnd,
      duaId: data.duaId.present ? data.duaId.value : this.duaId,
      storyId: data.storyId.present ? data.storyId.value : this.storyId,
      teachingId: data.teachingId.present
          ? data.teachingId.value
          : this.teachingId,
      sahabahStoryId: data.sahabahStoryId.present
          ? data.sahabahStoryId.value
          : this.sahabahStoryId,
      historyId: data.historyId.present ? data.historyId.value : this.historyId,
      extraReadingSeconds: data.extraReadingSeconds.present
          ? data.extraReadingSeconds.value
          : this.extraReadingSeconds,
      wasCompleted: data.wasCompleted.present
          ? data.wasCompleted.value
          : this.wasCompleted,
      continuedReading: data.continuedReading.present
          ? data.continuedReading.value
          : this.continuedReading,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GateSession(')
          ..write('id: $id, ')
          ..write('blockedAppId: $blockedAppId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('actualDurationSeconds: $actualDurationSeconds, ')
          ..write('gateContentType: $gateContentType, ')
          ..write('quranSurah: $quranSurah, ')
          ..write('quranAyahStart: $quranAyahStart, ')
          ..write('quranAyahEnd: $quranAyahEnd, ')
          ..write('duaId: $duaId, ')
          ..write('storyId: $storyId, ')
          ..write('teachingId: $teachingId, ')
          ..write('sahabahStoryId: $sahabahStoryId, ')
          ..write('historyId: $historyId, ')
          ..write('extraReadingSeconds: $extraReadingSeconds, ')
          ..write('wasCompleted: $wasCompleted, ')
          ..write('continuedReading: $continuedReading')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    blockedAppId,
    startedAt,
    completedAt,
    durationSeconds,
    actualDurationSeconds,
    gateContentType,
    quranSurah,
    quranAyahStart,
    quranAyahEnd,
    duaId,
    storyId,
    teachingId,
    sahabahStoryId,
    historyId,
    extraReadingSeconds,
    wasCompleted,
    continuedReading,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GateSession &&
          other.id == this.id &&
          other.blockedAppId == this.blockedAppId &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.durationSeconds == this.durationSeconds &&
          other.actualDurationSeconds == this.actualDurationSeconds &&
          other.gateContentType == this.gateContentType &&
          other.quranSurah == this.quranSurah &&
          other.quranAyahStart == this.quranAyahStart &&
          other.quranAyahEnd == this.quranAyahEnd &&
          other.duaId == this.duaId &&
          other.storyId == this.storyId &&
          other.teachingId == this.teachingId &&
          other.sahabahStoryId == this.sahabahStoryId &&
          other.historyId == this.historyId &&
          other.extraReadingSeconds == this.extraReadingSeconds &&
          other.wasCompleted == this.wasCompleted &&
          other.continuedReading == this.continuedReading);
}

class GateSessionsCompanion extends UpdateCompanion<GateSession> {
  final Value<int> id;
  final Value<int?> blockedAppId;
  final Value<String> startedAt;
  final Value<String?> completedAt;
  final Value<int> durationSeconds;
  final Value<int?> actualDurationSeconds;
  final Value<String> gateContentType;
  final Value<int?> quranSurah;
  final Value<int?> quranAyahStart;
  final Value<int?> quranAyahEnd;
  final Value<int?> duaId;
  final Value<int?> storyId;
  final Value<int?> teachingId;
  final Value<int?> sahabahStoryId;
  final Value<int?> historyId;
  final Value<int> extraReadingSeconds;
  final Value<bool> wasCompleted;
  final Value<bool> continuedReading;
  const GateSessionsCompanion({
    this.id = const Value.absent(),
    this.blockedAppId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.actualDurationSeconds = const Value.absent(),
    this.gateContentType = const Value.absent(),
    this.quranSurah = const Value.absent(),
    this.quranAyahStart = const Value.absent(),
    this.quranAyahEnd = const Value.absent(),
    this.duaId = const Value.absent(),
    this.storyId = const Value.absent(),
    this.teachingId = const Value.absent(),
    this.sahabahStoryId = const Value.absent(),
    this.historyId = const Value.absent(),
    this.extraReadingSeconds = const Value.absent(),
    this.wasCompleted = const Value.absent(),
    this.continuedReading = const Value.absent(),
  });
  GateSessionsCompanion.insert({
    this.id = const Value.absent(),
    this.blockedAppId = const Value.absent(),
    required String startedAt,
    this.completedAt = const Value.absent(),
    required int durationSeconds,
    this.actualDurationSeconds = const Value.absent(),
    required String gateContentType,
    this.quranSurah = const Value.absent(),
    this.quranAyahStart = const Value.absent(),
    this.quranAyahEnd = const Value.absent(),
    this.duaId = const Value.absent(),
    this.storyId = const Value.absent(),
    this.teachingId = const Value.absent(),
    this.sahabahStoryId = const Value.absent(),
    this.historyId = const Value.absent(),
    this.extraReadingSeconds = const Value.absent(),
    this.wasCompleted = const Value.absent(),
    this.continuedReading = const Value.absent(),
  }) : startedAt = Value(startedAt),
       durationSeconds = Value(durationSeconds),
       gateContentType = Value(gateContentType);
  static Insertable<GateSession> custom({
    Expression<int>? id,
    Expression<int>? blockedAppId,
    Expression<String>? startedAt,
    Expression<String>? completedAt,
    Expression<int>? durationSeconds,
    Expression<int>? actualDurationSeconds,
    Expression<String>? gateContentType,
    Expression<int>? quranSurah,
    Expression<int>? quranAyahStart,
    Expression<int>? quranAyahEnd,
    Expression<int>? duaId,
    Expression<int>? storyId,
    Expression<int>? teachingId,
    Expression<int>? sahabahStoryId,
    Expression<int>? historyId,
    Expression<int>? extraReadingSeconds,
    Expression<bool>? wasCompleted,
    Expression<bool>? continuedReading,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (blockedAppId != null) 'blocked_app_id': blockedAppId,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (actualDurationSeconds != null)
        'actual_duration_seconds': actualDurationSeconds,
      if (gateContentType != null) 'gate_content_type': gateContentType,
      if (quranSurah != null) 'quran_surah': quranSurah,
      if (quranAyahStart != null) 'quran_ayah_start': quranAyahStart,
      if (quranAyahEnd != null) 'quran_ayah_end': quranAyahEnd,
      if (duaId != null) 'dua_id': duaId,
      if (storyId != null) 'story_id': storyId,
      if (teachingId != null) 'teaching_id': teachingId,
      if (sahabahStoryId != null) 'sahabah_story_id': sahabahStoryId,
      if (historyId != null) 'history_id': historyId,
      if (extraReadingSeconds != null)
        'extra_reading_seconds': extraReadingSeconds,
      if (wasCompleted != null) 'was_completed': wasCompleted,
      if (continuedReading != null) 'continued_reading': continuedReading,
    });
  }

  GateSessionsCompanion copyWith({
    Value<int>? id,
    Value<int?>? blockedAppId,
    Value<String>? startedAt,
    Value<String?>? completedAt,
    Value<int>? durationSeconds,
    Value<int?>? actualDurationSeconds,
    Value<String>? gateContentType,
    Value<int?>? quranSurah,
    Value<int?>? quranAyahStart,
    Value<int?>? quranAyahEnd,
    Value<int?>? duaId,
    Value<int?>? storyId,
    Value<int?>? teachingId,
    Value<int?>? sahabahStoryId,
    Value<int?>? historyId,
    Value<int>? extraReadingSeconds,
    Value<bool>? wasCompleted,
    Value<bool>? continuedReading,
  }) {
    return GateSessionsCompanion(
      id: id ?? this.id,
      blockedAppId: blockedAppId ?? this.blockedAppId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      actualDurationSeconds:
          actualDurationSeconds ?? this.actualDurationSeconds,
      gateContentType: gateContentType ?? this.gateContentType,
      quranSurah: quranSurah ?? this.quranSurah,
      quranAyahStart: quranAyahStart ?? this.quranAyahStart,
      quranAyahEnd: quranAyahEnd ?? this.quranAyahEnd,
      duaId: duaId ?? this.duaId,
      storyId: storyId ?? this.storyId,
      teachingId: teachingId ?? this.teachingId,
      sahabahStoryId: sahabahStoryId ?? this.sahabahStoryId,
      historyId: historyId ?? this.historyId,
      extraReadingSeconds: extraReadingSeconds ?? this.extraReadingSeconds,
      wasCompleted: wasCompleted ?? this.wasCompleted,
      continuedReading: continuedReading ?? this.continuedReading,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (blockedAppId.present) {
      map['blocked_app_id'] = Variable<int>(blockedAppId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<String>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<String>(completedAt.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (actualDurationSeconds.present) {
      map['actual_duration_seconds'] = Variable<int>(
        actualDurationSeconds.value,
      );
    }
    if (gateContentType.present) {
      map['gate_content_type'] = Variable<String>(gateContentType.value);
    }
    if (quranSurah.present) {
      map['quran_surah'] = Variable<int>(quranSurah.value);
    }
    if (quranAyahStart.present) {
      map['quran_ayah_start'] = Variable<int>(quranAyahStart.value);
    }
    if (quranAyahEnd.present) {
      map['quran_ayah_end'] = Variable<int>(quranAyahEnd.value);
    }
    if (duaId.present) {
      map['dua_id'] = Variable<int>(duaId.value);
    }
    if (storyId.present) {
      map['story_id'] = Variable<int>(storyId.value);
    }
    if (teachingId.present) {
      map['teaching_id'] = Variable<int>(teachingId.value);
    }
    if (sahabahStoryId.present) {
      map['sahabah_story_id'] = Variable<int>(sahabahStoryId.value);
    }
    if (historyId.present) {
      map['history_id'] = Variable<int>(historyId.value);
    }
    if (extraReadingSeconds.present) {
      map['extra_reading_seconds'] = Variable<int>(extraReadingSeconds.value);
    }
    if (wasCompleted.present) {
      map['was_completed'] = Variable<bool>(wasCompleted.value);
    }
    if (continuedReading.present) {
      map['continued_reading'] = Variable<bool>(continuedReading.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GateSessionsCompanion(')
          ..write('id: $id, ')
          ..write('blockedAppId: $blockedAppId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('actualDurationSeconds: $actualDurationSeconds, ')
          ..write('gateContentType: $gateContentType, ')
          ..write('quranSurah: $quranSurah, ')
          ..write('quranAyahStart: $quranAyahStart, ')
          ..write('quranAyahEnd: $quranAyahEnd, ')
          ..write('duaId: $duaId, ')
          ..write('storyId: $storyId, ')
          ..write('teachingId: $teachingId, ')
          ..write('sahabahStoryId: $sahabahStoryId, ')
          ..write('historyId: $historyId, ')
          ..write('extraReadingSeconds: $extraReadingSeconds, ')
          ..write('wasCompleted: $wasCompleted, ')
          ..write('continuedReading: $continuedReading')
          ..write(')'))
        .toString();
  }
}

class $UnlockSessionsTable extends UnlockSessions
    with TableInfo<$UnlockSessionsTable, UnlockSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnlockSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _gateSessionIdMeta = const VerificationMeta(
    'gateSessionId',
  );
  @override
  late final GeneratedColumn<int> gateSessionId = GeneratedColumn<int>(
    'gate_session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gate_sessions (id)',
    ),
  );
  static const VerificationMeta _blockedAppIdMeta = const VerificationMeta(
    'blockedAppId',
  );
  @override
  late final GeneratedColumn<int> blockedAppId = GeneratedColumn<int>(
    'blocked_app_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES blocked_apps (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<String> startedAt = GeneratedColumn<String>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<String> expiresAt = GeneratedColumn<String>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gateSessionId,
    blockedAppId,
    startedAt,
    expiresAt,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'unlock_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<UnlockSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gate_session_id')) {
      context.handle(
        _gateSessionIdMeta,
        gateSessionId.isAcceptableOrUnknown(
          data['gate_session_id']!,
          _gateSessionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gateSessionIdMeta);
    }
    if (data.containsKey('blocked_app_id')) {
      context.handle(
        _blockedAppIdMeta,
        blockedAppId.isAcceptableOrUnknown(
          data['blocked_app_id']!,
          _blockedAppIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_blockedAppIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UnlockSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnlockSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      gateSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gate_session_id'],
      )!,
      blockedAppId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}blocked_app_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}started_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expires_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $UnlockSessionsTable createAlias(String alias) {
    return $UnlockSessionsTable(attachedDatabase, alias);
  }
}

class UnlockSession extends DataClass implements Insertable<UnlockSession> {
  final int id;
  final int gateSessionId;
  final int blockedAppId;
  final String startedAt;
  final String expiresAt;
  final bool isActive;
  const UnlockSession({
    required this.id,
    required this.gateSessionId,
    required this.blockedAppId,
    required this.startedAt,
    required this.expiresAt,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gate_session_id'] = Variable<int>(gateSessionId);
    map['blocked_app_id'] = Variable<int>(blockedAppId);
    map['started_at'] = Variable<String>(startedAt);
    map['expires_at'] = Variable<String>(expiresAt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  UnlockSessionsCompanion toCompanion(bool nullToAbsent) {
    return UnlockSessionsCompanion(
      id: Value(id),
      gateSessionId: Value(gateSessionId),
      blockedAppId: Value(blockedAppId),
      startedAt: Value(startedAt),
      expiresAt: Value(expiresAt),
      isActive: Value(isActive),
    );
  }

  factory UnlockSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnlockSession(
      id: serializer.fromJson<int>(json['id']),
      gateSessionId: serializer.fromJson<int>(json['gateSessionId']),
      blockedAppId: serializer.fromJson<int>(json['blockedAppId']),
      startedAt: serializer.fromJson<String>(json['startedAt']),
      expiresAt: serializer.fromJson<String>(json['expiresAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gateSessionId': serializer.toJson<int>(gateSessionId),
      'blockedAppId': serializer.toJson<int>(blockedAppId),
      'startedAt': serializer.toJson<String>(startedAt),
      'expiresAt': serializer.toJson<String>(expiresAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  UnlockSession copyWith({
    int? id,
    int? gateSessionId,
    int? blockedAppId,
    String? startedAt,
    String? expiresAt,
    bool? isActive,
  }) => UnlockSession(
    id: id ?? this.id,
    gateSessionId: gateSessionId ?? this.gateSessionId,
    blockedAppId: blockedAppId ?? this.blockedAppId,
    startedAt: startedAt ?? this.startedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    isActive: isActive ?? this.isActive,
  );
  UnlockSession copyWithCompanion(UnlockSessionsCompanion data) {
    return UnlockSession(
      id: data.id.present ? data.id.value : this.id,
      gateSessionId: data.gateSessionId.present
          ? data.gateSessionId.value
          : this.gateSessionId,
      blockedAppId: data.blockedAppId.present
          ? data.blockedAppId.value
          : this.blockedAppId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnlockSession(')
          ..write('id: $id, ')
          ..write('gateSessionId: $gateSessionId, ')
          ..write('blockedAppId: $blockedAppId, ')
          ..write('startedAt: $startedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gateSessionId,
    blockedAppId,
    startedAt,
    expiresAt,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnlockSession &&
          other.id == this.id &&
          other.gateSessionId == this.gateSessionId &&
          other.blockedAppId == this.blockedAppId &&
          other.startedAt == this.startedAt &&
          other.expiresAt == this.expiresAt &&
          other.isActive == this.isActive);
}

class UnlockSessionsCompanion extends UpdateCompanion<UnlockSession> {
  final Value<int> id;
  final Value<int> gateSessionId;
  final Value<int> blockedAppId;
  final Value<String> startedAt;
  final Value<String> expiresAt;
  final Value<bool> isActive;
  const UnlockSessionsCompanion({
    this.id = const Value.absent(),
    this.gateSessionId = const Value.absent(),
    this.blockedAppId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  UnlockSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int gateSessionId,
    required int blockedAppId,
    required String startedAt,
    required String expiresAt,
    this.isActive = const Value.absent(),
  }) : gateSessionId = Value(gateSessionId),
       blockedAppId = Value(blockedAppId),
       startedAt = Value(startedAt),
       expiresAt = Value(expiresAt);
  static Insertable<UnlockSession> custom({
    Expression<int>? id,
    Expression<int>? gateSessionId,
    Expression<int>? blockedAppId,
    Expression<String>? startedAt,
    Expression<String>? expiresAt,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gateSessionId != null) 'gate_session_id': gateSessionId,
      if (blockedAppId != null) 'blocked_app_id': blockedAppId,
      if (startedAt != null) 'started_at': startedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (isActive != null) 'is_active': isActive,
    });
  }

  UnlockSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? gateSessionId,
    Value<int>? blockedAppId,
    Value<String>? startedAt,
    Value<String>? expiresAt,
    Value<bool>? isActive,
  }) {
    return UnlockSessionsCompanion(
      id: id ?? this.id,
      gateSessionId: gateSessionId ?? this.gateSessionId,
      blockedAppId: blockedAppId ?? this.blockedAppId,
      startedAt: startedAt ?? this.startedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gateSessionId.present) {
      map['gate_session_id'] = Variable<int>(gateSessionId.value);
    }
    if (blockedAppId.present) {
      map['blocked_app_id'] = Variable<int>(blockedAppId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<String>(startedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<String>(expiresAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnlockSessionsCompanion(')
          ..write('id: $id, ')
          ..write('gateSessionId: $gateSessionId, ')
          ..write('blockedAppId: $blockedAppId, ')
          ..write('startedAt: $startedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $ReadingProgressTable extends ReadingProgress
    with TableInfo<$ReadingProgressTable, ReadingProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<int> contentId = GeneratedColumn<int>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstReadAtMeta = const VerificationMeta(
    'firstReadAt',
  );
  @override
  late final GeneratedColumn<String> firstReadAt = GeneratedColumn<String>(
    'first_read_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastReadAtMeta = const VerificationMeta(
    'lastReadAt',
  );
  @override
  late final GeneratedColumn<String> lastReadAt = GeneratedColumn<String>(
    'last_read_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timesReadMeta = const VerificationMeta(
    'timesRead',
  );
  @override
  late final GeneratedColumn<int> timesRead = GeneratedColumn<int>(
    'times_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _totalReadingSecondsMeta =
      const VerificationMeta('totalReadingSeconds');
  @override
  late final GeneratedColumn<int> totalReadingSeconds = GeneratedColumn<int>(
    'total_reading_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isMemorizedMeta = const VerificationMeta(
    'isMemorized',
  );
  @override
  late final GeneratedColumn<bool> isMemorized = GeneratedColumn<bool>(
    'is_memorized',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_memorized" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contentType,
    contentId,
    firstReadAt,
    lastReadAt,
    timesRead,
    totalReadingSeconds,
    isFavorite,
    isMemorized,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('first_read_at')) {
      context.handle(
        _firstReadAtMeta,
        firstReadAt.isAcceptableOrUnknown(
          data['first_read_at']!,
          _firstReadAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstReadAtMeta);
    }
    if (data.containsKey('last_read_at')) {
      context.handle(
        _lastReadAtMeta,
        lastReadAt.isAcceptableOrUnknown(
          data['last_read_at']!,
          _lastReadAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastReadAtMeta);
    }
    if (data.containsKey('times_read')) {
      context.handle(
        _timesReadMeta,
        timesRead.isAcceptableOrUnknown(data['times_read']!, _timesReadMeta),
      );
    }
    if (data.containsKey('total_reading_seconds')) {
      context.handle(
        _totalReadingSecondsMeta,
        totalReadingSeconds.isAcceptableOrUnknown(
          data['total_reading_seconds']!,
          _totalReadingSecondsMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('is_memorized')) {
      context.handle(
        _isMemorizedMeta,
        isMemorized.isAcceptableOrUnknown(
          data['is_memorized']!,
          _isMemorizedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_id'],
      )!,
      firstReadAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_read_at'],
      )!,
      lastReadAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_read_at'],
      )!,
      timesRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}times_read'],
      )!,
      totalReadingSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_reading_seconds'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      isMemorized: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_memorized'],
      )!,
    );
  }

  @override
  $ReadingProgressTable createAlias(String alias) {
    return $ReadingProgressTable(attachedDatabase, alias);
  }
}

class ReadingProgressData extends DataClass
    implements Insertable<ReadingProgressData> {
  final int id;
  final String contentType;
  final int contentId;
  final String firstReadAt;
  final String lastReadAt;
  final int timesRead;
  final int totalReadingSeconds;
  final bool isFavorite;
  final bool isMemorized;
  const ReadingProgressData({
    required this.id,
    required this.contentType,
    required this.contentId,
    required this.firstReadAt,
    required this.lastReadAt,
    required this.timesRead,
    required this.totalReadingSeconds,
    required this.isFavorite,
    required this.isMemorized,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_type'] = Variable<String>(contentType);
    map['content_id'] = Variable<int>(contentId);
    map['first_read_at'] = Variable<String>(firstReadAt);
    map['last_read_at'] = Variable<String>(lastReadAt);
    map['times_read'] = Variable<int>(timesRead);
    map['total_reading_seconds'] = Variable<int>(totalReadingSeconds);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_memorized'] = Variable<bool>(isMemorized);
    return map;
  }

  ReadingProgressCompanion toCompanion(bool nullToAbsent) {
    return ReadingProgressCompanion(
      id: Value(id),
      contentType: Value(contentType),
      contentId: Value(contentId),
      firstReadAt: Value(firstReadAt),
      lastReadAt: Value(lastReadAt),
      timesRead: Value(timesRead),
      totalReadingSeconds: Value(totalReadingSeconds),
      isFavorite: Value(isFavorite),
      isMemorized: Value(isMemorized),
    );
  }

  factory ReadingProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingProgressData(
      id: serializer.fromJson<int>(json['id']),
      contentType: serializer.fromJson<String>(json['contentType']),
      contentId: serializer.fromJson<int>(json['contentId']),
      firstReadAt: serializer.fromJson<String>(json['firstReadAt']),
      lastReadAt: serializer.fromJson<String>(json['lastReadAt']),
      timesRead: serializer.fromJson<int>(json['timesRead']),
      totalReadingSeconds: serializer.fromJson<int>(
        json['totalReadingSeconds'],
      ),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isMemorized: serializer.fromJson<bool>(json['isMemorized']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentType': serializer.toJson<String>(contentType),
      'contentId': serializer.toJson<int>(contentId),
      'firstReadAt': serializer.toJson<String>(firstReadAt),
      'lastReadAt': serializer.toJson<String>(lastReadAt),
      'timesRead': serializer.toJson<int>(timesRead),
      'totalReadingSeconds': serializer.toJson<int>(totalReadingSeconds),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isMemorized': serializer.toJson<bool>(isMemorized),
    };
  }

  ReadingProgressData copyWith({
    int? id,
    String? contentType,
    int? contentId,
    String? firstReadAt,
    String? lastReadAt,
    int? timesRead,
    int? totalReadingSeconds,
    bool? isFavorite,
    bool? isMemorized,
  }) => ReadingProgressData(
    id: id ?? this.id,
    contentType: contentType ?? this.contentType,
    contentId: contentId ?? this.contentId,
    firstReadAt: firstReadAt ?? this.firstReadAt,
    lastReadAt: lastReadAt ?? this.lastReadAt,
    timesRead: timesRead ?? this.timesRead,
    totalReadingSeconds: totalReadingSeconds ?? this.totalReadingSeconds,
    isFavorite: isFavorite ?? this.isFavorite,
    isMemorized: isMemorized ?? this.isMemorized,
  );
  ReadingProgressData copyWithCompanion(ReadingProgressCompanion data) {
    return ReadingProgressData(
      id: data.id.present ? data.id.value : this.id,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      firstReadAt: data.firstReadAt.present
          ? data.firstReadAt.value
          : this.firstReadAt,
      lastReadAt: data.lastReadAt.present
          ? data.lastReadAt.value
          : this.lastReadAt,
      timesRead: data.timesRead.present ? data.timesRead.value : this.timesRead,
      totalReadingSeconds: data.totalReadingSeconds.present
          ? data.totalReadingSeconds.value
          : this.totalReadingSeconds,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      isMemorized: data.isMemorized.present
          ? data.isMemorized.value
          : this.isMemorized,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressData(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('firstReadAt: $firstReadAt, ')
          ..write('lastReadAt: $lastReadAt, ')
          ..write('timesRead: $timesRead, ')
          ..write('totalReadingSeconds: $totalReadingSeconds, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isMemorized: $isMemorized')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contentType,
    contentId,
    firstReadAt,
    lastReadAt,
    timesRead,
    totalReadingSeconds,
    isFavorite,
    isMemorized,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingProgressData &&
          other.id == this.id &&
          other.contentType == this.contentType &&
          other.contentId == this.contentId &&
          other.firstReadAt == this.firstReadAt &&
          other.lastReadAt == this.lastReadAt &&
          other.timesRead == this.timesRead &&
          other.totalReadingSeconds == this.totalReadingSeconds &&
          other.isFavorite == this.isFavorite &&
          other.isMemorized == this.isMemorized);
}

class ReadingProgressCompanion extends UpdateCompanion<ReadingProgressData> {
  final Value<int> id;
  final Value<String> contentType;
  final Value<int> contentId;
  final Value<String> firstReadAt;
  final Value<String> lastReadAt;
  final Value<int> timesRead;
  final Value<int> totalReadingSeconds;
  final Value<bool> isFavorite;
  final Value<bool> isMemorized;
  const ReadingProgressCompanion({
    this.id = const Value.absent(),
    this.contentType = const Value.absent(),
    this.contentId = const Value.absent(),
    this.firstReadAt = const Value.absent(),
    this.lastReadAt = const Value.absent(),
    this.timesRead = const Value.absent(),
    this.totalReadingSeconds = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isMemorized = const Value.absent(),
  });
  ReadingProgressCompanion.insert({
    this.id = const Value.absent(),
    required String contentType,
    required int contentId,
    required String firstReadAt,
    required String lastReadAt,
    this.timesRead = const Value.absent(),
    this.totalReadingSeconds = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isMemorized = const Value.absent(),
  }) : contentType = Value(contentType),
       contentId = Value(contentId),
       firstReadAt = Value(firstReadAt),
       lastReadAt = Value(lastReadAt);
  static Insertable<ReadingProgressData> custom({
    Expression<int>? id,
    Expression<String>? contentType,
    Expression<int>? contentId,
    Expression<String>? firstReadAt,
    Expression<String>? lastReadAt,
    Expression<int>? timesRead,
    Expression<int>? totalReadingSeconds,
    Expression<bool>? isFavorite,
    Expression<bool>? isMemorized,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentType != null) 'content_type': contentType,
      if (contentId != null) 'content_id': contentId,
      if (firstReadAt != null) 'first_read_at': firstReadAt,
      if (lastReadAt != null) 'last_read_at': lastReadAt,
      if (timesRead != null) 'times_read': timesRead,
      if (totalReadingSeconds != null)
        'total_reading_seconds': totalReadingSeconds,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isMemorized != null) 'is_memorized': isMemorized,
    });
  }

  ReadingProgressCompanion copyWith({
    Value<int>? id,
    Value<String>? contentType,
    Value<int>? contentId,
    Value<String>? firstReadAt,
    Value<String>? lastReadAt,
    Value<int>? timesRead,
    Value<int>? totalReadingSeconds,
    Value<bool>? isFavorite,
    Value<bool>? isMemorized,
  }) {
    return ReadingProgressCompanion(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      firstReadAt: firstReadAt ?? this.firstReadAt,
      lastReadAt: lastReadAt ?? this.lastReadAt,
      timesRead: timesRead ?? this.timesRead,
      totalReadingSeconds: totalReadingSeconds ?? this.totalReadingSeconds,
      isFavorite: isFavorite ?? this.isFavorite,
      isMemorized: isMemorized ?? this.isMemorized,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<int>(contentId.value);
    }
    if (firstReadAt.present) {
      map['first_read_at'] = Variable<String>(firstReadAt.value);
    }
    if (lastReadAt.present) {
      map['last_read_at'] = Variable<String>(lastReadAt.value);
    }
    if (timesRead.present) {
      map['times_read'] = Variable<int>(timesRead.value);
    }
    if (totalReadingSeconds.present) {
      map['total_reading_seconds'] = Variable<int>(totalReadingSeconds.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isMemorized.present) {
      map['is_memorized'] = Variable<bool>(isMemorized.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressCompanion(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('firstReadAt: $firstReadAt, ')
          ..write('lastReadAt: $lastReadAt, ')
          ..write('timesRead: $timesRead, ')
          ..write('totalReadingSeconds: $totalReadingSeconds, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isMemorized: $isMemorized')
          ..write(')'))
        .toString();
  }
}

class $SurahProgressTable extends SurahProgress
    with TableInfo<$SurahProgressTable, SurahProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurahProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ayahsReadMeta = const VerificationMeta(
    'ayahsRead',
  );
  @override
  late final GeneratedColumn<int> ayahsRead = GeneratedColumn<int>(
    'ayahs_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalAyahsMeta = const VerificationMeta(
    'totalAyahs',
  );
  @override
  late final GeneratedColumn<int> totalAyahs = GeneratedColumn<int>(
    'total_ayahs',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<String> completedAt = GeneratedColumn<String>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    surahNumber,
    ayahsRead,
    totalAyahs,
    isCompleted,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surah_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<SurahProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    }
    if (data.containsKey('ayahs_read')) {
      context.handle(
        _ayahsReadMeta,
        ayahsRead.isAcceptableOrUnknown(data['ayahs_read']!, _ayahsReadMeta),
      );
    }
    if (data.containsKey('total_ayahs')) {
      context.handle(
        _totalAyahsMeta,
        totalAyahs.isAcceptableOrUnknown(data['total_ayahs']!, _totalAyahsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalAyahsMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surahNumber};
  @override
  SurahProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurahProgressData(
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahsRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayahs_read'],
      )!,
      totalAyahs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_ayahs'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $SurahProgressTable createAlias(String alias) {
    return $SurahProgressTable(attachedDatabase, alias);
  }
}

class SurahProgressData extends DataClass
    implements Insertable<SurahProgressData> {
  final int surahNumber;
  final int ayahsRead;
  final int totalAyahs;
  final bool isCompleted;
  final String? completedAt;
  const SurahProgressData({
    required this.surahNumber,
    required this.ayahsRead,
    required this.totalAyahs,
    required this.isCompleted,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayahs_read'] = Variable<int>(ayahsRead);
    map['total_ayahs'] = Variable<int>(totalAyahs);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<String>(completedAt);
    }
    return map;
  }

  SurahProgressCompanion toCompanion(bool nullToAbsent) {
    return SurahProgressCompanion(
      surahNumber: Value(surahNumber),
      ayahsRead: Value(ayahsRead),
      totalAyahs: Value(totalAyahs),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory SurahProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurahProgressData(
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahsRead: serializer.fromJson<int>(json['ayahsRead']),
      totalAyahs: serializer.fromJson<int>(json['totalAyahs']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<String?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahsRead': serializer.toJson<int>(ayahsRead),
      'totalAyahs': serializer.toJson<int>(totalAyahs),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<String?>(completedAt),
    };
  }

  SurahProgressData copyWith({
    int? surahNumber,
    int? ayahsRead,
    int? totalAyahs,
    bool? isCompleted,
    Value<String?> completedAt = const Value.absent(),
  }) => SurahProgressData(
    surahNumber: surahNumber ?? this.surahNumber,
    ayahsRead: ayahsRead ?? this.ayahsRead,
    totalAyahs: totalAyahs ?? this.totalAyahs,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  SurahProgressData copyWithCompanion(SurahProgressCompanion data) {
    return SurahProgressData(
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahsRead: data.ayahsRead.present ? data.ayahsRead.value : this.ayahsRead,
      totalAyahs: data.totalAyahs.present
          ? data.totalAyahs.value
          : this.totalAyahs,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SurahProgressData(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahsRead: $ayahsRead, ')
          ..write('totalAyahs: $totalAyahs, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(surahNumber, ayahsRead, totalAyahs, isCompleted, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurahProgressData &&
          other.surahNumber == this.surahNumber &&
          other.ayahsRead == this.ayahsRead &&
          other.totalAyahs == this.totalAyahs &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt);
}

class SurahProgressCompanion extends UpdateCompanion<SurahProgressData> {
  final Value<int> surahNumber;
  final Value<int> ayahsRead;
  final Value<int> totalAyahs;
  final Value<bool> isCompleted;
  final Value<String?> completedAt;
  const SurahProgressCompanion({
    this.surahNumber = const Value.absent(),
    this.ayahsRead = const Value.absent(),
    this.totalAyahs = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  SurahProgressCompanion.insert({
    this.surahNumber = const Value.absent(),
    this.ayahsRead = const Value.absent(),
    required int totalAyahs,
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
  }) : totalAyahs = Value(totalAyahs);
  static Insertable<SurahProgressData> custom({
    Expression<int>? surahNumber,
    Expression<int>? ayahsRead,
    Expression<int>? totalAyahs,
    Expression<bool>? isCompleted,
    Expression<String>? completedAt,
  }) {
    return RawValuesInsertable({
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahsRead != null) 'ayahs_read': ayahsRead,
      if (totalAyahs != null) 'total_ayahs': totalAyahs,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  SurahProgressCompanion copyWith({
    Value<int>? surahNumber,
    Value<int>? ayahsRead,
    Value<int>? totalAyahs,
    Value<bool>? isCompleted,
    Value<String?>? completedAt,
  }) {
    return SurahProgressCompanion(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahsRead: ayahsRead ?? this.ayahsRead,
      totalAyahs: totalAyahs ?? this.totalAyahs,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahsRead.present) {
      map['ayahs_read'] = Variable<int>(ayahsRead.value);
    }
    if (totalAyahs.present) {
      map['total_ayahs'] = Variable<int>(totalAyahs.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<String>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurahProgressCompanion(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahsRead: $ayahsRead, ')
          ..write('totalAyahs: $totalAyahs, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $ReadAyahsTable extends ReadAyahs
    with TableInfo<$ReadAyahsTable, ReadAyah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadAyahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _globalAyahIdMeta = const VerificationMeta(
    'globalAyahId',
  );
  @override
  late final GeneratedColumn<int> globalAyahId = GeneratedColumn<int>(
    'global_ayah_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstReadAtMeta = const VerificationMeta(
    'firstReadAt',
  );
  @override
  late final GeneratedColumn<String> firstReadAt = GeneratedColumn<String>(
    'first_read_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    globalAyahId,
    surahNumber,
    ayahNumber,
    firstReadAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'read_ayahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadAyah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('global_ayah_id')) {
      context.handle(
        _globalAyahIdMeta,
        globalAyahId.isAcceptableOrUnknown(
          data['global_ayah_id']!,
          _globalAyahIdMeta,
        ),
      );
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('first_read_at')) {
      context.handle(
        _firstReadAtMeta,
        firstReadAt.isAcceptableOrUnknown(
          data['first_read_at']!,
          _firstReadAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstReadAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {globalAyahId};
  @override
  ReadAyah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadAyah(
      globalAyahId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}global_ayah_id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      firstReadAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_read_at'],
      )!,
    );
  }

  @override
  $ReadAyahsTable createAlias(String alias) {
    return $ReadAyahsTable(attachedDatabase, alias);
  }
}

class ReadAyah extends DataClass implements Insertable<ReadAyah> {
  final int globalAyahId;
  final int surahNumber;
  final int ayahNumber;
  final String firstReadAt;
  const ReadAyah({
    required this.globalAyahId,
    required this.surahNumber,
    required this.ayahNumber,
    required this.firstReadAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['global_ayah_id'] = Variable<int>(globalAyahId);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['first_read_at'] = Variable<String>(firstReadAt);
    return map;
  }

  ReadAyahsCompanion toCompanion(bool nullToAbsent) {
    return ReadAyahsCompanion(
      globalAyahId: Value(globalAyahId),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      firstReadAt: Value(firstReadAt),
    );
  }

  factory ReadAyah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadAyah(
      globalAyahId: serializer.fromJson<int>(json['globalAyahId']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      firstReadAt: serializer.fromJson<String>(json['firstReadAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'globalAyahId': serializer.toJson<int>(globalAyahId),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'firstReadAt': serializer.toJson<String>(firstReadAt),
    };
  }

  ReadAyah copyWith({
    int? globalAyahId,
    int? surahNumber,
    int? ayahNumber,
    String? firstReadAt,
  }) => ReadAyah(
    globalAyahId: globalAyahId ?? this.globalAyahId,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    firstReadAt: firstReadAt ?? this.firstReadAt,
  );
  ReadAyah copyWithCompanion(ReadAyahsCompanion data) {
    return ReadAyah(
      globalAyahId: data.globalAyahId.present
          ? data.globalAyahId.value
          : this.globalAyahId,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      firstReadAt: data.firstReadAt.present
          ? data.firstReadAt.value
          : this.firstReadAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadAyah(')
          ..write('globalAyahId: $globalAyahId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('firstReadAt: $firstReadAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(globalAyahId, surahNumber, ayahNumber, firstReadAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadAyah &&
          other.globalAyahId == this.globalAyahId &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.firstReadAt == this.firstReadAt);
}

class ReadAyahsCompanion extends UpdateCompanion<ReadAyah> {
  final Value<int> globalAyahId;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<String> firstReadAt;
  const ReadAyahsCompanion({
    this.globalAyahId = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.firstReadAt = const Value.absent(),
  });
  ReadAyahsCompanion.insert({
    this.globalAyahId = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    required String firstReadAt,
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       firstReadAt = Value(firstReadAt);
  static Insertable<ReadAyah> custom({
    Expression<int>? globalAyahId,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<String>? firstReadAt,
  }) {
    return RawValuesInsertable({
      if (globalAyahId != null) 'global_ayah_id': globalAyahId,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (firstReadAt != null) 'first_read_at': firstReadAt,
    });
  }

  ReadAyahsCompanion copyWith({
    Value<int>? globalAyahId,
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<String>? firstReadAt,
  }) {
    return ReadAyahsCompanion(
      globalAyahId: globalAyahId ?? this.globalAyahId,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      firstReadAt: firstReadAt ?? this.firstReadAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (globalAyahId.present) {
      map['global_ayah_id'] = Variable<int>(globalAyahId.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (firstReadAt.present) {
      map['first_read_at'] = Variable<String>(firstReadAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadAyahsCompanion(')
          ..write('globalAyahId: $globalAyahId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('firstReadAt: $firstReadAt')
          ..write(')'))
        .toString();
  }
}

class $ReadingEventsTable extends ReadingEvents
    with TableInfo<$ReadingEventsTable, ReadingEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ayahStartMeta = const VerificationMeta(
    'ayahStart',
  );
  @override
  late final GeneratedColumn<int> ayahStart = GeneratedColumn<int>(
    'ayah_start',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ayahEndMeta = const VerificationMeta(
    'ayahEnd',
  );
  @override
  late final GeneratedColumn<int> ayahEnd = GeneratedColumn<int>(
    'ayah_end',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _duaIdMeta = const VerificationMeta('duaId');
  @override
  late final GeneratedColumn<int> duaId = GeneratedColumn<int>(
    'dua_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _readAtMeta = const VerificationMeta('readAt');
  @override
  late final GeneratedColumn<String> readAt = GeneratedColumn<String>(
    'read_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondsMeta = const VerificationMeta(
    'seconds',
  );
  @override
  late final GeneratedColumn<int> seconds = GeneratedColumn<int>(
    'seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contentType,
    surahNumber,
    ayahStart,
    ayahEnd,
    duaId,
    readAt,
    seconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    }
    if (data.containsKey('ayah_start')) {
      context.handle(
        _ayahStartMeta,
        ayahStart.isAcceptableOrUnknown(data['ayah_start']!, _ayahStartMeta),
      );
    }
    if (data.containsKey('ayah_end')) {
      context.handle(
        _ayahEndMeta,
        ayahEnd.isAcceptableOrUnknown(data['ayah_end']!, _ayahEndMeta),
      );
    }
    if (data.containsKey('dua_id')) {
      context.handle(
        _duaIdMeta,
        duaId.isAcceptableOrUnknown(data['dua_id']!, _duaIdMeta),
      );
    }
    if (data.containsKey('read_at')) {
      context.handle(
        _readAtMeta,
        readAt.isAcceptableOrUnknown(data['read_at']!, _readAtMeta),
      );
    } else if (isInserting) {
      context.missing(_readAtMeta);
    }
    if (data.containsKey('seconds')) {
      context.handle(
        _secondsMeta,
        seconds.isAcceptableOrUnknown(data['seconds']!, _secondsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      ),
      ayahStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_start'],
      ),
      ayahEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_end'],
      ),
      duaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dua_id'],
      ),
      readAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}read_at'],
      )!,
      seconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seconds'],
      )!,
    );
  }

  @override
  $ReadingEventsTable createAlias(String alias) {
    return $ReadingEventsTable(attachedDatabase, alias);
  }
}

class ReadingEvent extends DataClass implements Insertable<ReadingEvent> {
  final int id;
  final String contentType;
  final int? surahNumber;
  final int? ayahStart;
  final int? ayahEnd;
  final int? duaId;
  final String readAt;
  final int seconds;
  const ReadingEvent({
    required this.id,
    required this.contentType,
    this.surahNumber,
    this.ayahStart,
    this.ayahEnd,
    this.duaId,
    required this.readAt,
    required this.seconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_type'] = Variable<String>(contentType);
    if (!nullToAbsent || surahNumber != null) {
      map['surah_number'] = Variable<int>(surahNumber);
    }
    if (!nullToAbsent || ayahStart != null) {
      map['ayah_start'] = Variable<int>(ayahStart);
    }
    if (!nullToAbsent || ayahEnd != null) {
      map['ayah_end'] = Variable<int>(ayahEnd);
    }
    if (!nullToAbsent || duaId != null) {
      map['dua_id'] = Variable<int>(duaId);
    }
    map['read_at'] = Variable<String>(readAt);
    map['seconds'] = Variable<int>(seconds);
    return map;
  }

  ReadingEventsCompanion toCompanion(bool nullToAbsent) {
    return ReadingEventsCompanion(
      id: Value(id),
      contentType: Value(contentType),
      surahNumber: surahNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(surahNumber),
      ayahStart: ayahStart == null && nullToAbsent
          ? const Value.absent()
          : Value(ayahStart),
      ayahEnd: ayahEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(ayahEnd),
      duaId: duaId == null && nullToAbsent
          ? const Value.absent()
          : Value(duaId),
      readAt: Value(readAt),
      seconds: Value(seconds),
    );
  }

  factory ReadingEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingEvent(
      id: serializer.fromJson<int>(json['id']),
      contentType: serializer.fromJson<String>(json['contentType']),
      surahNumber: serializer.fromJson<int?>(json['surahNumber']),
      ayahStart: serializer.fromJson<int?>(json['ayahStart']),
      ayahEnd: serializer.fromJson<int?>(json['ayahEnd']),
      duaId: serializer.fromJson<int?>(json['duaId']),
      readAt: serializer.fromJson<String>(json['readAt']),
      seconds: serializer.fromJson<int>(json['seconds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentType': serializer.toJson<String>(contentType),
      'surahNumber': serializer.toJson<int?>(surahNumber),
      'ayahStart': serializer.toJson<int?>(ayahStart),
      'ayahEnd': serializer.toJson<int?>(ayahEnd),
      'duaId': serializer.toJson<int?>(duaId),
      'readAt': serializer.toJson<String>(readAt),
      'seconds': serializer.toJson<int>(seconds),
    };
  }

  ReadingEvent copyWith({
    int? id,
    String? contentType,
    Value<int?> surahNumber = const Value.absent(),
    Value<int?> ayahStart = const Value.absent(),
    Value<int?> ayahEnd = const Value.absent(),
    Value<int?> duaId = const Value.absent(),
    String? readAt,
    int? seconds,
  }) => ReadingEvent(
    id: id ?? this.id,
    contentType: contentType ?? this.contentType,
    surahNumber: surahNumber.present ? surahNumber.value : this.surahNumber,
    ayahStart: ayahStart.present ? ayahStart.value : this.ayahStart,
    ayahEnd: ayahEnd.present ? ayahEnd.value : this.ayahEnd,
    duaId: duaId.present ? duaId.value : this.duaId,
    readAt: readAt ?? this.readAt,
    seconds: seconds ?? this.seconds,
  );
  ReadingEvent copyWithCompanion(ReadingEventsCompanion data) {
    return ReadingEvent(
      id: data.id.present ? data.id.value : this.id,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahStart: data.ayahStart.present ? data.ayahStart.value : this.ayahStart,
      ayahEnd: data.ayahEnd.present ? data.ayahEnd.value : this.ayahEnd,
      duaId: data.duaId.present ? data.duaId.value : this.duaId,
      readAt: data.readAt.present ? data.readAt.value : this.readAt,
      seconds: data.seconds.present ? data.seconds.value : this.seconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingEvent(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahStart: $ayahStart, ')
          ..write('ayahEnd: $ayahEnd, ')
          ..write('duaId: $duaId, ')
          ..write('readAt: $readAt, ')
          ..write('seconds: $seconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contentType,
    surahNumber,
    ayahStart,
    ayahEnd,
    duaId,
    readAt,
    seconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingEvent &&
          other.id == this.id &&
          other.contentType == this.contentType &&
          other.surahNumber == this.surahNumber &&
          other.ayahStart == this.ayahStart &&
          other.ayahEnd == this.ayahEnd &&
          other.duaId == this.duaId &&
          other.readAt == this.readAt &&
          other.seconds == this.seconds);
}

class ReadingEventsCompanion extends UpdateCompanion<ReadingEvent> {
  final Value<int> id;
  final Value<String> contentType;
  final Value<int?> surahNumber;
  final Value<int?> ayahStart;
  final Value<int?> ayahEnd;
  final Value<int?> duaId;
  final Value<String> readAt;
  final Value<int> seconds;
  const ReadingEventsCompanion({
    this.id = const Value.absent(),
    this.contentType = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahStart = const Value.absent(),
    this.ayahEnd = const Value.absent(),
    this.duaId = const Value.absent(),
    this.readAt = const Value.absent(),
    this.seconds = const Value.absent(),
  });
  ReadingEventsCompanion.insert({
    this.id = const Value.absent(),
    required String contentType,
    this.surahNumber = const Value.absent(),
    this.ayahStart = const Value.absent(),
    this.ayahEnd = const Value.absent(),
    this.duaId = const Value.absent(),
    required String readAt,
    this.seconds = const Value.absent(),
  }) : contentType = Value(contentType),
       readAt = Value(readAt);
  static Insertable<ReadingEvent> custom({
    Expression<int>? id,
    Expression<String>? contentType,
    Expression<int>? surahNumber,
    Expression<int>? ayahStart,
    Expression<int>? ayahEnd,
    Expression<int>? duaId,
    Expression<String>? readAt,
    Expression<int>? seconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentType != null) 'content_type': contentType,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahStart != null) 'ayah_start': ayahStart,
      if (ayahEnd != null) 'ayah_end': ayahEnd,
      if (duaId != null) 'dua_id': duaId,
      if (readAt != null) 'read_at': readAt,
      if (seconds != null) 'seconds': seconds,
    });
  }

  ReadingEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? contentType,
    Value<int?>? surahNumber,
    Value<int?>? ayahStart,
    Value<int?>? ayahEnd,
    Value<int?>? duaId,
    Value<String>? readAt,
    Value<int>? seconds,
  }) {
    return ReadingEventsCompanion(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahStart: ayahStart ?? this.ayahStart,
      ayahEnd: ayahEnd ?? this.ayahEnd,
      duaId: duaId ?? this.duaId,
      readAt: readAt ?? this.readAt,
      seconds: seconds ?? this.seconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahStart.present) {
      map['ayah_start'] = Variable<int>(ayahStart.value);
    }
    if (ayahEnd.present) {
      map['ayah_end'] = Variable<int>(ayahEnd.value);
    }
    if (duaId.present) {
      map['dua_id'] = Variable<int>(duaId.value);
    }
    if (readAt.present) {
      map['read_at'] = Variable<String>(readAt.value);
    }
    if (seconds.present) {
      map['seconds'] = Variable<int>(seconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingEventsCompanion(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahStart: $ayahStart, ')
          ..write('ayahEnd: $ayahEnd, ')
          ..write('duaId: $duaId, ')
          ..write('readAt: $readAt, ')
          ..write('seconds: $seconds')
          ..write(')'))
        .toString();
  }
}

class $PrayerLogsTable extends PrayerLogs
    with TableInfo<$PrayerLogsTable, PrayerLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prayerMeta = const VerificationMeta('prayer');
  @override
  late final GeneratedColumn<String> prayer = GeneratedColumn<String>(
    'prayer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prayedAtMeta = const VerificationMeta(
    'prayedAt',
  );
  @override
  late final GeneratedColumn<String> prayedAt = GeneratedColumn<String>(
    'prayed_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, prayer, prayedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayer_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrayerLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('prayer')) {
      context.handle(
        _prayerMeta,
        prayer.isAcceptableOrUnknown(data['prayer']!, _prayerMeta),
      );
    } else if (isInserting) {
      context.missing(_prayerMeta);
    }
    if (data.containsKey('prayed_at')) {
      context.handle(
        _prayedAtMeta,
        prayedAt.isAcceptableOrUnknown(data['prayed_at']!, _prayedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_prayedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {date, prayer},
  ];
  @override
  PrayerLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      prayer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prayer'],
      )!,
      prayedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prayed_at'],
      )!,
    );
  }

  @override
  $PrayerLogsTable createAlias(String alias) {
    return $PrayerLogsTable(attachedDatabase, alias);
  }
}

class PrayerLog extends DataClass implements Insertable<PrayerLog> {
  final int id;
  final String date;
  final String prayer;
  final String prayedAt;
  const PrayerLog({
    required this.id,
    required this.date,
    required this.prayer,
    required this.prayedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['prayer'] = Variable<String>(prayer);
    map['prayed_at'] = Variable<String>(prayedAt);
    return map;
  }

  PrayerLogsCompanion toCompanion(bool nullToAbsent) {
    return PrayerLogsCompanion(
      id: Value(id),
      date: Value(date),
      prayer: Value(prayer),
      prayedAt: Value(prayedAt),
    );
  }

  factory PrayerLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      prayer: serializer.fromJson<String>(json['prayer']),
      prayedAt: serializer.fromJson<String>(json['prayedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'prayer': serializer.toJson<String>(prayer),
      'prayedAt': serializer.toJson<String>(prayedAt),
    };
  }

  PrayerLog copyWith({
    int? id,
    String? date,
    String? prayer,
    String? prayedAt,
  }) => PrayerLog(
    id: id ?? this.id,
    date: date ?? this.date,
    prayer: prayer ?? this.prayer,
    prayedAt: prayedAt ?? this.prayedAt,
  );
  PrayerLog copyWithCompanion(PrayerLogsCompanion data) {
    return PrayerLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      prayer: data.prayer.present ? data.prayer.value : this.prayer,
      prayedAt: data.prayedAt.present ? data.prayedAt.value : this.prayedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('prayer: $prayer, ')
          ..write('prayedAt: $prayedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, prayer, prayedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.prayer == this.prayer &&
          other.prayedAt == this.prayedAt);
}

class PrayerLogsCompanion extends UpdateCompanion<PrayerLog> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> prayer;
  final Value<String> prayedAt;
  const PrayerLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.prayer = const Value.absent(),
    this.prayedAt = const Value.absent(),
  });
  PrayerLogsCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String prayer,
    required String prayedAt,
  }) : date = Value(date),
       prayer = Value(prayer),
       prayedAt = Value(prayedAt);
  static Insertable<PrayerLog> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? prayer,
    Expression<String>? prayedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (prayer != null) 'prayer': prayer,
      if (prayedAt != null) 'prayed_at': prayedAt,
    });
  }

  PrayerLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? date,
    Value<String>? prayer,
    Value<String>? prayedAt,
  }) {
    return PrayerLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      prayer: prayer ?? this.prayer,
      prayedAt: prayedAt ?? this.prayedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (prayer.present) {
      map['prayer'] = Variable<String>(prayer.value);
    }
    if (prayedAt.present) {
      map['prayed_at'] = Variable<String>(prayedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayerLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('prayer: $prayer, ')
          ..write('prayedAt: $prayedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $BlockedAppsTable blockedApps = $BlockedAppsTable(this);
  late final $GateSessionsTable gateSessions = $GateSessionsTable(this);
  late final $UnlockSessionsTable unlockSessions = $UnlockSessionsTable(this);
  late final $ReadingProgressTable readingProgress = $ReadingProgressTable(
    this,
  );
  late final $SurahProgressTable surahProgress = $SurahProgressTable(this);
  late final $ReadAyahsTable readAyahs = $ReadAyahsTable(this);
  late final $ReadingEventsTable readingEvents = $ReadingEventsTable(this);
  late final $PrayerLogsTable prayerLogs = $PrayerLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userPreferences,
    blockedApps,
    gateSessions,
    unlockSessions,
    readingProgress,
    surahProgress,
    readAyahs,
    readingEvents,
    prayerLogs,
  ];
}

typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<int> id,
      Value<int> gateDurationSeconds,
      Value<int> unlockDurationSeconds,
      Value<String> gateContentCategories,
      Value<String> quranMode,
      Value<bool> showTranslation,
      Value<double> quranFontSize,
      Value<String> translationLanguage,
      Value<String> themeMode,
      Value<int?> pauseUntilTimestamp,
      Value<int> sequentialPositionSurah,
      Value<int> sequentialPositionAyah,
      Value<bool> onboardingCompleted,
      Value<int> streakCurrent,
      Value<String?> streakLastDate,
      Value<bool> notifyPrayerTimes,
      Value<int> notifyPrayerAdvanceMinutes,
      Value<bool> notifyFridayKahf,
      Value<bool> notifyFastingDays,
      Value<bool> notifyMorningAdhkar,
      Value<bool> notifyEveningAdhkar,
      Value<bool> notifyBedtimeDua,
      Value<bool> notifySurahMulk,
      Value<bool> notifyDuhaReminder,
      Value<bool> notifyTahajjud,
      Value<bool> notifyDhikrAfterPrayer,
      Value<bool> notifyDuaForParents,
      Value<bool> notifyFridaySalawat,
      Value<bool> notifyFridayDuaHour,
      Value<bool> notifyDidYouKnow,
      Value<int> bedtimeHour,
      Value<int> bedtimeMinute,
      Value<String> prayerCalculationMethod,
      Value<String> madhab,
      Value<String> localeCode,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<int> id,
      Value<int> gateDurationSeconds,
      Value<int> unlockDurationSeconds,
      Value<String> gateContentCategories,
      Value<String> quranMode,
      Value<bool> showTranslation,
      Value<double> quranFontSize,
      Value<String> translationLanguage,
      Value<String> themeMode,
      Value<int?> pauseUntilTimestamp,
      Value<int> sequentialPositionSurah,
      Value<int> sequentialPositionAyah,
      Value<bool> onboardingCompleted,
      Value<int> streakCurrent,
      Value<String?> streakLastDate,
      Value<bool> notifyPrayerTimes,
      Value<int> notifyPrayerAdvanceMinutes,
      Value<bool> notifyFridayKahf,
      Value<bool> notifyFastingDays,
      Value<bool> notifyMorningAdhkar,
      Value<bool> notifyEveningAdhkar,
      Value<bool> notifyBedtimeDua,
      Value<bool> notifySurahMulk,
      Value<bool> notifyDuhaReminder,
      Value<bool> notifyTahajjud,
      Value<bool> notifyDhikrAfterPrayer,
      Value<bool> notifyDuaForParents,
      Value<bool> notifyFridaySalawat,
      Value<bool> notifyFridayDuaHour,
      Value<bool> notifyDidYouKnow,
      Value<int> bedtimeHour,
      Value<int> bedtimeMinute,
      Value<String> prayerCalculationMethod,
      Value<String> madhab,
      Value<String> localeCode,
    });

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gateDurationSeconds => $composableBuilder(
    column: $table.gateDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unlockDurationSeconds => $composableBuilder(
    column: $table.unlockDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gateContentCategories => $composableBuilder(
    column: $table.gateContentCategories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quranMode => $composableBuilder(
    column: $table.quranMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showTranslation => $composableBuilder(
    column: $table.showTranslation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quranFontSize => $composableBuilder(
    column: $table.quranFontSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationLanguage => $composableBuilder(
    column: $table.translationLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pauseUntilTimestamp => $composableBuilder(
    column: $table.pauseUntilTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequentialPositionSurah => $composableBuilder(
    column: $table.sequentialPositionSurah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequentialPositionAyah => $composableBuilder(
    column: $table.sequentialPositionAyah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakCurrent => $composableBuilder(
    column: $table.streakCurrent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get streakLastDate => $composableBuilder(
    column: $table.streakLastDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyPrayerTimes => $composableBuilder(
    column: $table.notifyPrayerTimes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notifyPrayerAdvanceMinutes => $composableBuilder(
    column: $table.notifyPrayerAdvanceMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyFridayKahf => $composableBuilder(
    column: $table.notifyFridayKahf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyFastingDays => $composableBuilder(
    column: $table.notifyFastingDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyMorningAdhkar => $composableBuilder(
    column: $table.notifyMorningAdhkar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyEveningAdhkar => $composableBuilder(
    column: $table.notifyEveningAdhkar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyBedtimeDua => $composableBuilder(
    column: $table.notifyBedtimeDua,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifySurahMulk => $composableBuilder(
    column: $table.notifySurahMulk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyDuhaReminder => $composableBuilder(
    column: $table.notifyDuhaReminder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyTahajjud => $composableBuilder(
    column: $table.notifyTahajjud,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyDhikrAfterPrayer => $composableBuilder(
    column: $table.notifyDhikrAfterPrayer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyDuaForParents => $composableBuilder(
    column: $table.notifyDuaForParents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyFridaySalawat => $composableBuilder(
    column: $table.notifyFridaySalawat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyFridayDuaHour => $composableBuilder(
    column: $table.notifyFridayDuaHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyDidYouKnow => $composableBuilder(
    column: $table.notifyDidYouKnow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bedtimeHour => $composableBuilder(
    column: $table.bedtimeHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bedtimeMinute => $composableBuilder(
    column: $table.bedtimeMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prayerCalculationMethod => $composableBuilder(
    column: $table.prayerCalculationMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get madhab => $composableBuilder(
    column: $table.madhab,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gateDurationSeconds => $composableBuilder(
    column: $table.gateDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unlockDurationSeconds => $composableBuilder(
    column: $table.unlockDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gateContentCategories => $composableBuilder(
    column: $table.gateContentCategories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quranMode => $composableBuilder(
    column: $table.quranMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showTranslation => $composableBuilder(
    column: $table.showTranslation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quranFontSize => $composableBuilder(
    column: $table.quranFontSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationLanguage => $composableBuilder(
    column: $table.translationLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pauseUntilTimestamp => $composableBuilder(
    column: $table.pauseUntilTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequentialPositionSurah => $composableBuilder(
    column: $table.sequentialPositionSurah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequentialPositionAyah => $composableBuilder(
    column: $table.sequentialPositionAyah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakCurrent => $composableBuilder(
    column: $table.streakCurrent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get streakLastDate => $composableBuilder(
    column: $table.streakLastDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyPrayerTimes => $composableBuilder(
    column: $table.notifyPrayerTimes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notifyPrayerAdvanceMinutes => $composableBuilder(
    column: $table.notifyPrayerAdvanceMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyFridayKahf => $composableBuilder(
    column: $table.notifyFridayKahf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyFastingDays => $composableBuilder(
    column: $table.notifyFastingDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyMorningAdhkar => $composableBuilder(
    column: $table.notifyMorningAdhkar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyEveningAdhkar => $composableBuilder(
    column: $table.notifyEveningAdhkar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyBedtimeDua => $composableBuilder(
    column: $table.notifyBedtimeDua,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifySurahMulk => $composableBuilder(
    column: $table.notifySurahMulk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyDuhaReminder => $composableBuilder(
    column: $table.notifyDuhaReminder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyTahajjud => $composableBuilder(
    column: $table.notifyTahajjud,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyDhikrAfterPrayer => $composableBuilder(
    column: $table.notifyDhikrAfterPrayer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyDuaForParents => $composableBuilder(
    column: $table.notifyDuaForParents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyFridaySalawat => $composableBuilder(
    column: $table.notifyFridaySalawat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyFridayDuaHour => $composableBuilder(
    column: $table.notifyFridayDuaHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyDidYouKnow => $composableBuilder(
    column: $table.notifyDidYouKnow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bedtimeHour => $composableBuilder(
    column: $table.bedtimeHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bedtimeMinute => $composableBuilder(
    column: $table.bedtimeMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prayerCalculationMethod => $composableBuilder(
    column: $table.prayerCalculationMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get madhab => $composableBuilder(
    column: $table.madhab,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get gateDurationSeconds => $composableBuilder(
    column: $table.gateDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unlockDurationSeconds => $composableBuilder(
    column: $table.unlockDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gateContentCategories => $composableBuilder(
    column: $table.gateContentCategories,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quranMode =>
      $composableBuilder(column: $table.quranMode, builder: (column) => column);

  GeneratedColumn<bool> get showTranslation => $composableBuilder(
    column: $table.showTranslation,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quranFontSize => $composableBuilder(
    column: $table.quranFontSize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translationLanguage => $composableBuilder(
    column: $table.translationLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<int> get pauseUntilTimestamp => $composableBuilder(
    column: $table.pauseUntilTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sequentialPositionSurah => $composableBuilder(
    column: $table.sequentialPositionSurah,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sequentialPositionAyah => $composableBuilder(
    column: $table.sequentialPositionAyah,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get streakCurrent => $composableBuilder(
    column: $table.streakCurrent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get streakLastDate => $composableBuilder(
    column: $table.streakLastDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyPrayerTimes => $composableBuilder(
    column: $table.notifyPrayerTimes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notifyPrayerAdvanceMinutes => $composableBuilder(
    column: $table.notifyPrayerAdvanceMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyFridayKahf => $composableBuilder(
    column: $table.notifyFridayKahf,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyFastingDays => $composableBuilder(
    column: $table.notifyFastingDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyMorningAdhkar => $composableBuilder(
    column: $table.notifyMorningAdhkar,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyEveningAdhkar => $composableBuilder(
    column: $table.notifyEveningAdhkar,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyBedtimeDua => $composableBuilder(
    column: $table.notifyBedtimeDua,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifySurahMulk => $composableBuilder(
    column: $table.notifySurahMulk,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyDuhaReminder => $composableBuilder(
    column: $table.notifyDuhaReminder,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyTahajjud => $composableBuilder(
    column: $table.notifyTahajjud,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyDhikrAfterPrayer => $composableBuilder(
    column: $table.notifyDhikrAfterPrayer,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyDuaForParents => $composableBuilder(
    column: $table.notifyDuaForParents,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyFridaySalawat => $composableBuilder(
    column: $table.notifyFridaySalawat,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyFridayDuaHour => $composableBuilder(
    column: $table.notifyFridayDuaHour,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyDidYouKnow => $composableBuilder(
    column: $table.notifyDidYouKnow,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bedtimeHour => $composableBuilder(
    column: $table.bedtimeHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bedtimeMinute => $composableBuilder(
    column: $table.bedtimeMinute,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prayerCalculationMethod => $composableBuilder(
    column: $table.prayerCalculationMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get madhab =>
      $composableBuilder(column: $table.madhab, builder: (column) => column);

  GeneratedColumn<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => column,
  );
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreference,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (
            UserPreference,
            BaseReferences<
              _$AppDatabase,
              $UserPreferencesTable,
              UserPreference
            >,
          ),
          UserPreference,
          PrefetchHooks Function()
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> gateDurationSeconds = const Value.absent(),
                Value<int> unlockDurationSeconds = const Value.absent(),
                Value<String> gateContentCategories = const Value.absent(),
                Value<String> quranMode = const Value.absent(),
                Value<bool> showTranslation = const Value.absent(),
                Value<double> quranFontSize = const Value.absent(),
                Value<String> translationLanguage = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int?> pauseUntilTimestamp = const Value.absent(),
                Value<int> sequentialPositionSurah = const Value.absent(),
                Value<int> sequentialPositionAyah = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<int> streakCurrent = const Value.absent(),
                Value<String?> streakLastDate = const Value.absent(),
                Value<bool> notifyPrayerTimes = const Value.absent(),
                Value<int> notifyPrayerAdvanceMinutes = const Value.absent(),
                Value<bool> notifyFridayKahf = const Value.absent(),
                Value<bool> notifyFastingDays = const Value.absent(),
                Value<bool> notifyMorningAdhkar = const Value.absent(),
                Value<bool> notifyEveningAdhkar = const Value.absent(),
                Value<bool> notifyBedtimeDua = const Value.absent(),
                Value<bool> notifySurahMulk = const Value.absent(),
                Value<bool> notifyDuhaReminder = const Value.absent(),
                Value<bool> notifyTahajjud = const Value.absent(),
                Value<bool> notifyDhikrAfterPrayer = const Value.absent(),
                Value<bool> notifyDuaForParents = const Value.absent(),
                Value<bool> notifyFridaySalawat = const Value.absent(),
                Value<bool> notifyFridayDuaHour = const Value.absent(),
                Value<bool> notifyDidYouKnow = const Value.absent(),
                Value<int> bedtimeHour = const Value.absent(),
                Value<int> bedtimeMinute = const Value.absent(),
                Value<String> prayerCalculationMethod = const Value.absent(),
                Value<String> madhab = const Value.absent(),
                Value<String> localeCode = const Value.absent(),
              }) => UserPreferencesCompanion(
                id: id,
                gateDurationSeconds: gateDurationSeconds,
                unlockDurationSeconds: unlockDurationSeconds,
                gateContentCategories: gateContentCategories,
                quranMode: quranMode,
                showTranslation: showTranslation,
                quranFontSize: quranFontSize,
                translationLanguage: translationLanguage,
                themeMode: themeMode,
                pauseUntilTimestamp: pauseUntilTimestamp,
                sequentialPositionSurah: sequentialPositionSurah,
                sequentialPositionAyah: sequentialPositionAyah,
                onboardingCompleted: onboardingCompleted,
                streakCurrent: streakCurrent,
                streakLastDate: streakLastDate,
                notifyPrayerTimes: notifyPrayerTimes,
                notifyPrayerAdvanceMinutes: notifyPrayerAdvanceMinutes,
                notifyFridayKahf: notifyFridayKahf,
                notifyFastingDays: notifyFastingDays,
                notifyMorningAdhkar: notifyMorningAdhkar,
                notifyEveningAdhkar: notifyEveningAdhkar,
                notifyBedtimeDua: notifyBedtimeDua,
                notifySurahMulk: notifySurahMulk,
                notifyDuhaReminder: notifyDuhaReminder,
                notifyTahajjud: notifyTahajjud,
                notifyDhikrAfterPrayer: notifyDhikrAfterPrayer,
                notifyDuaForParents: notifyDuaForParents,
                notifyFridaySalawat: notifyFridaySalawat,
                notifyFridayDuaHour: notifyFridayDuaHour,
                notifyDidYouKnow: notifyDidYouKnow,
                bedtimeHour: bedtimeHour,
                bedtimeMinute: bedtimeMinute,
                prayerCalculationMethod: prayerCalculationMethod,
                madhab: madhab,
                localeCode: localeCode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> gateDurationSeconds = const Value.absent(),
                Value<int> unlockDurationSeconds = const Value.absent(),
                Value<String> gateContentCategories = const Value.absent(),
                Value<String> quranMode = const Value.absent(),
                Value<bool> showTranslation = const Value.absent(),
                Value<double> quranFontSize = const Value.absent(),
                Value<String> translationLanguage = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int?> pauseUntilTimestamp = const Value.absent(),
                Value<int> sequentialPositionSurah = const Value.absent(),
                Value<int> sequentialPositionAyah = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<int> streakCurrent = const Value.absent(),
                Value<String?> streakLastDate = const Value.absent(),
                Value<bool> notifyPrayerTimes = const Value.absent(),
                Value<int> notifyPrayerAdvanceMinutes = const Value.absent(),
                Value<bool> notifyFridayKahf = const Value.absent(),
                Value<bool> notifyFastingDays = const Value.absent(),
                Value<bool> notifyMorningAdhkar = const Value.absent(),
                Value<bool> notifyEveningAdhkar = const Value.absent(),
                Value<bool> notifyBedtimeDua = const Value.absent(),
                Value<bool> notifySurahMulk = const Value.absent(),
                Value<bool> notifyDuhaReminder = const Value.absent(),
                Value<bool> notifyTahajjud = const Value.absent(),
                Value<bool> notifyDhikrAfterPrayer = const Value.absent(),
                Value<bool> notifyDuaForParents = const Value.absent(),
                Value<bool> notifyFridaySalawat = const Value.absent(),
                Value<bool> notifyFridayDuaHour = const Value.absent(),
                Value<bool> notifyDidYouKnow = const Value.absent(),
                Value<int> bedtimeHour = const Value.absent(),
                Value<int> bedtimeMinute = const Value.absent(),
                Value<String> prayerCalculationMethod = const Value.absent(),
                Value<String> madhab = const Value.absent(),
                Value<String> localeCode = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                id: id,
                gateDurationSeconds: gateDurationSeconds,
                unlockDurationSeconds: unlockDurationSeconds,
                gateContentCategories: gateContentCategories,
                quranMode: quranMode,
                showTranslation: showTranslation,
                quranFontSize: quranFontSize,
                translationLanguage: translationLanguage,
                themeMode: themeMode,
                pauseUntilTimestamp: pauseUntilTimestamp,
                sequentialPositionSurah: sequentialPositionSurah,
                sequentialPositionAyah: sequentialPositionAyah,
                onboardingCompleted: onboardingCompleted,
                streakCurrent: streakCurrent,
                streakLastDate: streakLastDate,
                notifyPrayerTimes: notifyPrayerTimes,
                notifyPrayerAdvanceMinutes: notifyPrayerAdvanceMinutes,
                notifyFridayKahf: notifyFridayKahf,
                notifyFastingDays: notifyFastingDays,
                notifyMorningAdhkar: notifyMorningAdhkar,
                notifyEveningAdhkar: notifyEveningAdhkar,
                notifyBedtimeDua: notifyBedtimeDua,
                notifySurahMulk: notifySurahMulk,
                notifyDuhaReminder: notifyDuhaReminder,
                notifyTahajjud: notifyTahajjud,
                notifyDhikrAfterPrayer: notifyDhikrAfterPrayer,
                notifyDuaForParents: notifyDuaForParents,
                notifyFridaySalawat: notifyFridaySalawat,
                notifyFridayDuaHour: notifyFridayDuaHour,
                notifyDidYouKnow: notifyDidYouKnow,
                bedtimeHour: bedtimeHour,
                bedtimeMinute: bedtimeMinute,
                prayerCalculationMethod: prayerCalculationMethod,
                madhab: madhab,
                localeCode: localeCode,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreference,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (
        UserPreference,
        BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreference>,
      ),
      UserPreference,
      PrefetchHooks Function()
    >;
typedef $$BlockedAppsTableCreateCompanionBuilder =
    BlockedAppsCompanion Function({
      Value<int> id,
      required String packageName,
      required String displayName,
      Value<String?> iconKey,
      Value<bool> isActive,
      required String platform,
      required String createdAt,
    });
typedef $$BlockedAppsTableUpdateCompanionBuilder =
    BlockedAppsCompanion Function({
      Value<int> id,
      Value<String> packageName,
      Value<String> displayName,
      Value<String?> iconKey,
      Value<bool> isActive,
      Value<String> platform,
      Value<String> createdAt,
    });

final class $$BlockedAppsTableReferences
    extends BaseReferences<_$AppDatabase, $BlockedAppsTable, BlockedApp> {
  $$BlockedAppsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GateSessionsTable, List<GateSession>>
  _gateSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gateSessions,
    aliasName: $_aliasNameGenerator(
      db.blockedApps.id,
      db.gateSessions.blockedAppId,
    ),
  );

  $$GateSessionsTableProcessedTableManager get gateSessionsRefs {
    final manager = $$GateSessionsTableTableManager(
      $_db,
      $_db.gateSessions,
    ).filter((f) => f.blockedAppId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gateSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UnlockSessionsTable, List<UnlockSession>>
  _unlockSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.unlockSessions,
    aliasName: $_aliasNameGenerator(
      db.blockedApps.id,
      db.unlockSessions.blockedAppId,
    ),
  );

  $$UnlockSessionsTableProcessedTableManager get unlockSessionsRefs {
    final manager = $$UnlockSessionsTableTableManager(
      $_db,
      $_db.unlockSessions,
    ).filter((f) => f.blockedAppId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_unlockSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BlockedAppsTableFilterComposer
    extends Composer<_$AppDatabase, $BlockedAppsTable> {
  $$BlockedAppsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gateSessionsRefs(
    Expression<bool> Function($$GateSessionsTableFilterComposer f) f,
  ) {
    final $$GateSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gateSessions,
      getReferencedColumn: (t) => t.blockedAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GateSessionsTableFilterComposer(
            $db: $db,
            $table: $db.gateSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> unlockSessionsRefs(
    Expression<bool> Function($$UnlockSessionsTableFilterComposer f) f,
  ) {
    final $$UnlockSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.unlockSessions,
      getReferencedColumn: (t) => t.blockedAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnlockSessionsTableFilterComposer(
            $db: $db,
            $table: $db.unlockSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BlockedAppsTableOrderingComposer
    extends Composer<_$AppDatabase, $BlockedAppsTable> {
  $$BlockedAppsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BlockedAppsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlockedAppsTable> {
  $$BlockedAppsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> gateSessionsRefs<T extends Object>(
    Expression<T> Function($$GateSessionsTableAnnotationComposer a) f,
  ) {
    final $$GateSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gateSessions,
      getReferencedColumn: (t) => t.blockedAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GateSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.gateSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> unlockSessionsRefs<T extends Object>(
    Expression<T> Function($$UnlockSessionsTableAnnotationComposer a) f,
  ) {
    final $$UnlockSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.unlockSessions,
      getReferencedColumn: (t) => t.blockedAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnlockSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.unlockSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BlockedAppsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BlockedAppsTable,
          BlockedApp,
          $$BlockedAppsTableFilterComposer,
          $$BlockedAppsTableOrderingComposer,
          $$BlockedAppsTableAnnotationComposer,
          $$BlockedAppsTableCreateCompanionBuilder,
          $$BlockedAppsTableUpdateCompanionBuilder,
          (BlockedApp, $$BlockedAppsTableReferences),
          BlockedApp,
          PrefetchHooks Function({
            bool gateSessionsRefs,
            bool unlockSessionsRefs,
          })
        > {
  $$BlockedAppsTableTableManager(_$AppDatabase db, $BlockedAppsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlockedAppsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlockedAppsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlockedAppsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> packageName = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> iconKey = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> platform = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
              }) => BlockedAppsCompanion(
                id: id,
                packageName: packageName,
                displayName: displayName,
                iconKey: iconKey,
                isActive: isActive,
                platform: platform,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String packageName,
                required String displayName,
                Value<String?> iconKey = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required String platform,
                required String createdAt,
              }) => BlockedAppsCompanion.insert(
                id: id,
                packageName: packageName,
                displayName: displayName,
                iconKey: iconKey,
                isActive: isActive,
                platform: platform,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BlockedAppsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({gateSessionsRefs = false, unlockSessionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (gateSessionsRefs) db.gateSessions,
                    if (unlockSessionsRefs) db.unlockSessions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (gateSessionsRefs)
                        await $_getPrefetchedData<
                          BlockedApp,
                          $BlockedAppsTable,
                          GateSession
                        >(
                          currentTable: table,
                          referencedTable: $$BlockedAppsTableReferences
                              ._gateSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BlockedAppsTableReferences(
                                db,
                                table,
                                p0,
                              ).gateSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.blockedAppId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (unlockSessionsRefs)
                        await $_getPrefetchedData<
                          BlockedApp,
                          $BlockedAppsTable,
                          UnlockSession
                        >(
                          currentTable: table,
                          referencedTable: $$BlockedAppsTableReferences
                              ._unlockSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BlockedAppsTableReferences(
                                db,
                                table,
                                p0,
                              ).unlockSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.blockedAppId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BlockedAppsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BlockedAppsTable,
      BlockedApp,
      $$BlockedAppsTableFilterComposer,
      $$BlockedAppsTableOrderingComposer,
      $$BlockedAppsTableAnnotationComposer,
      $$BlockedAppsTableCreateCompanionBuilder,
      $$BlockedAppsTableUpdateCompanionBuilder,
      (BlockedApp, $$BlockedAppsTableReferences),
      BlockedApp,
      PrefetchHooks Function({bool gateSessionsRefs, bool unlockSessionsRefs})
    >;
typedef $$GateSessionsTableCreateCompanionBuilder =
    GateSessionsCompanion Function({
      Value<int> id,
      Value<int?> blockedAppId,
      required String startedAt,
      Value<String?> completedAt,
      required int durationSeconds,
      Value<int?> actualDurationSeconds,
      required String gateContentType,
      Value<int?> quranSurah,
      Value<int?> quranAyahStart,
      Value<int?> quranAyahEnd,
      Value<int?> duaId,
      Value<int?> storyId,
      Value<int?> teachingId,
      Value<int?> sahabahStoryId,
      Value<int?> historyId,
      Value<int> extraReadingSeconds,
      Value<bool> wasCompleted,
      Value<bool> continuedReading,
    });
typedef $$GateSessionsTableUpdateCompanionBuilder =
    GateSessionsCompanion Function({
      Value<int> id,
      Value<int?> blockedAppId,
      Value<String> startedAt,
      Value<String?> completedAt,
      Value<int> durationSeconds,
      Value<int?> actualDurationSeconds,
      Value<String> gateContentType,
      Value<int?> quranSurah,
      Value<int?> quranAyahStart,
      Value<int?> quranAyahEnd,
      Value<int?> duaId,
      Value<int?> storyId,
      Value<int?> teachingId,
      Value<int?> sahabahStoryId,
      Value<int?> historyId,
      Value<int> extraReadingSeconds,
      Value<bool> wasCompleted,
      Value<bool> continuedReading,
    });

final class $$GateSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $GateSessionsTable, GateSession> {
  $$GateSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BlockedAppsTable _blockedAppIdTable(_$AppDatabase db) =>
      db.blockedApps.createAlias(
        $_aliasNameGenerator(db.gateSessions.blockedAppId, db.blockedApps.id),
      );

  $$BlockedAppsTableProcessedTableManager? get blockedAppId {
    final $_column = $_itemColumn<int>('blocked_app_id');
    if ($_column == null) return null;
    final manager = $$BlockedAppsTableTableManager(
      $_db,
      $_db.blockedApps,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_blockedAppIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$UnlockSessionsTable, List<UnlockSession>>
  _unlockSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.unlockSessions,
    aliasName: $_aliasNameGenerator(
      db.gateSessions.id,
      db.unlockSessions.gateSessionId,
    ),
  );

  $$UnlockSessionsTableProcessedTableManager get unlockSessionsRefs {
    final manager = $$UnlockSessionsTableTableManager(
      $_db,
      $_db.unlockSessions,
    ).filter((f) => f.gateSessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_unlockSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GateSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $GateSessionsTable> {
  $$GateSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualDurationSeconds => $composableBuilder(
    column: $table.actualDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gateContentType => $composableBuilder(
    column: $table.gateContentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quranSurah => $composableBuilder(
    column: $table.quranSurah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quranAyahStart => $composableBuilder(
    column: $table.quranAyahStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quranAyahEnd => $composableBuilder(
    column: $table.quranAyahEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duaId => $composableBuilder(
    column: $table.duaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get storyId => $composableBuilder(
    column: $table.storyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get teachingId => $composableBuilder(
    column: $table.teachingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sahabahStoryId => $composableBuilder(
    column: $table.sahabahStoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get historyId => $composableBuilder(
    column: $table.historyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get extraReadingSeconds => $composableBuilder(
    column: $table.extraReadingSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wasCompleted => $composableBuilder(
    column: $table.wasCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get continuedReading => $composableBuilder(
    column: $table.continuedReading,
    builder: (column) => ColumnFilters(column),
  );

  $$BlockedAppsTableFilterComposer get blockedAppId {
    final $$BlockedAppsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockedAppId,
      referencedTable: $db.blockedApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlockedAppsTableFilterComposer(
            $db: $db,
            $table: $db.blockedApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> unlockSessionsRefs(
    Expression<bool> Function($$UnlockSessionsTableFilterComposer f) f,
  ) {
    final $$UnlockSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.unlockSessions,
      getReferencedColumn: (t) => t.gateSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnlockSessionsTableFilterComposer(
            $db: $db,
            $table: $db.unlockSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GateSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $GateSessionsTable> {
  $$GateSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualDurationSeconds => $composableBuilder(
    column: $table.actualDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gateContentType => $composableBuilder(
    column: $table.gateContentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quranSurah => $composableBuilder(
    column: $table.quranSurah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quranAyahStart => $composableBuilder(
    column: $table.quranAyahStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quranAyahEnd => $composableBuilder(
    column: $table.quranAyahEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duaId => $composableBuilder(
    column: $table.duaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get storyId => $composableBuilder(
    column: $table.storyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get teachingId => $composableBuilder(
    column: $table.teachingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sahabahStoryId => $composableBuilder(
    column: $table.sahabahStoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get historyId => $composableBuilder(
    column: $table.historyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get extraReadingSeconds => $composableBuilder(
    column: $table.extraReadingSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wasCompleted => $composableBuilder(
    column: $table.wasCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get continuedReading => $composableBuilder(
    column: $table.continuedReading,
    builder: (column) => ColumnOrderings(column),
  );

  $$BlockedAppsTableOrderingComposer get blockedAppId {
    final $$BlockedAppsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockedAppId,
      referencedTable: $db.blockedApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlockedAppsTableOrderingComposer(
            $db: $db,
            $table: $db.blockedApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GateSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GateSessionsTable> {
  $$GateSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualDurationSeconds => $composableBuilder(
    column: $table.actualDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gateContentType => $composableBuilder(
    column: $table.gateContentType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quranSurah => $composableBuilder(
    column: $table.quranSurah,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quranAyahStart => $composableBuilder(
    column: $table.quranAyahStart,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quranAyahEnd => $composableBuilder(
    column: $table.quranAyahEnd,
    builder: (column) => column,
  );

  GeneratedColumn<int> get duaId =>
      $composableBuilder(column: $table.duaId, builder: (column) => column);

  GeneratedColumn<int> get storyId =>
      $composableBuilder(column: $table.storyId, builder: (column) => column);

  GeneratedColumn<int> get teachingId => $composableBuilder(
    column: $table.teachingId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sahabahStoryId => $composableBuilder(
    column: $table.sahabahStoryId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get historyId =>
      $composableBuilder(column: $table.historyId, builder: (column) => column);

  GeneratedColumn<int> get extraReadingSeconds => $composableBuilder(
    column: $table.extraReadingSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get wasCompleted => $composableBuilder(
    column: $table.wasCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get continuedReading => $composableBuilder(
    column: $table.continuedReading,
    builder: (column) => column,
  );

  $$BlockedAppsTableAnnotationComposer get blockedAppId {
    final $$BlockedAppsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockedAppId,
      referencedTable: $db.blockedApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlockedAppsTableAnnotationComposer(
            $db: $db,
            $table: $db.blockedApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> unlockSessionsRefs<T extends Object>(
    Expression<T> Function($$UnlockSessionsTableAnnotationComposer a) f,
  ) {
    final $$UnlockSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.unlockSessions,
      getReferencedColumn: (t) => t.gateSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnlockSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.unlockSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GateSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GateSessionsTable,
          GateSession,
          $$GateSessionsTableFilterComposer,
          $$GateSessionsTableOrderingComposer,
          $$GateSessionsTableAnnotationComposer,
          $$GateSessionsTableCreateCompanionBuilder,
          $$GateSessionsTableUpdateCompanionBuilder,
          (GateSession, $$GateSessionsTableReferences),
          GateSession,
          PrefetchHooks Function({bool blockedAppId, bool unlockSessionsRefs})
        > {
  $$GateSessionsTableTableManager(_$AppDatabase db, $GateSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GateSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GateSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GateSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> blockedAppId = const Value.absent(),
                Value<String> startedAt = const Value.absent(),
                Value<String?> completedAt = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<int?> actualDurationSeconds = const Value.absent(),
                Value<String> gateContentType = const Value.absent(),
                Value<int?> quranSurah = const Value.absent(),
                Value<int?> quranAyahStart = const Value.absent(),
                Value<int?> quranAyahEnd = const Value.absent(),
                Value<int?> duaId = const Value.absent(),
                Value<int?> storyId = const Value.absent(),
                Value<int?> teachingId = const Value.absent(),
                Value<int?> sahabahStoryId = const Value.absent(),
                Value<int?> historyId = const Value.absent(),
                Value<int> extraReadingSeconds = const Value.absent(),
                Value<bool> wasCompleted = const Value.absent(),
                Value<bool> continuedReading = const Value.absent(),
              }) => GateSessionsCompanion(
                id: id,
                blockedAppId: blockedAppId,
                startedAt: startedAt,
                completedAt: completedAt,
                durationSeconds: durationSeconds,
                actualDurationSeconds: actualDurationSeconds,
                gateContentType: gateContentType,
                quranSurah: quranSurah,
                quranAyahStart: quranAyahStart,
                quranAyahEnd: quranAyahEnd,
                duaId: duaId,
                storyId: storyId,
                teachingId: teachingId,
                sahabahStoryId: sahabahStoryId,
                historyId: historyId,
                extraReadingSeconds: extraReadingSeconds,
                wasCompleted: wasCompleted,
                continuedReading: continuedReading,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> blockedAppId = const Value.absent(),
                required String startedAt,
                Value<String?> completedAt = const Value.absent(),
                required int durationSeconds,
                Value<int?> actualDurationSeconds = const Value.absent(),
                required String gateContentType,
                Value<int?> quranSurah = const Value.absent(),
                Value<int?> quranAyahStart = const Value.absent(),
                Value<int?> quranAyahEnd = const Value.absent(),
                Value<int?> duaId = const Value.absent(),
                Value<int?> storyId = const Value.absent(),
                Value<int?> teachingId = const Value.absent(),
                Value<int?> sahabahStoryId = const Value.absent(),
                Value<int?> historyId = const Value.absent(),
                Value<int> extraReadingSeconds = const Value.absent(),
                Value<bool> wasCompleted = const Value.absent(),
                Value<bool> continuedReading = const Value.absent(),
              }) => GateSessionsCompanion.insert(
                id: id,
                blockedAppId: blockedAppId,
                startedAt: startedAt,
                completedAt: completedAt,
                durationSeconds: durationSeconds,
                actualDurationSeconds: actualDurationSeconds,
                gateContentType: gateContentType,
                quranSurah: quranSurah,
                quranAyahStart: quranAyahStart,
                quranAyahEnd: quranAyahEnd,
                duaId: duaId,
                storyId: storyId,
                teachingId: teachingId,
                sahabahStoryId: sahabahStoryId,
                historyId: historyId,
                extraReadingSeconds: extraReadingSeconds,
                wasCompleted: wasCompleted,
                continuedReading: continuedReading,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GateSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({blockedAppId = false, unlockSessionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (unlockSessionsRefs) db.unlockSessions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (blockedAppId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.blockedAppId,
                                    referencedTable:
                                        $$GateSessionsTableReferences
                                            ._blockedAppIdTable(db),
                                    referencedColumn:
                                        $$GateSessionsTableReferences
                                            ._blockedAppIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (unlockSessionsRefs)
                        await $_getPrefetchedData<
                          GateSession,
                          $GateSessionsTable,
                          UnlockSession
                        >(
                          currentTable: table,
                          referencedTable: $$GateSessionsTableReferences
                              ._unlockSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GateSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).unlockSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gateSessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GateSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GateSessionsTable,
      GateSession,
      $$GateSessionsTableFilterComposer,
      $$GateSessionsTableOrderingComposer,
      $$GateSessionsTableAnnotationComposer,
      $$GateSessionsTableCreateCompanionBuilder,
      $$GateSessionsTableUpdateCompanionBuilder,
      (GateSession, $$GateSessionsTableReferences),
      GateSession,
      PrefetchHooks Function({bool blockedAppId, bool unlockSessionsRefs})
    >;
typedef $$UnlockSessionsTableCreateCompanionBuilder =
    UnlockSessionsCompanion Function({
      Value<int> id,
      required int gateSessionId,
      required int blockedAppId,
      required String startedAt,
      required String expiresAt,
      Value<bool> isActive,
    });
typedef $$UnlockSessionsTableUpdateCompanionBuilder =
    UnlockSessionsCompanion Function({
      Value<int> id,
      Value<int> gateSessionId,
      Value<int> blockedAppId,
      Value<String> startedAt,
      Value<String> expiresAt,
      Value<bool> isActive,
    });

final class $$UnlockSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $UnlockSessionsTable, UnlockSession> {
  $$UnlockSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GateSessionsTable _gateSessionIdTable(_$AppDatabase db) =>
      db.gateSessions.createAlias(
        $_aliasNameGenerator(
          db.unlockSessions.gateSessionId,
          db.gateSessions.id,
        ),
      );

  $$GateSessionsTableProcessedTableManager get gateSessionId {
    final $_column = $_itemColumn<int>('gate_session_id')!;

    final manager = $$GateSessionsTableTableManager(
      $_db,
      $_db.gateSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gateSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BlockedAppsTable _blockedAppIdTable(_$AppDatabase db) =>
      db.blockedApps.createAlias(
        $_aliasNameGenerator(db.unlockSessions.blockedAppId, db.blockedApps.id),
      );

  $$BlockedAppsTableProcessedTableManager get blockedAppId {
    final $_column = $_itemColumn<int>('blocked_app_id')!;

    final manager = $$BlockedAppsTableTableManager(
      $_db,
      $_db.blockedApps,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_blockedAppIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UnlockSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $UnlockSessionsTable> {
  $$UnlockSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$GateSessionsTableFilterComposer get gateSessionId {
    final $$GateSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gateSessionId,
      referencedTable: $db.gateSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GateSessionsTableFilterComposer(
            $db: $db,
            $table: $db.gateSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BlockedAppsTableFilterComposer get blockedAppId {
    final $$BlockedAppsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockedAppId,
      referencedTable: $db.blockedApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlockedAppsTableFilterComposer(
            $db: $db,
            $table: $db.blockedApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UnlockSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UnlockSessionsTable> {
  $$UnlockSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$GateSessionsTableOrderingComposer get gateSessionId {
    final $$GateSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gateSessionId,
      referencedTable: $db.gateSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GateSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.gateSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BlockedAppsTableOrderingComposer get blockedAppId {
    final $$BlockedAppsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockedAppId,
      referencedTable: $db.blockedApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlockedAppsTableOrderingComposer(
            $db: $db,
            $table: $db.blockedApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UnlockSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnlockSessionsTable> {
  $$UnlockSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<String> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$GateSessionsTableAnnotationComposer get gateSessionId {
    final $$GateSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gateSessionId,
      referencedTable: $db.gateSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GateSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.gateSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BlockedAppsTableAnnotationComposer get blockedAppId {
    final $$BlockedAppsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blockedAppId,
      referencedTable: $db.blockedApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlockedAppsTableAnnotationComposer(
            $db: $db,
            $table: $db.blockedApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UnlockSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnlockSessionsTable,
          UnlockSession,
          $$UnlockSessionsTableFilterComposer,
          $$UnlockSessionsTableOrderingComposer,
          $$UnlockSessionsTableAnnotationComposer,
          $$UnlockSessionsTableCreateCompanionBuilder,
          $$UnlockSessionsTableUpdateCompanionBuilder,
          (UnlockSession, $$UnlockSessionsTableReferences),
          UnlockSession,
          PrefetchHooks Function({bool gateSessionId, bool blockedAppId})
        > {
  $$UnlockSessionsTableTableManager(
    _$AppDatabase db,
    $UnlockSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnlockSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnlockSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnlockSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> gateSessionId = const Value.absent(),
                Value<int> blockedAppId = const Value.absent(),
                Value<String> startedAt = const Value.absent(),
                Value<String> expiresAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => UnlockSessionsCompanion(
                id: id,
                gateSessionId: gateSessionId,
                blockedAppId: blockedAppId,
                startedAt: startedAt,
                expiresAt: expiresAt,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int gateSessionId,
                required int blockedAppId,
                required String startedAt,
                required String expiresAt,
                Value<bool> isActive = const Value.absent(),
              }) => UnlockSessionsCompanion.insert(
                id: id,
                gateSessionId: gateSessionId,
                blockedAppId: blockedAppId,
                startedAt: startedAt,
                expiresAt: expiresAt,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UnlockSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({gateSessionId = false, blockedAppId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (gateSessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.gateSessionId,
                                    referencedTable:
                                        $$UnlockSessionsTableReferences
                                            ._gateSessionIdTable(db),
                                    referencedColumn:
                                        $$UnlockSessionsTableReferences
                                            ._gateSessionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (blockedAppId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.blockedAppId,
                                    referencedTable:
                                        $$UnlockSessionsTableReferences
                                            ._blockedAppIdTable(db),
                                    referencedColumn:
                                        $$UnlockSessionsTableReferences
                                            ._blockedAppIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$UnlockSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnlockSessionsTable,
      UnlockSession,
      $$UnlockSessionsTableFilterComposer,
      $$UnlockSessionsTableOrderingComposer,
      $$UnlockSessionsTableAnnotationComposer,
      $$UnlockSessionsTableCreateCompanionBuilder,
      $$UnlockSessionsTableUpdateCompanionBuilder,
      (UnlockSession, $$UnlockSessionsTableReferences),
      UnlockSession,
      PrefetchHooks Function({bool gateSessionId, bool blockedAppId})
    >;
typedef $$ReadingProgressTableCreateCompanionBuilder =
    ReadingProgressCompanion Function({
      Value<int> id,
      required String contentType,
      required int contentId,
      required String firstReadAt,
      required String lastReadAt,
      Value<int> timesRead,
      Value<int> totalReadingSeconds,
      Value<bool> isFavorite,
      Value<bool> isMemorized,
    });
typedef $$ReadingProgressTableUpdateCompanionBuilder =
    ReadingProgressCompanion Function({
      Value<int> id,
      Value<String> contentType,
      Value<int> contentId,
      Value<String> firstReadAt,
      Value<String> lastReadAt,
      Value<int> timesRead,
      Value<int> totalReadingSeconds,
      Value<bool> isFavorite,
      Value<bool> isMemorized,
    });

class $$ReadingProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstReadAt => $composableBuilder(
    column: $table.firstReadAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timesRead => $composableBuilder(
    column: $table.timesRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalReadingSeconds => $composableBuilder(
    column: $table.totalReadingSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMemorized => $composableBuilder(
    column: $table.isMemorized,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadingProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstReadAt => $composableBuilder(
    column: $table.firstReadAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timesRead => $composableBuilder(
    column: $table.timesRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalReadingSeconds => $composableBuilder(
    column: $table.totalReadingSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMemorized => $composableBuilder(
    column: $table.isMemorized,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<String> get firstReadAt => $composableBuilder(
    column: $table.firstReadAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timesRead =>
      $composableBuilder(column: $table.timesRead, builder: (column) => column);

  GeneratedColumn<int> get totalReadingSeconds => $composableBuilder(
    column: $table.totalReadingSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMemorized => $composableBuilder(
    column: $table.isMemorized,
    builder: (column) => column,
  );
}

class $$ReadingProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingProgressTable,
          ReadingProgressData,
          $$ReadingProgressTableFilterComposer,
          $$ReadingProgressTableOrderingComposer,
          $$ReadingProgressTableAnnotationComposer,
          $$ReadingProgressTableCreateCompanionBuilder,
          $$ReadingProgressTableUpdateCompanionBuilder,
          (
            ReadingProgressData,
            BaseReferences<
              _$AppDatabase,
              $ReadingProgressTable,
              ReadingProgressData
            >,
          ),
          ReadingProgressData,
          PrefetchHooks Function()
        > {
  $$ReadingProgressTableTableManager(
    _$AppDatabase db,
    $ReadingProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<int> contentId = const Value.absent(),
                Value<String> firstReadAt = const Value.absent(),
                Value<String> lastReadAt = const Value.absent(),
                Value<int> timesRead = const Value.absent(),
                Value<int> totalReadingSeconds = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isMemorized = const Value.absent(),
              }) => ReadingProgressCompanion(
                id: id,
                contentType: contentType,
                contentId: contentId,
                firstReadAt: firstReadAt,
                lastReadAt: lastReadAt,
                timesRead: timesRead,
                totalReadingSeconds: totalReadingSeconds,
                isFavorite: isFavorite,
                isMemorized: isMemorized,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String contentType,
                required int contentId,
                required String firstReadAt,
                required String lastReadAt,
                Value<int> timesRead = const Value.absent(),
                Value<int> totalReadingSeconds = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isMemorized = const Value.absent(),
              }) => ReadingProgressCompanion.insert(
                id: id,
                contentType: contentType,
                contentId: contentId,
                firstReadAt: firstReadAt,
                lastReadAt: lastReadAt,
                timesRead: timesRead,
                totalReadingSeconds: totalReadingSeconds,
                isFavorite: isFavorite,
                isMemorized: isMemorized,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadingProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingProgressTable,
      ReadingProgressData,
      $$ReadingProgressTableFilterComposer,
      $$ReadingProgressTableOrderingComposer,
      $$ReadingProgressTableAnnotationComposer,
      $$ReadingProgressTableCreateCompanionBuilder,
      $$ReadingProgressTableUpdateCompanionBuilder,
      (
        ReadingProgressData,
        BaseReferences<
          _$AppDatabase,
          $ReadingProgressTable,
          ReadingProgressData
        >,
      ),
      ReadingProgressData,
      PrefetchHooks Function()
    >;
typedef $$SurahProgressTableCreateCompanionBuilder =
    SurahProgressCompanion Function({
      Value<int> surahNumber,
      Value<int> ayahsRead,
      required int totalAyahs,
      Value<bool> isCompleted,
      Value<String?> completedAt,
    });
typedef $$SurahProgressTableUpdateCompanionBuilder =
    SurahProgressCompanion Function({
      Value<int> surahNumber,
      Value<int> ayahsRead,
      Value<int> totalAyahs,
      Value<bool> isCompleted,
      Value<String?> completedAt,
    });

class $$SurahProgressTableFilterComposer
    extends Composer<_$AppDatabase, $SurahProgressTable> {
  $$SurahProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahsRead => $composableBuilder(
    column: $table.ayahsRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAyahs => $composableBuilder(
    column: $table.totalAyahs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SurahProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $SurahProgressTable> {
  $$SurahProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahsRead => $composableBuilder(
    column: $table.ayahsRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAyahs => $composableBuilder(
    column: $table.totalAyahs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SurahProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurahProgressTable> {
  $$SurahProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahsRead =>
      $composableBuilder(column: $table.ayahsRead, builder: (column) => column);

  GeneratedColumn<int> get totalAyahs => $composableBuilder(
    column: $table.totalAyahs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$SurahProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SurahProgressTable,
          SurahProgressData,
          $$SurahProgressTableFilterComposer,
          $$SurahProgressTableOrderingComposer,
          $$SurahProgressTableAnnotationComposer,
          $$SurahProgressTableCreateCompanionBuilder,
          $$SurahProgressTableUpdateCompanionBuilder,
          (
            SurahProgressData,
            BaseReferences<
              _$AppDatabase,
              $SurahProgressTable,
              SurahProgressData
            >,
          ),
          SurahProgressData,
          PrefetchHooks Function()
        > {
  $$SurahProgressTableTableManager(_$AppDatabase db, $SurahProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SurahProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SurahProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SurahProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahsRead = const Value.absent(),
                Value<int> totalAyahs = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<String?> completedAt = const Value.absent(),
              }) => SurahProgressCompanion(
                surahNumber: surahNumber,
                ayahsRead: ayahsRead,
                totalAyahs: totalAyahs,
                isCompleted: isCompleted,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahsRead = const Value.absent(),
                required int totalAyahs,
                Value<bool> isCompleted = const Value.absent(),
                Value<String?> completedAt = const Value.absent(),
              }) => SurahProgressCompanion.insert(
                surahNumber: surahNumber,
                ayahsRead: ayahsRead,
                totalAyahs: totalAyahs,
                isCompleted: isCompleted,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SurahProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SurahProgressTable,
      SurahProgressData,
      $$SurahProgressTableFilterComposer,
      $$SurahProgressTableOrderingComposer,
      $$SurahProgressTableAnnotationComposer,
      $$SurahProgressTableCreateCompanionBuilder,
      $$SurahProgressTableUpdateCompanionBuilder,
      (
        SurahProgressData,
        BaseReferences<_$AppDatabase, $SurahProgressTable, SurahProgressData>,
      ),
      SurahProgressData,
      PrefetchHooks Function()
    >;
typedef $$ReadAyahsTableCreateCompanionBuilder =
    ReadAyahsCompanion Function({
      Value<int> globalAyahId,
      required int surahNumber,
      required int ayahNumber,
      required String firstReadAt,
    });
typedef $$ReadAyahsTableUpdateCompanionBuilder =
    ReadAyahsCompanion Function({
      Value<int> globalAyahId,
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<String> firstReadAt,
    });

class $$ReadAyahsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadAyahsTable> {
  $$ReadAyahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get globalAyahId => $composableBuilder(
    column: $table.globalAyahId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstReadAt => $composableBuilder(
    column: $table.firstReadAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadAyahsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadAyahsTable> {
  $$ReadAyahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get globalAyahId => $composableBuilder(
    column: $table.globalAyahId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstReadAt => $composableBuilder(
    column: $table.firstReadAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadAyahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadAyahsTable> {
  $$ReadAyahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get globalAyahId => $composableBuilder(
    column: $table.globalAyahId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstReadAt => $composableBuilder(
    column: $table.firstReadAt,
    builder: (column) => column,
  );
}

class $$ReadAyahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadAyahsTable,
          ReadAyah,
          $$ReadAyahsTableFilterComposer,
          $$ReadAyahsTableOrderingComposer,
          $$ReadAyahsTableAnnotationComposer,
          $$ReadAyahsTableCreateCompanionBuilder,
          $$ReadAyahsTableUpdateCompanionBuilder,
          (ReadAyah, BaseReferences<_$AppDatabase, $ReadAyahsTable, ReadAyah>),
          ReadAyah,
          PrefetchHooks Function()
        > {
  $$ReadAyahsTableTableManager(_$AppDatabase db, $ReadAyahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadAyahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadAyahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadAyahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> globalAyahId = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String> firstReadAt = const Value.absent(),
              }) => ReadAyahsCompanion(
                globalAyahId: globalAyahId,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                firstReadAt: firstReadAt,
              ),
          createCompanionCallback:
              ({
                Value<int> globalAyahId = const Value.absent(),
                required int surahNumber,
                required int ayahNumber,
                required String firstReadAt,
              }) => ReadAyahsCompanion.insert(
                globalAyahId: globalAyahId,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                firstReadAt: firstReadAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadAyahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadAyahsTable,
      ReadAyah,
      $$ReadAyahsTableFilterComposer,
      $$ReadAyahsTableOrderingComposer,
      $$ReadAyahsTableAnnotationComposer,
      $$ReadAyahsTableCreateCompanionBuilder,
      $$ReadAyahsTableUpdateCompanionBuilder,
      (ReadAyah, BaseReferences<_$AppDatabase, $ReadAyahsTable, ReadAyah>),
      ReadAyah,
      PrefetchHooks Function()
    >;
typedef $$ReadingEventsTableCreateCompanionBuilder =
    ReadingEventsCompanion Function({
      Value<int> id,
      required String contentType,
      Value<int?> surahNumber,
      Value<int?> ayahStart,
      Value<int?> ayahEnd,
      Value<int?> duaId,
      required String readAt,
      Value<int> seconds,
    });
typedef $$ReadingEventsTableUpdateCompanionBuilder =
    ReadingEventsCompanion Function({
      Value<int> id,
      Value<String> contentType,
      Value<int?> surahNumber,
      Value<int?> ayahStart,
      Value<int?> ayahEnd,
      Value<int?> duaId,
      Value<String> readAt,
      Value<int> seconds,
    });

class $$ReadingEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingEventsTable> {
  $$ReadingEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahStart => $composableBuilder(
    column: $table.ayahStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahEnd => $composableBuilder(
    column: $table.ayahEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duaId => $composableBuilder(
    column: $table.duaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seconds => $composableBuilder(
    column: $table.seconds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadingEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingEventsTable> {
  $$ReadingEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahStart => $composableBuilder(
    column: $table.ayahStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahEnd => $composableBuilder(
    column: $table.ayahEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duaId => $composableBuilder(
    column: $table.duaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seconds => $composableBuilder(
    column: $table.seconds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingEventsTable> {
  $$ReadingEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahStart =>
      $composableBuilder(column: $table.ayahStart, builder: (column) => column);

  GeneratedColumn<int> get ayahEnd =>
      $composableBuilder(column: $table.ayahEnd, builder: (column) => column);

  GeneratedColumn<int> get duaId =>
      $composableBuilder(column: $table.duaId, builder: (column) => column);

  GeneratedColumn<String> get readAt =>
      $composableBuilder(column: $table.readAt, builder: (column) => column);

  GeneratedColumn<int> get seconds =>
      $composableBuilder(column: $table.seconds, builder: (column) => column);
}

class $$ReadingEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingEventsTable,
          ReadingEvent,
          $$ReadingEventsTableFilterComposer,
          $$ReadingEventsTableOrderingComposer,
          $$ReadingEventsTableAnnotationComposer,
          $$ReadingEventsTableCreateCompanionBuilder,
          $$ReadingEventsTableUpdateCompanionBuilder,
          (
            ReadingEvent,
            BaseReferences<_$AppDatabase, $ReadingEventsTable, ReadingEvent>,
          ),
          ReadingEvent,
          PrefetchHooks Function()
        > {
  $$ReadingEventsTableTableManager(_$AppDatabase db, $ReadingEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<int?> surahNumber = const Value.absent(),
                Value<int?> ayahStart = const Value.absent(),
                Value<int?> ayahEnd = const Value.absent(),
                Value<int?> duaId = const Value.absent(),
                Value<String> readAt = const Value.absent(),
                Value<int> seconds = const Value.absent(),
              }) => ReadingEventsCompanion(
                id: id,
                contentType: contentType,
                surahNumber: surahNumber,
                ayahStart: ayahStart,
                ayahEnd: ayahEnd,
                duaId: duaId,
                readAt: readAt,
                seconds: seconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String contentType,
                Value<int?> surahNumber = const Value.absent(),
                Value<int?> ayahStart = const Value.absent(),
                Value<int?> ayahEnd = const Value.absent(),
                Value<int?> duaId = const Value.absent(),
                required String readAt,
                Value<int> seconds = const Value.absent(),
              }) => ReadingEventsCompanion.insert(
                id: id,
                contentType: contentType,
                surahNumber: surahNumber,
                ayahStart: ayahStart,
                ayahEnd: ayahEnd,
                duaId: duaId,
                readAt: readAt,
                seconds: seconds,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadingEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingEventsTable,
      ReadingEvent,
      $$ReadingEventsTableFilterComposer,
      $$ReadingEventsTableOrderingComposer,
      $$ReadingEventsTableAnnotationComposer,
      $$ReadingEventsTableCreateCompanionBuilder,
      $$ReadingEventsTableUpdateCompanionBuilder,
      (
        ReadingEvent,
        BaseReferences<_$AppDatabase, $ReadingEventsTable, ReadingEvent>,
      ),
      ReadingEvent,
      PrefetchHooks Function()
    >;
typedef $$PrayerLogsTableCreateCompanionBuilder =
    PrayerLogsCompanion Function({
      Value<int> id,
      required String date,
      required String prayer,
      required String prayedAt,
    });
typedef $$PrayerLogsTableUpdateCompanionBuilder =
    PrayerLogsCompanion Function({
      Value<int> id,
      Value<String> date,
      Value<String> prayer,
      Value<String> prayedAt,
    });

class $$PrayerLogsTableFilterComposer
    extends Composer<_$AppDatabase, $PrayerLogsTable> {
  $$PrayerLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prayer => $composableBuilder(
    column: $table.prayer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prayedAt => $composableBuilder(
    column: $table.prayedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrayerLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrayerLogsTable> {
  $$PrayerLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prayer => $composableBuilder(
    column: $table.prayer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prayedAt => $composableBuilder(
    column: $table.prayedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrayerLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrayerLogsTable> {
  $$PrayerLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get prayer =>
      $composableBuilder(column: $table.prayer, builder: (column) => column);

  GeneratedColumn<String> get prayedAt =>
      $composableBuilder(column: $table.prayedAt, builder: (column) => column);
}

class $$PrayerLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrayerLogsTable,
          PrayerLog,
          $$PrayerLogsTableFilterComposer,
          $$PrayerLogsTableOrderingComposer,
          $$PrayerLogsTableAnnotationComposer,
          $$PrayerLogsTableCreateCompanionBuilder,
          $$PrayerLogsTableUpdateCompanionBuilder,
          (
            PrayerLog,
            BaseReferences<_$AppDatabase, $PrayerLogsTable, PrayerLog>,
          ),
          PrayerLog,
          PrefetchHooks Function()
        > {
  $$PrayerLogsTableTableManager(_$AppDatabase db, $PrayerLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrayerLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrayerLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrayerLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> prayer = const Value.absent(),
                Value<String> prayedAt = const Value.absent(),
              }) => PrayerLogsCompanion(
                id: id,
                date: date,
                prayer: prayer,
                prayedAt: prayedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String date,
                required String prayer,
                required String prayedAt,
              }) => PrayerLogsCompanion.insert(
                id: id,
                date: date,
                prayer: prayer,
                prayedAt: prayedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrayerLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrayerLogsTable,
      PrayerLog,
      $$PrayerLogsTableFilterComposer,
      $$PrayerLogsTableOrderingComposer,
      $$PrayerLogsTableAnnotationComposer,
      $$PrayerLogsTableCreateCompanionBuilder,
      $$PrayerLogsTableUpdateCompanionBuilder,
      (PrayerLog, BaseReferences<_$AppDatabase, $PrayerLogsTable, PrayerLog>),
      PrayerLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$BlockedAppsTableTableManager get blockedApps =>
      $$BlockedAppsTableTableManager(_db, _db.blockedApps);
  $$GateSessionsTableTableManager get gateSessions =>
      $$GateSessionsTableTableManager(_db, _db.gateSessions);
  $$UnlockSessionsTableTableManager get unlockSessions =>
      $$UnlockSessionsTableTableManager(_db, _db.unlockSessions);
  $$ReadingProgressTableTableManager get readingProgress =>
      $$ReadingProgressTableTableManager(_db, _db.readingProgress);
  $$SurahProgressTableTableManager get surahProgress =>
      $$SurahProgressTableTableManager(_db, _db.surahProgress);
  $$ReadAyahsTableTableManager get readAyahs =>
      $$ReadAyahsTableTableManager(_db, _db.readAyahs);
  $$ReadingEventsTableTableManager get readingEvents =>
      $$ReadingEventsTableTableManager(_db, _db.readingEvents);
  $$PrayerLogsTableTableManager get prayerLogs =>
      $$PrayerLogsTableTableManager(_db, _db.prayerLogs);
}
