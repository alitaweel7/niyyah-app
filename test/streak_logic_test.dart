import 'package:aya_unlock/core/utils/streak_logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('nextStreak', () {
    test('first gate ever (null / empty last date) starts at 1', () {
      final now = DateTime(2026, 7, 6, 21, 30);
      expect(nextStreak(lastDate: null, current: 0, now: now), 1);
      expect(nextStreak(lastDate: '', current: 0, now: now), 1);
    });

    test('unparseable stored date resets to 1 instead of crashing', () {
      final now = DateTime(2026, 7, 6, 21, 30);
      expect(nextStreak(lastDate: 'not-a-date', current: 7, now: now), 1);
    });

    test('same calendar day leaves the streak unchanged', () {
      final now = DateTime(2026, 7, 6, 23, 59);
      expect(nextStreak(lastDate: '2026-07-06', current: 5, now: now), 5);
    });

    test('consecutive day increments, even just after midnight', () {
      final now = DateTime(2026, 7, 7, 0, 5);
      expect(nextStreak(lastDate: '2026-07-06', current: 5, now: now), 6);
    });

    test('a missed day resets to 1', () {
      final now = DateTime(2026, 7, 8);
      expect(nextStreak(lastDate: '2026-07-06', current: 30, now: now), 1);
    });

    test('increments across a month boundary', () {
      final now = DateTime(2026, 2, 1, 6);
      expect(nextStreak(lastDate: '2026-01-31', current: 12, now: now), 13);
    });

    test('increments across a year boundary', () {
      final now = DateTime(2027, 1, 1, 5, 30);
      expect(nextStreak(lastDate: '2026-12-31', current: 100, now: now), 101);
    });

    test('increments across the Feb 29 leap boundary', () {
      final now = DateTime(2028, 3, 1);
      expect(nextStreak(lastDate: '2028-02-29', current: 3, now: now), 4);
    });

    test('stored date in the future (clock set back / westward travel) keeps '
        'the streak instead of resetting', () {
      final now = DateTime(2026, 7, 6);
      expect(nextStreak(lastDate: '2026-07-07', current: 9, now: now), 9);
    });

    test('future stored date with a zero streak still yields 1', () {
      final now = DateTime(2026, 7, 6);
      expect(nextStreak(lastDate: '2026-07-07', current: 0, now: now), 1);
    });

    test('DST-length days cannot round the gap to zero (UTC arithmetic)', () {
      // 2026-03-08 was a US spring-forward date (23-hour local day). Local
      // DateTime subtraction would give 23h → inDays == 0 → "same day".
      final now = DateTime(2026, 3, 9, 8);
      expect(nextStreak(lastDate: '2026-03-08', current: 2, now: now), 3);
    });
  });

  group('formatStreakDate', () {
    test('zero-pads month and day', () {
      expect(formatStreakDate(DateTime(2026, 7, 6)), '2026-07-06');
      expect(formatStreakDate(DateTime(2026, 11, 24)), '2026-11-24');
    });
  });
}
