import 'dart:collection';
import 'dart:io';

import 'logger_utils.dart';

void logPersistent(String value, {Object? error, StackTrace? stackTrace, bool showTime = true}) {
  _checkIfNewLogFileIsNeeded(
    maxFileSize: 512 * 1024, // 512 килобайт
    checkInterval: const Duration(minutes: 10), // 10 минут
  );
  final buffer = StringBuffer()..writeln('${showTime ? DateTime.now().toIso8601String() : ''}$value');
  if (error != null) buffer.writeln(error);
  if (stackTrace != null) buffer.writeln(stackTrace);

  _logQueue.addLast(buffer.toString());
  if (!_isWriting) {
    _writeLogs();
  }
}

File _logFile = createLogFile();

final Queue<String> _logQueue = Queue();
bool _isWriting = false;

void _writeLogs() {
  _isWriting = true;
  while (_logQueue.isNotEmpty) {
    final log = _logQueue.removeFirst();
    _logFile.writeAsStringSync('$log\n', mode: FileMode.append);
  }
  _isWriting = false;
}

DateTime _lastCheckTime = DateTime.now();

/// Проверяем, нужно ли создать новый файл логов
/// Если прошло больше 10 минут, то проверяем, нужно ли создать новый файл
/// Если файл больше 512 килобайт, то создаем новый
void _checkIfNewLogFileIsNeeded({
  required int maxFileSize,
  required Duration checkInterval,
}) {
  final now = DateTime.now();
  if (now.difference(_lastCheckTime) > checkInterval) {
    final length = _logFile.lengthSync();

    /// Если файл больше 512 килобайт, то создаем новый
    if (length > maxFileSize) {
      _logFile = createLogFile();
    }
    _lastCheckTime = now;
  }
}

/// Форсим создание нового лог файла
void forceCreateNewLogFile() {
  _logFile = createLogFile();
}
