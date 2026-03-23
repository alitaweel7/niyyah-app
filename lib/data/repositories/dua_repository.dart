import 'dart:math';

import '../datasources/quran/quran_database.dart';

class DuaRepository {
  DuaRepository(this._db);

  final QuranDatabase _db;
  final _random = Random();

  Future<List<Dua>> getAllDuas() {
    return _db.select(_db.duas).get();
  }

  Future<Dua> getDuaById(int id) {
    return (_db.select(_db.duas)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<Dua>> getDuasByCategory(String category) {
    return (_db.select(_db.duas)
          ..where((t) => t.category.equals(category)))
        .get();
  }

  Future<Dua> getRandomDua() async {
    final all = await getAllDuas();
    if (all.isEmpty) {
      throw StateError('No duas found in database');
    }
    return all[_random.nextInt(all.length)];
  }

  Future<List<String>> getCategories() async {
    final result = await _db.customSelect(
      'SELECT DISTINCT category FROM duas ORDER BY category',
    ).get();
    return result.map((r) => r.read<String>('category')).toList();
  }

  Future<int> getDuaCount() async {
    final result = await _db.customSelect(
      'SELECT COUNT(*) as count FROM duas',
    ).getSingle();
    return result.read<int>('count');
  }
}
