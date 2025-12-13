// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../app_directory/app_directory.dart';

/// Get or create the session log file
File createLogFile() {
  final logDir = AppDirectory.logsDirectory;
  final logFileName = convertDateToLogFileName(DateTime.now());
  final logFile = File('${logDir.path}/$logFileName');
  if (!logFile.existsSync()) {
    logFile.createSync();
    log('Log file created: ${logFile.path}');
  }
  return logFile;
}

/// Utility to convert date to log file name
String convertDateToLogFileName(DateTime date) {
  return 'log_session_${DateTime.now().toIso8601String()}.txt';
}

String convertOrToString(Object? data) {
  if (data is Map || data is List) {
    return _encoder.convert(data);
  }
  return data.toString();
}

// Плагин требует dynamic
Object _toEncodableFallback(object) {
  return object.toString();
}

const _encoder = JsonEncoder.withIndent('  ', _toEncodableFallback);

StackTrace? limitStackTrace(StackTrace? stackTrace, int limit) {
  if (stackTrace == null) {
    return null;
  }

  final stackTraceLines = stackTrace.toString().split('\n');
  final limitedLines = stackTraceLines.take(limit).join('\n');
  return StackTrace.fromString(limitedLines);
}
