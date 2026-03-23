import 'dart:io';

import 'package:drift/drift.dart';

import '../datasources/local/app_database.dart';

class BlockedAppRepository {
  BlockedAppRepository(this._db);

  final AppDatabase _db;

  Future<List<BlockedApp>> getActiveBlockedApps() {
    return (_db.select(_db.blockedApps)
          ..where((t) => t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.displayName)]))
        .get();
  }

  Future<List<BlockedApp>> getAllBlockedApps() {
    return (_db.select(_db.blockedApps)
          ..orderBy([(t) => OrderingTerm.asc(t.displayName)]))
        .get();
  }

  Stream<List<BlockedApp>> watchActiveBlockedApps() {
    return (_db.select(_db.blockedApps)
          ..where((t) => t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.displayName)]))
        .watch();
  }

  Future<int> addBlockedApp({
    required String packageName,
    required String displayName,
    String? iconKey,
  }) {
    return _db.into(_db.blockedApps).insert(
      BlockedAppsCompanion.insert(
        packageName: packageName,
        displayName: displayName,
        iconKey: Value(iconKey),
        platform: Platform.isIOS ? 'ios' : 'android',
        createdAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<void> removeBlockedApp(int id) async {
    await (_db.update(_db.blockedApps)..where((t) => t.id.equals(id)))
        .write(const BlockedAppsCompanion(isActive: Value(false)));
  }

  Future<void> reactivateBlockedApp(int id) async {
    await (_db.update(_db.blockedApps)..where((t) => t.id.equals(id)))
        .write(const BlockedAppsCompanion(isActive: Value(true)));
  }

  Future<int> getActiveCount() async {
    final apps = await getActiveBlockedApps();
    return apps.length;
  }

  Future<BlockedApp?> findByPackageName(String packageName) async {
    final results = await (_db.select(_db.blockedApps)
          ..where((t) => t.packageName.equals(packageName)))
        .get();
    return results.isEmpty ? null : results.first;
  }
}
