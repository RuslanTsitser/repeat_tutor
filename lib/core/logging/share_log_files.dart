import 'dart:io';
import 'dart:ui' as ui;

import 'package:share_plus/share_plus.dart';

import 'app_logger.dart';
import 'logger_persistent.dart';

Future<void> shareLogFiles() async {
  final view = ui.PlatformDispatcher.instance.views.first;
  final physicalSize = view.physicalSize;
  final devicePixelRatio = view.devicePixelRatio;
  final logicalSize = ui.Size(
    physicalSize.width / devicePixelRatio,
    physicalSize.height / devicePixelRatio,
  );
  final sharePositionOrigin = ui.Rect.fromLTWH(
    0,
    0,
    logicalSize.width,
    logicalSize.height,
  );
  final files = logsDirectory.listSync().whereType<File>().toList();
  await SharePlus.instance.share(
    ShareParams(
      files: files.map((e) => XFile(e.path)).toList(),
      sharePositionOrigin: sharePositionOrigin,
    ),
  );
}

Future<void> clearLogFiles() async {
  final files = logsDirectory.listSync().whereType<File>().toList();
  for (final file in files) {
    await file.delete();
  }
}

List<String> getLogFiles() {
  final files = logsDirectory.listSync().whereType<File>().toList();
  files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

  forceCreateNewLogFile();

  return files.map((e) => e.path).toList();
}
