import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import '../../plugins/app_directory.dart';

File get _appDbFile {
  final path = AppDirectory.appDocsDirectory.path;
  final file = File(p.join(path, 'repeat_tutor.sqlite'));
  return file;
}

LazyDatabase openDbConnection() {
  return LazyDatabase(() {
    final file = _appDbFile;

    final cacheBase = (AppDirectory.appCacheDirectory).path;
    sqlite3.tempDirectory = cacheBase;

    return NativeDatabase.createInBackground(file);
  });
}
