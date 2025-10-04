import 'dart:io';

import 'package:share_plus/share_plus.dart';

import '../app_directory/app_directory.dart';
import 'logger_persistent.dart';

Future<void> shareLogFiles() async {
  final files = AppDirectory.logsDirectory.listSync().whereType<File>().toList();
  await Share.shareXFiles(files.map((e) => XFile(e.path)).toList());
}

Future<void> clearLogFiles() async {
  final files = AppDirectory.logsDirectory.listSync().whereType<File>().toList();
  for (final file in files) {
    await file.delete();
  }
}

List<String> getLogFiles() {
  final files = AppDirectory.logsDirectory.listSync().whereType<File>().toList();
  files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

  forceCreateNewLogFile();

  return files.map((e) => e.path).toList();
}
