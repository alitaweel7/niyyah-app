import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../core/constants/app_constants.dart';

QueryExecutor openQuranDb() {
  return driftDatabase(
    name: AppConstants.quranDbName,
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
      initializeDatabase: () async {
        final data = await rootBundle.load(
          'assets/quran/${AppConstants.quranDbName}',
        );
        return data.buffer.asUint8List();
      },
    ),
  );
}
