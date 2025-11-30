import '../../core/database/app_database.dart';
import '../../domain/models/message.dart' as model;
import '../../domain/repositories/message_repository.dart';
import '../mappers/message_db_mappers.dart';

/// Реализация репозитория для работы с сообщениями
class MessageRepositoryImpl implements MessageRepository {
  MessageRepositoryImpl(this._database);
  final AppDatabase _database;

  @override
  Future<List<model.Message>> getMessagesByChatId(int chatId) async {
    final messageRows = await _database.messageDao.getMessagesByChatId(chatId);
    return messageRows.map(MessageDbMappers.toDomain).toList();
  }

  @override
  Future<void> addMessage({
    required int chatId,
    required bool isMe,
    required String message,
    String? audioPath,
  }) async {
    await _database.messageDao.insertMessage(
      message: message,
      isMe: isMe,
      chatId: chatId,
      audioPath: audioPath,
    );
  }

  @override
  Future<void> deleteMessage(int messageId) async {
    await _database.messageDao.deleteMessage(messageId);
  }

  @override
  Stream<List<model.Message>> getMessagesStream(int chatId) {
    return _database.messageDao
        .getMessagesStream(chatId)
        .map(
          (rows) => rows.map(MessageDbMappers.toDomain).toList(),
        );
  }
}
