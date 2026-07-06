/// Pure streak arithmetic for gate-completion streaks.
///
/// Streak dates are stored as local calendar days in `YYYY-MM-DD`. Day
/// differences are computed on UTC-constructed dates so DST transitions
/// (23/25-hour days) and timezone changes can never truncate to the wrong
/// whole day — `DateTime(y,m,d).difference` in local time is off by an hour
/// around DST, which `inDays` would round to 0.
library;

/// Formats [now]'s local calendar date as `YYYY-MM-DD`.
String formatStreakDate(DateTime now) =>
    '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

/// The streak value after completing a gate at [now], given the stored
/// [lastDate] (`YYYY-MM-DD`, possibly null/empty/invalid) and the [current]
/// streak count.
///
/// - first gate ever (or unreadable state) → 1
/// - same calendar day → unchanged (a day only counts once)
/// - exactly one day later → +1
/// - longer gap → back to 1
/// - [lastDate] in the future (clock set back, westward travel) → unchanged;
///   callers should still persist today's date so the streak can resume
///   normally tomorrow.
int nextStreak({
  required String? lastDate,
  required int current,
  required DateTime now,
}) {
  final last = (lastDate == null || lastDate.isEmpty)
      ? null
      : DateTime.tryParse(lastDate);
  if (last == null) return 1;

  final today = DateTime.utc(now.year, now.month, now.day);
  final lastDay = DateTime.utc(last.year, last.month, last.day);
  final gap = today.difference(lastDay).inDays;

  if (gap <= 0) return current == 0 ? 1 : current;
  if (gap == 1) return current + 1;
  return 1;
}
