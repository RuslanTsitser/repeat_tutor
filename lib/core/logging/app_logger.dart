import 'dart:developer' show log;

import 'package:flutter/foundation.dart';

import 'logger_crashlytics.dart';
import 'logger_persistent.dart';
import 'logger_utils.dart';

export 'app_navigator_observer.dart';

void logInfo(dynamic data) {
  log('${DateTime.now()} ${convertOrToString(data)}');
  logPersistent(convertOrToString(data));
  if (kReleaseMode) recordCrashlyticsLog(convertOrToString(data));
}

void logError(dynamic data, [dynamic error, StackTrace? stackTrace]) {
  log('${DateTime.now()} ${convertOrToString(data)}', error: error, stackTrace: stackTrace);
  logPersistent(convertOrToString(data), error: error, stackTrace: stackTrace);
  if (kReleaseMode) recordCrashlyticsError(error, stackTrace, reason: convertOrToString(data));
}
