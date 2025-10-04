import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../logging/app_logger.dart';

/// Класс для работы с директориями приложения.
abstract final class AppDirectory {
  static Directory? _appDocsDirectory;
  static Directory? _appCacheDirectory;

  /// Инициализирует директории приложения. Обязательно нужно вызывать метод перед использованием класса.
  static Future<void> initialize() async {
    _appDocsDirectory = await getApplicationDocumentsDirectory();
    _appCacheDirectory = await getTemporaryDirectory();
    manageLogFiles();
  }

  /// Директория для хранения документов приложения.
  static Directory get appDocsDirectory => _appDocsDirectory!;

  /// Директория для хранения кэша приложения.
  static Directory get appCacheDirectory => _appCacheDirectory!;

  /// Директория для хранения логов приложения.
  static Directory get logsDirectory {
    final dir = Directory('${appDocsDirectory.path}/logs');
    if (!dir.existsSync()) {
      dir.createSync();
    }
    return dir;
  }

  static File get appDbFile {
    final file = File(p.join(_appDocsDirectory!.path, 'repeat_tutor.sqlite'));
    return file;
  }

  /// Удаляет файлы логов, которые не обновлялись в течение двух дней.
  static void manageLogFiles() {
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
}
