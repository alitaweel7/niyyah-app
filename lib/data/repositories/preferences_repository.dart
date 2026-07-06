import 'package:drift/drift.dart';

import '../datasources/local/app_database.dart';
import '../models/gate_content_type.dart';

class PreferencesRepository {
  PreferencesRepository(this._db);

  final AppDatabase _db;

  Future<UserPreference> getPreferences() async {
    final rows = await _db.select(_db.userPreferences).get();
    if (rows.isEmpty) {
      await _db.into(_db.userPreferences).insert(
        UserPreferencesCompanion.insert(),
      );
      return (await _db.select(_db.userPreferences).get()).first;
    }
    return rows.first;
  }

  Stream<UserPreference> watchPreferences() {
    return (_db.select(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .watchSingle();
  }

  Future<void> updateGateDuration(int seconds) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      gateDurationSeconds: Value(seconds),
    ));
  }

  Future<void> updateUnlockDuration(int seconds) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      unlockDurationSeconds: Value(seconds),
    ));
  }

  Future<void> updateContentCategories(List<GateContentType> categories) async {
    final value = categories.map((c) => c.dbValue).join(',');
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      gateContentCategories: Value(value),
    ));
  }

  Future<void> updateQuranMode(QuranMode mode) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      quranMode: Value(mode.dbValue),
    ));
  }

  Future<void> updateShowTranslation(bool show) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      showTranslation: Value(show),
    ));
  }

  Future<void> updateQuranFontSize(double size) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      quranFontSize: Value(size),
    ));
  }

  Future<void> updateThemeMode(String mode) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      themeMode: Value(mode),
    ));
  }

  Future<void> setPauseUntil(int? timestamp) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      pauseUntilTimestamp: Value(timestamp),
    ));
  }

  Future<void> completeOnboarding() async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(const UserPreferencesCompanion(
      onboardingCompleted: Value(true),
    ));
  }

  Future<void> updateSequentialPosition(int surah, int ayah) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      sequentialPositionSurah: Value(surah),
      sequentialPositionAyah: Value(ayah),
    ));
  }

  Future<void> updateTranslationLanguage(String languageCode) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      translationLanguage: Value(languageCode),
    ));
  }

  Future<void> updateStreak(int current, String lastDate) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      streakCurrent: Value(current),
      streakLastDate: Value(lastDate),
    ));
  }

  List<GateContentType> parseContentCategories(String categories) {
    return categories
        .split(',')
        .where((s) => s.isNotEmpty)
        .map((s) => GateContentType.fromDbValue(s.trim()))
        .toList();
  }

  // ── Notification Preferences ──────────────────────────────────────────

  Future<void> updateNotifyPrayerTimes(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyPrayerTimes: Value(value),
    ));
  }

  Future<void> updateNotifyPrayerAdvanceMinutes(int minutes) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyPrayerAdvanceMinutes: Value(minutes),
    ));
  }

  Future<void> updateNotifyFridayKahf(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyFridayKahf: Value(value),
    ));
  }

  Future<void> updateNotifyFastingDays(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyFastingDays: Value(value),
    ));
  }

  Future<void> updateNotifyMorningAdhkar(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyMorningAdhkar: Value(value),
    ));
  }

  Future<void> updateNotifyEveningAdhkar(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyEveningAdhkar: Value(value),
    ));
  }

  // ── Extended Notification Preferences (v3) ──────────────────────────────

  Future<void> updateNotifyBedtimeDua(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyBedtimeDua: Value(value),
    ));
  }

  Future<void> updateNotifySurahMulk(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifySurahMulk: Value(value),
    ));
  }

  Future<void> updateNotifyDuhaReminder(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyDuhaReminder: Value(value),
    ));
  }

  Future<void> updateNotifyTahajjud(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyTahajjud: Value(value),
    ));
  }

  Future<void> updateNotifyDhikrAfterPrayer(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyDhikrAfterPrayer: Value(value),
    ));
  }

  Future<void> updateNotifyDuaForParents(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyDuaForParents: Value(value),
    ));
  }

  Future<void> updateNotifyFridaySalawat(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyFridaySalawat: Value(value),
    ));
  }

  Future<void> updateNotifyFridayDuaHour(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyFridayDuaHour: Value(value),
    ));
  }

  Future<void> updateNotifyDidYouKnow(bool value) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      notifyDidYouKnow: Value(value),
    ));
  }

  Future<void> updateBedtime(int hour, int minute) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      bedtimeHour: Value(hour),
      bedtimeMinute: Value(minute),
    ));
  }

  Future<void> updatePrayerCalculationMethod(String method) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      prayerCalculationMethod: Value(method),
    ));
  }

  Future<void> updateMadhab(String madhab) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      madhab: Value(madhab),
    ));
  }

  Future<void> updateLocale(String localeCode) async {
    await (_db.update(_db.userPreferences)
          ..where((t) => t.id.equals(1)))
        .write(UserPreferencesCompanion(
      localeCode: Value(localeCode),
    ));
  }
}
