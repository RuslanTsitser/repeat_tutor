import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../app_directory/app_directory.dart';

LazyDatabase openDbConnection() {
  return LazyDatabase(() {
    final file = AppDirectory.appDbFile;
    print('openDbConnection: Создаем базу данных по пути: ${file.path}');

    final cacheBase = (AppDirectory.appCacheDirectory).path;
    sqlite3.tempDirectory = cacheBase;
    print('openDbConnection: Установлен tempDirectory: $cacheBase');

    final database = NativeDatabase.createInBackground(file);
    print('openDbConnection: База данных создана');
    return database;
  });
}
