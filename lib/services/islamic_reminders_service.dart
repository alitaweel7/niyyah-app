import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../core/time/app_timezone.dart';
import '../data/repositories/preferences_repository.dart';

/// Notification IDs (kept within the 1000-1099 range that
/// [_cancelAllIslamicNotifications] clears, so old schedules are removed too).
class _NotificationIds {
  static const int fridayKahf = 1020;
  static const int morningAdhkar = 1040;
  static const int eveningAdhkar = 1041;
}

/// A bilingual reminder (title + body in English and Arabic).
class _Reminder {
  const _Reminder(this.titleEn, this.bodyEn, this.titleAr, this.bodyAr);
  final String titleEn;
  final String bodyEn;
  final String titleAr;
  final String bodyAr;
}

const _fridayKahf = _Reminder(
  'Surah Al-Kahf 📖',
  'It is Sunnah to read Surah Al-Kahf on Fridays. Tap to begin.',
  'سورة الكهف 📖',
  'من السنّة قراءة سورة الكهف يوم الجمعة. اضغط لتبدأ.',
);

/// Short, meaningful morning reminders — one shown per day (rotating).
const List<_Reminder> _morningReminders = [
  _Reminder('A new day', 'Begin with Bismillah and a moment of gratitude to Allah.',
      'يومٌ جديد', 'ابدأ ببسم الله ولحظة شكرٍ لله.'),
  _Reminder('Morning remembrance', 'Recite Ayat al-Kursi this morning — protection until evening.',
      'أذكار الصباح', 'اقرأ آية الكرسي صباحاً — حفظٌ حتى المساء.'),
  _Reminder('A moment with the Quran', 'One ayah today can light your whole day.',
      'لحظة مع القرآن', 'آيةٌ واحدة اليوم تنيرُ يومك كله.'),
  _Reminder('Did you know?', 'The deeds most loved by Allah are the most consistent, even if small.',
      'هل تعلم؟', 'أحبّ الأعمال إلى الله أدومُها وإن قلّ.'),
  _Reminder('Send blessings', 'Send salawat upon the Prophet ﷺ — light for your day.',
      'الصلاة على النبي', 'أكثِر من الصلاة على النبي ﷺ — نورٌ ليومك.'),
  _Reminder('A short dua', 'Say: O Allah, grant me beneficial knowledge and good provision.',
      'دعاءٌ قصير', 'قل: اللهم ارزقني علماً نافعاً ورزقاً طيباً.'),
];

/// Short, meaningful evening reminders — one shown per day (rotating).
const List<_Reminder> _eveningReminders = [
  _Reminder('Evening remembrance', 'Close the day with dhikr and a little istighfar.',
      'أذكار المساء', 'اختم يومك بالذكر وقليلٍ من الاستغفار.'),
  _Reminder('Surah Al-Mulk', "Reading Surah Al-Mulk before sleep is a protection, by Allah's will.",
      'سورة الملك', 'قراءة سورة الملك قبل النوم حمايةٌ بإذن الله.'),
  _Reminder('Before you sleep', 'Recite the three Quls — a shield for the night.',
      'قبل النوم', 'اقرأ المعوّذات الثلاث — حصنٌ لليلتك.'),
  _Reminder('A calm heart', 'End your day with a few verses of the Quran.',
      'قلبٌ مطمئن', 'اختم يومك بآياتٍ من القرآن.'),
  _Reminder('Forgive', 'Before sleep, forgive someone and let your heart rest.',
      'سامِح', 'قبل النوم، سامح أحداً وأرِح قلبك.'),
  _Reminder('Gratitude', 'Thank Allah for one blessing from today.',
      'الشكر', 'اشكر الله على نعمةٍ من نِعَم اليوم.'),
];

/// Service that schedules all Islamic reminder notifications.
///
/// Uses [flutter_local_notifications] to schedule:
/// - Prayer time notifications (daily, based on actual times)
/// - Friday Surah Al-Kahf reminder
/// - Monday/Thursday fasting reminders (Sunday/Wednesday evening)
/// - Morning and evening adhkar reminders
class IslamicRemindersService {
  IslamicRemindersService({
    required PreferencesRepository preferencesRepo,
  }) : _preferencesRepo = preferencesRepo;

  final PreferencesRepository _preferencesRepo;

  final _plugin = FlutterLocalNotificationsPlugin();

  // ── Android notification channels ────────────────────────────────────

  static const _reminderChannel = AndroidNotificationDetails(
    'islamic_reminders',
    'Islamic Reminders',
    channelDescription: 'Weekly and daily Islamic reminders',
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
  );

  static const _adhkarChannel = AndroidNotificationDetails(
    'islamic_adhkar',
    'Adhkar Reminders',
    channelDescription: 'Morning and evening adhkar reminders',
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
  );

  // ── Prayer body texts ────────────────────────────────────────────────

  static const Map<String, String> prayerBodies = {
    'Fajr':
        "The two Rak'ahs before Fajr are better than the world and all that is in it. \u2014 Sahih Muslim 725",
    'Dhuhr':
        "Time for Dhuhr. The Prophet \uFDFA never missed four Rak'ahs before Dhuhr. \u2014 Sahih Bukhari",
    'Asr':
        "Time for Asr. The Prophet \uFDFA said: 'Whoever misses Asr prayer, it is as if he lost his family and wealth.' \u2014 Sahih Bukhari 552",
    'Maghrib':
        'Time for Maghrib. Hasten to break your fast if fasting, and pray.',
    'Isha':
        "Time for Isha. If people knew the reward of Isha and Fajr in congregation, they would come even if crawling. \u2014 Sahih Bukhari 615",
  };

  // ── Travel dua (static, for display anywhere in the app) ─────────────

  static const String travelDuaArabic =
      '\u0633\u064F\u0628\u0652\u062D\u064E\u0627\u0646\u064E \u0627\u0644\u0651\u064E\u0630\u0650\u064A \u0633\u064E\u062E\u0651\u064E\u0631\u064E \u0644\u064E\u0646\u064E\u0627 \u0647\u064E\u0640\u0670\u0630\u064E\u0627 \u0648\u064E\u0645\u064E\u0627 \u0643\u064F\u0646\u0651\u064E\u0627 \u0644\u064E\u0647\u064F \u0645\u064F\u0642\u0652\u0631\u0650\u0646\u0650\u064A\u0646\u064E \u0648\u064E\u0625\u0650\u0646\u0651\u064E\u0627 \u0625\u0650\u0644\u064E\u0649\u0670 \u0631\u064E\u0628\u0651\u0650\u0646\u064E\u0627 \u0644\u064E\u0645\u064F\u0646\u0642\u064E\u0644\u0650\u0628\u064F\u0648\u0646\u064E';

  static const String travelDuaTransliteration =
      'Subhanal-ladhi sakh-khara lana hadha wa ma kunna lahu muqrinin, wa inna ila Rabbina lamunqalibun.';

  static const String travelDuaTranslation =
      'Glory be to the One Who has subjected this for us, for we could not have done so ourselves. And surely to our Lord we will return.';

  static const String travelDuaReference = 'Surah Az-Zukhruf 43:13-14';

  // ── Main scheduling entry point ──────────────────────────────────────

  /// Reads user preferences and schedules all enabled notifications.
  /// Should be called on app startup after onboarding is complete,
  /// and whenever notification preferences change.
  Future<void> scheduleAll() async {
    if (kIsWeb) return;
    await AppTimezone.ensureInitialized();

    final prefs = await _preferencesRepo.getPreferences();
    final ar = prefs.localeCode == 'ar';

    // Start clean, then schedule a small, sensible set: at most 2 per day
    // (3 on Fridays). Content rotates daily and follows the app language.
    await _cancelAllIslamicNotifications();

    // 1) Morning reflection (~9:00) — one rotating beneficial reminder / dua.
    if (prefs.notifyMorningAdhkar) {
      final m = _pick(_morningReminders);
      await _scheduleDaily(
        id: _NotificationIds.morningAdhkar,
        hour: 9,
        minute: 0,
        title: ar ? m.titleAr : m.titleEn,
        body: ar ? m.bodyAr : m.bodyEn,
        channel: _adhkarChannel,
        payload: 'daily_reminder',
      );
    }

    // 2) Evening reflection (~20:00).
    if (prefs.notifyEveningAdhkar) {
      final e = _pick(_eveningReminders);
      await _scheduleDaily(
        id: _NotificationIds.eveningAdhkar,
        hour: 20,
        minute: 0,
        title: ar ? e.titleAr : e.titleEn,
        body: ar ? e.bodyAr : e.bodyEn,
        channel: _adhkarChannel,
        payload: 'daily_reminder',
      );
    }

    // 3) Friday Surah Al-Kahf (Fridays ~10:00).
    if (prefs.notifyFridayKahf) {
      await _scheduleWeekly(
        id: _NotificationIds.fridayKahf,
        dayOfWeek: DateTime.friday,
        hour: 10,
        minute: 0,
        title: ar ? _fridayKahf.titleAr : _fridayKahf.titleEn,
        body: ar ? _fridayKahf.bodyAr : _fridayKahf.bodyEn,
        channel: _reminderChannel,
        payload: 'friday_kahf',
      );
    }
  }

  /// Sends one sample reminder immediately (for previewing / testing).
  Future<void> sendSample() async {
    if (kIsWeb) return;
    final prefs = await _preferencesRepo.getPreferences();
    final ar = prefs.localeCode == 'ar';
    final m = _pick(_morningReminders);
    await _plugin.show(
      9999,
      ar ? m.titleAr : m.titleEn,
      ar ? m.bodyAr : m.bodyEn,
      NotificationDetails(
        android: _adhkarChannel,
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }

  /// Picks today's reminder from a pool (rotates by day-of-year).
  _Reminder _pick(List<_Reminder> pool) {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year)).inDays;
    return pool[dayOfYear % pool.length];
  }

  Future<void> _scheduleDaily({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
    required AndroidNotificationDetails channel,
    String? payload,
  }) async {
    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfTime(hour, minute),
        NotificationDetails(
          android: channel,
          iOS: const DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload,
      );
    } catch (_) {}
  }

  Future<void> _scheduleWeekly({
    required int id,
    required int dayOfWeek,
    required int hour,
    required int minute,
    required String title,
    required String body,
    required AndroidNotificationDetails channel,
    String? payload,
  }) async {
    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfDayAndTime(dayOfWeek, hour, minute),
        NotificationDetails(
          android: channel,
          iOS: const DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: payload,
      );
    } catch (_) {}
  }

  /// Cancel all Islamic reminder notifications (IDs 1000-1099).
  Future<void> _cancelAllIslamicNotifications() async {
    for (int id = 1000; id < 1100; id++) {
      await _plugin.cancel(id);
    }
  }

  /// Convert a [DateTime] to a [TZDateTime] in the local timezone.
  /// We use the device's local timezone via `timezone` package integration
  /// with flutter_local_notifications.
  tz.TZDateTime _dateTimeToTZ(DateTime dateTime) {
    // Use the local timezone
    final location = tz.local;
    return tz.TZDateTime(
      location,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );
  }

  /// Compute the next occurrence of a specific time today or tomorrow.
  /// Used for daily recurring notifications.
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now) || scheduledDate.isAtSameMomentAs(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return _dateTimeToTZ(scheduledDate);
  }

  /// Compute the next occurrence of a specific day of the week and time.
  /// Used for weekly recurring notifications.
  tz.TZDateTime _nextInstanceOfDayAndTime(int dayOfWeek, int hour, int minute) {
    final now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);

    // Find the next occurrence of the desired day of the week
    while (scheduledDate.weekday != dayOfWeek) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    // If the time has already passed today (same weekday), schedule for next week
    if (scheduledDate.isBefore(now) || scheduledDate.isAtSameMomentAs(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    return _dateTimeToTZ(scheduledDate);
  }
}
