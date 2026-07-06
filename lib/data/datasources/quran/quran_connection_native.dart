import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/app_constants.dart';

QueryExecutor openQuranDb() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, AppConstants.quranDbName));

    if (!await file.exists()) {
      // Copy bundled pre-populated database from assets
      final data = await rootBundle.load(
        'assets/quran/${AppConstants.quranDbName}',
      );
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    }

    return NativeDatabase.createInBackground(file);
  });
}
