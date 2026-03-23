import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/quran/quran_database.dart';
import '../../data/repositories/blocked_app_repository.dart';
import '../../data/repositories/dua_repository.dart';
import '../../data/repositories/gate_session_repository.dart';
import '../../data/repositories/preferences_repository.dart';
import '../../data/repositories/quran_repository.dart';
import '../../data/repositories/reading_progress_repository.dart';

// ── Databases ───────────────────────────────────────────────────────────────

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final quranDatabaseProvider = Provider<QuranDatabase>((ref) {
  final db = QuranDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// ── Repositories ────────────────────────────────────────────────────────────

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return PreferencesRepository(ref.watch(appDatabaseProvider));
});

final quranRepositoryProvider = Provider<QuranRepository>((ref) {
  return QuranRepository(ref.watch(quranDatabaseProvider));
});

final duaRepositoryProvider = Provider<DuaRepository>((ref) {
  return DuaRepository(ref.watch(quranDatabaseProvider));
});

final gateSessionRepositoryProvider = Provider<GateSessionRepository>((ref) {
  return GateSessionRepository(ref.watch(appDatabaseProvider));
});

final blockedAppRepositoryProvider = Provider<BlockedAppRepository>((ref) {
  return BlockedAppRepository(ref.watch(appDatabaseProvider));
});

final readingProgressRepositoryProvider =
    Provider<ReadingProgressRepository>((ref) {
  return ReadingProgressRepository(ref.watch(appDatabaseProvider));
});

// ── Preferences Stream ──────────────────────────────────────────────────────

final preferencesStreamProvider = StreamProvider((ref) {
  return ref.watch(preferencesRepositoryProvider).watchPreferences();
});

// ── Blocked Apps Stream ─────────────────────────────────────────────────────

final blockedAppsStreamProvider = StreamProvider((ref) {
  return ref.watch(blockedAppRepositoryProvider).watchActiveBlockedApps();
});
