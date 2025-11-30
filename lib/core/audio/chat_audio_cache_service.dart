import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Сохраняет аудио-файлы сообщений локально
class ChatAudioCacheService {
  Future<String> saveBase64Audio({
    required String chatId,
    required String messageId,
    required String base64Data,
    String extension = 'wav',
  }) async {
    final directory = await _ensureChatDirectory(chatId);
    final file = File(p.join(directory.path, '$messageId.$extension'));
    final bytes = base64Decode(base64Data);
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  Future<String> copyLocalFile({
    required String chatId,
    required String messageId,
    required String sourcePath,
  }) async {
    final directory = await _ensureChatDirectory(chatId);
    final sourceFile = File(sourcePath);
    final extension = p.extension(sourcePath).isEmpty
        ? '.m4a'
        : p.extension(sourcePath);
    final target = File(p.join(directory.path, '$messageId$extension'));
    if (await target.exists()) {
      await target.delete();
    }
    await sourceFile.copy(target.path);
    return target.path;
  }

  Future<Directory> _ensureChatDirectory(String chatId) async {
    final docs = await getApplicationDocumentsDirectory();
    final directory = Directory(p.join(docs.path, 'chat_audio', chatId));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }
}
