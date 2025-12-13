import 'dart:async';
import 'dart:developer' show log;
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../plugins/app_directory.dart';
import 'logger_crashlytics.dart';
import 'logger_persistent.dart';
import 'logger_utils.dart';

export 'app_navigator_observer.dart';

void logInfo(Object data) {
  log('${DateTime.now()} ${convertOrToString(data)}');
  logPersistent(convertOrToString(data));
  if (kReleaseMode) recordCrashlyticsLog(convertOrToString(data));
}

void logError(Object data, [Object? error, StackTrace? stackTrace]) {
  log(
    '${DateTime.now()} ${convertOrToString(data)}',
    error: error,
    stackTrace: stackTrace,
  );
  logPersistent(convertOrToString(data), error: error, stackTrace: stackTrace);
  if (kReleaseMode) {
    unawaited(
      recordCrashlyticsError(
        error,
        stackTrace,
        reason: convertOrToString(data),
      ),
    );
  }
}

Directory get logsDirectory {
  final dir = Directory('${AppDirectory.appDocsDirectory.path}/logs');
  if (!dir.existsSync()) {
    dir.createSync();
  }
  return dir;
}

void manageLogFiles() {
  final logFiles = logsDirectory.listSync().whereType<File>().toList();

  final currentTime = DateTime.now();
  const int maxAgeInDays = 2;
  logInfo('Managing log files');

  for (final file in logFiles) {
    final lasModifiedDate = file.lastModifiedSync();

    // Удаляет файл лога, если он не обновлялся в течение двух дней
    if (currentTime.difference(lasModifiedDate).inDays > maxAgeInDays) {
      file.deleteSync();
      logInfo('Deleted log file: ${file.path}');
    }
  }
}
