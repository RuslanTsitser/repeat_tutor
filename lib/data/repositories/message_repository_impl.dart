import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';
import '../../domain/models/message.dart' as model;
import '../../domain/models/message_content_type.dart';
import '../../domain/models/session_language.dart';
import '../../domain/repositories/message_repository.dart';

/// Реализация репозитория для работы с сообщениями
class MessageRepositoryImpl implements MessageRepository {
  MessageRepositoryImpl(this._database);
  final AppDatabase _database;

  @override
  Future<List<model.Message>> getMessagesByChatId(String chatId) async {
    final messageRows = await _database.messageDao.getMessagesByChatId(chatId);
    return messageRows.map((row) => _mapToDomainModel(row)).toList();
  }

  @override
  Future<model.Message?> getMessageById(String id) async {
    final messageRow = await _database.messageDao.getMessageById(id);
    return messageRow != null ? _mapToDomainModel(messageRow) : null;
  }

  @override
  Future<model.Message> addMessage(model.Message message) async {
    final messageCompanion = MessagesCompanion.insert(
      id: message.id,
      message: message.text,
      isMe: message.isMe,
      time: message.time,
      chatId: message.chatId,
      contentType: Value(message.contentType.value),
      audioPath: Value(message.audioPath),
      transcription: Value(message.transcription),
      corrections: Value(message.corrections),
      language: Value(message.language?.value),
      createdAt: Value(message.createdAt),
    );

    await _database.messageDao.insertMessage(messageCompanion);
    return message;
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    await _database.messageDao.deleteMessage(messageId);
  }

  @override
  Future<void> clearMessages(String chatId) async {
    await _database.messageDao.clearMessages(chatId);
  }

  @override
  Future<model.Message> updateMessage(model.Message message) async {
    final messageCompanion = MessagesCompanion(
      id: Value(message.id),
      message: Value(message.text),
      isMe: Value(message.isMe),
      time: Value(message.time),
      chatId: Value(message.chatId),
      contentType: Value(message.contentType.value),
      audioPath: Value(message.audioPath),
      transcription: Value(message.transcription),
      corrections: Value(message.corrections),
      language: Value(message.language?.value),
      createdAt: Value(message.createdAt),
    );

    await _database.messageDao.updateMessage(messageCompanion);
    return message;
  }

  /// Преобразование модели базы данных в доменную модель
  model.Message _mapToDomainModel(Message messageData) {
    return model.Message(
      id: messageData.id,
      text: messageData.message,
      isMe: messageData.isMe,
      time: messageData.time,
      chatId: messageData.chatId,
      contentType: MessageContentType.fromValue(messageData.contentType),
      audioPath: messageData.audioPath,
      transcription: messageData.transcription,
      corrections: messageData.corrections,
      language: messageData.language != null
          ? SessionLanguage.fromValue(messageData.language!)
          : null,
      createdAt: messageData.createdAt,
    );
  }
}
