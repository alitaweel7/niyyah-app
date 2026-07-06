import 'package:adhan_dart/adhan_dart.dart' as adhan;
import 'package:flutter/foundation.dart';

/// Prayer time data for a single prayer.
class PrayerTime {
  const PrayerTime({required this.name, required this.time, this.dateTime});
  final String name;
  final String time; // HH:mm format
  final DateTime? dateTime;

  /// Parse time string to DateTime for today.
  DateTime toDateTime() {
    if (dateTime != null) return dateTime!;
    final now = DateTime.now();
    final parts = time.split(':');
    final hour = parts.isNotEmpty ? int.tryParse(parts[0]) ?? 0 : 0;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}

/// Result containing today's prayer times and next prayer info.
class PrayerTimesResult {
  const PrayerTimesResult({
    required this.prayers,
    required this.nextPrayer,
    required this.minutesUntilNext,
    this.hijriDate,
  });

  final List<PrayerTime> prayers;
  final PrayerTime nextPrayer;
  final int minutesUntilNext;
  final String? hijriDate;
}

/// Available calculation methods for prayer times.
enum PrayerCalculationMethod {
  auto, // Auto-detect based on location
  muslimWorldLeague,
  egyptian,
  karachi,
  ummAlQura,
  dubai,
  qatar,
  kuwait,
  moonsightingCommittee,
  singapore,
  tehran,
  turkiye,
  northAmerica,
  morocco,
  jordan, // Jordan Ministry of Awqaf (Fajr 18°, Isha 18°)
}

/// Service that calculates prayer times locally using the adhan_dart library.
/// No internet required — all calculations are done on-device using
/// astronomical algorithms.
class PrayerTimesService {
  /// Get today's prayer times calculated locally.
  PrayerTimesResult? getTodayPrayerTimes({
    required double latitude,
    required double longitude,
    String? calculationMethod,
    String? countryCode,
    String? madhab,
  }) {
    try {
      final coords = adhan.Coordinates(latitude, longitude);
      final now = DateTime.now();
      final params = _getCalculationParameters(
        latitude: latitude,
        longitude: longitude,
        methodName: calculationMethod,
        countryCode: countryCode,
        madhab: madhab,
      );

      final prayerTimes = adhan.PrayerTimes(
        date: now,
        coordinates: coords,
        calculationParameters: params,
      );

      return _buildResult(prayerTimes);
    } catch (e) {
      debugPrint('Prayer times calculation error: $e');
      return null;
    }
  }

  /// Get prayer times for a specific date.
  PrayerTimesResult? getPrayerTimesForDate({
    required double latitude,
    required double longitude,
    required DateTime date,
    String? calculationMethod,
    String? countryCode,
    String? madhab,
  }) {
    try {
      final coords = adhan.Coordinates(latitude, longitude);
      final params = _getCalculationParameters(
        latitude: latitude,
        longitude: longitude,
        methodName: calculationMethod,
        countryCode: countryCode,
        madhab: madhab,
      );

      final prayerTimes = adhan.PrayerTimes(
        date: date,
        coordinates: coords,
        calculationParameters: params,
      );

      return _buildResult(prayerTimes);
    } catch (e) {
      debugPrint('Prayer times calculation error: $e');
      return null;
    }
  }

  /// Auto-detect the best calculation method based on coordinates.
  static PrayerCalculationMethod detectMethod(double latitude, double longitude) {
    // North America
    if (longitude >= -170 && longitude <= -50 &&
        latitude >= 15 && latitude <= 75) {
      return PrayerCalculationMethod.northAmerica;
    }

    // Turkey
    if (longitude >= 26 && longitude <= 45 &&
        latitude >= 36 && latitude <= 42) {
      return PrayerCalculationMethod.turkiye;
    }

    // Iran
    if (longitude >= 44 && longitude <= 63 &&
        latitude >= 25 && latitude <= 40) {
      return PrayerCalculationMethod.tehran;
    }

    // UAE / Dubai
    if (longitude >= 51 && longitude <= 56.5 &&
        latitude >= 22 && latitude <= 26.5) {
      return PrayerCalculationMethod.dubai;
    }

    // Qatar
    if (longitude >= 50 && longitude <= 52 &&
        latitude >= 24.5 && latitude <= 26.5) {
      return PrayerCalculationMethod.qatar;
    }

    // Kuwait
    if (longitude >= 46.5 && longitude <= 48.5 &&
        latitude >= 28.5 && latitude <= 30.5) {
      return PrayerCalculationMethod.kuwait;
    }

    // Saudi Arabia / Gulf (Umm Al-Qura)
    if (longitude >= 34 && longitude <= 56 &&
        latitude >= 16 && latitude <= 32) {
      return PrayerCalculationMethod.ummAlQura;
    }

    // Morocco
    if (longitude >= -17 && longitude <= -1 &&
        latitude >= 27 && latitude <= 36) {
      return PrayerCalculationMethod.morocco;
    }

    // Singapore / Malaysia / Indonesia
    if (longitude >= 95 && longitude <= 141 &&
        latitude >= -11 && latitude <= 8) {
      return PrayerCalculationMethod.singapore;
    }

    // Egypt / North Africa
    if (longitude >= -17 && longitude <= 37 &&
        latitude >= 15 && latitude <= 37) {
      return PrayerCalculationMethod.egyptian;
    }

    // Pakistan / India / Bangladesh / Afghanistan
    if (longitude >= 60 && longitude <= 93 &&
        latitude >= 5 && latitude <= 38) {
      return PrayerCalculationMethod.karachi;
    }

    // Default: Muslim World League (good for Europe, rest of world)
    return PrayerCalculationMethod.muslimWorldLeague;
  }

  /// Get user-friendly display name for a calculation method.
  static String methodDisplayName(PrayerCalculationMethod method) {
    switch (method) {
      case PrayerCalculationMethod.auto:
        return 'Auto-detect';
      case PrayerCalculationMethod.muslimWorldLeague:
        return 'Muslim World League';
      case PrayerCalculationMethod.egyptian:
        return 'Egyptian General Authority';
      case PrayerCalculationMethod.karachi:
        return 'University of Islamic Sciences, Karachi';
      case PrayerCalculationMethod.ummAlQura:
        return 'Umm al-Qura, Makkah';
      case PrayerCalculationMethod.dubai:
        return 'Dubai';
      case PrayerCalculationMethod.qatar:
        return 'Qatar';
      case PrayerCalculationMethod.kuwait:
        return 'Kuwait';
      case PrayerCalculationMethod.moonsightingCommittee:
        return 'Moonsighting Committee';
      case PrayerCalculationMethod.singapore:
        return 'Singapore / SE Asia';
      case PrayerCalculationMethod.tehran:
        return 'Institute of Geophysics, Tehran';
      case PrayerCalculationMethod.turkiye:
        return 'Diyanet, Turkey';
      case PrayerCalculationMethod.northAmerica:
        return 'ISNA (North America)';
      case PrayerCalculationMethod.morocco:
        return 'Morocco';
      case PrayerCalculationMethod.jordan:
        return 'Jordan (Awqaf)';
    }
  }

  adhan.CalculationParameters _getCalculationParameters({
    required double latitude,
    required double longitude,
    String? methodName,
    String? countryCode,
    String? madhab,
  }) {
    final method = _resolveMethod(latitude, longitude, methodName, countryCode);

    final base = switch (method) {
      // Jordan Ministry of Awqaf: Fajr 18°, Isha 18° (angle-based).
      PrayerCalculationMethod.jordan => adhan.CalculationParameters(
          method: adhan.CalculationMethod.other,
          fajrAngle: 18.0,
          ishaAngle: 18.0,
        ),
      PrayerCalculationMethod.muslimWorldLeague =>
        adhan.CalculationMethodParameters.muslimWorldLeague(),
      PrayerCalculationMethod.egyptian =>
        adhan.CalculationMethodParameters.egyptian(),
      PrayerCalculationMethod.karachi =>
        adhan.CalculationMethodParameters.karachi(),
      PrayerCalculationMethod.ummAlQura =>
        adhan.CalculationMethodParameters.ummAlQura(),
      PrayerCalculationMethod.dubai =>
        adhan.CalculationMethodParameters.dubai(),
      PrayerCalculationMethod.qatar =>
        adhan.CalculationMethodParameters.qatar(),
      PrayerCalculationMethod.kuwait =>
        adhan.CalculationMethodParameters.kuwait(),
      PrayerCalculationMethod.moonsightingCommittee =>
        adhan.CalculationMethodParameters.moonsightingCommittee(),
      PrayerCalculationMethod.singapore =>
        adhan.CalculationMethodParameters.singapore(),
      PrayerCalculationMethod.tehran =>
        adhan.CalculationMethodParameters.tehran(),
      PrayerCalculationMethod.turkiye =>
        adhan.CalculationMethodParameters.turkiye(),
      PrayerCalculationMethod.northAmerica =>
        adhan.CalculationMethodParameters.northAmerica(),
      PrayerCalculationMethod.morocco =>
        adhan.CalculationMethodParameters.morocco(),
      PrayerCalculationMethod.auto =>
        adhan.CalculationMethodParameters.muslimWorldLeague(),
    };

    return base.copyWith(madhab: _parseMadhab(madhab));
  }

  adhan.Madhab _parseMadhab(String? madhab) =>
      madhab == 'hanafi' ? adhan.Madhab.hanafi : adhan.Madhab.shafi;

  PrayerCalculationMethod _resolveMethod(
    double latitude,
    double longitude,
    String? methodName,
    String? countryCode,
  ) {
    // Explicit user override wins.
    if (methodName != null && methodName != 'auto') {
      for (final method in PrayerCalculationMethod.values) {
        if (method.name == methodName) return method;
      }
    }

    // Auto: prefer the country's official method, then coordinate detection.
    if (countryCode != null && countryCode.isNotEmpty) {
      final byCountry = _methodForCountry(countryCode);
      if (byCountry != null) return byCountry;
    }
    return detectMethod(latitude, longitude);
  }

  /// Maps an ISO country code to its official / most-common calculation method.
  /// Returns null to fall back to coordinate-based detection.
  PrayerCalculationMethod? _methodForCountry(String code) {
    switch (code.toUpperCase()) {
      case 'JO': // Jordan — Ministry of Awqaf
      case 'PS': // Palestine
        return PrayerCalculationMethod.jordan;
      case 'SA':
        return PrayerCalculationMethod.ummAlQura;
      case 'AE':
        return PrayerCalculationMethod.dubai;
      case 'QA':
        return PrayerCalculationMethod.qatar;
      case 'KW':
        return PrayerCalculationMethod.kuwait;
      case 'EG':
      case 'SD':
        return PrayerCalculationMethod.egyptian;
      case 'TR':
        return PrayerCalculationMethod.turkiye;
      case 'IR':
        return PrayerCalculationMethod.tehran;
      case 'MA':
        return PrayerCalculationMethod.morocco;
      case 'US':
      case 'CA':
        return PrayerCalculationMethod.northAmerica;
      case 'PK':
      case 'IN':
      case 'BD':
      case 'AF':
        return PrayerCalculationMethod.karachi;
      case 'SG':
      case 'MY':
      case 'ID':
      case 'BN':
        return PrayerCalculationMethod.singapore;
      case 'GB':
      case 'FR':
      case 'DE':
      case 'BE':
      case 'NL':
      case 'IT':
      case 'ES':
        return PrayerCalculationMethod.muslimWorldLeague;
      default:
        return null;
    }
  }

  PrayerTimesResult _buildResult(adhan.PrayerTimes prayerTimes) {
    final now = DateTime.now();

    String fmt(DateTime dt) {
      final local = dt.toLocal();
      return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    }

    PrayerTime make(String name, DateTime dt) {
      return PrayerTime(name: name, time: fmt(dt), dateTime: dt.toLocal());
    }

    final prayers = [
      make('Fajr', prayerTimes.fajr),
      make('Sunrise', prayerTimes.sunrise),
      make('Dhuhr', prayerTimes.dhuhr),
      make('Asr', prayerTimes.asr),
      make('Maghrib', prayerTimes.maghrib),
      make('Isha', prayerTimes.isha),
    ];

    // Find next prayer
    PrayerTime? nextPrayer;
    int minutesUntil = 0;

    final actualPrayers = prayers.where((p) => p.name != 'Sunrise').toList();

    for (final prayer in actualPrayers) {
      final prayerDt = prayer.toDateTime();
      if (prayerDt.isAfter(now)) {
        nextPrayer = prayer;
        minutesUntil = prayerDt.difference(now).inMinutes;
        break;
      }
    }

    // If no prayer found today, next is Fajr tomorrow
    if (nextPrayer == null) {
      nextPrayer = actualPrayers.first;
      final fajrTomorrow = prayerTimes.fajrAfter.toLocal();
      minutesUntil = fajrTomorrow.difference(now).inMinutes;
    }

    return PrayerTimesResult(
      prayers: prayers,
      nextPrayer: nextPrayer,
      minutesUntilNext: minutesUntil,
    );
  }
}

/// Prayer-aware gating context: set when "now" is just before or just after a
/// prayer, so the gate can nudge the user to go and pray.
class PrayerContext {
  const PrayerContext({
    required this.prayerName,
    required this.isUpcoming,
    required this.minutes,
  });

  final String prayerName;
  final bool isUpcoming; // true: within 10 min before; false: within 30 min after
  final int minutes; // minutes until (upcoming) or since (passed)
}

/// Returns a [PrayerContext] when now is within ~10 min before or ~30 min after
/// one of the five daily prayers, else null.
PrayerContext? prayerContextFor(PrayerTimesResult result, {DateTime? at}) {
  final now = at ?? DateTime.now();
  for (final p in result.prayers) {
    if (p.name == 'Sunrise') continue;
    final diff = p.toDateTime().difference(now).inMinutes;
    if (diff >= 0 && diff <= 10) {
      return PrayerContext(prayerName: p.name, isUpcoming: true, minutes: diff);
    }
    if (diff < 0 && diff >= -30) {
      return PrayerContext(prayerName: p.name, isUpcoming: false, minutes: -diff);
    }
  }
  return null;
}
