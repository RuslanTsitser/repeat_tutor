import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../app_directory/app_directory.dart';

LazyDatabase openDbConnection() {
  return LazyDatabase(() {
    final file = AppDirectory.appDbFile;

    final cacheBase = (AppDirectory.appCacheDirectory).path;
    sqlite3.tempDirectory = cacheBase;

    return NativeDatabase.createInBackground(file);
  });
}
