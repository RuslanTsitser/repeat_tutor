import '../../database/app_database.dart';
import '../../domain/models/chat.dart' as model;
import '../../domain/models/message.dart' as model;
import '../../domain/repositories/chat_repository.dart';
import '../mappers/chat_db_mappers.dart';
import '../mappers/message_db_mappers.dart';

/// Реализация репозитория для работы с чатами
class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._database);
  final AppDatabase _database;

  @override
  Future<List<model.Chat>> getChats() async {
    final chatRows = await _database.chatDao.getAllChats();
    return chatRows.map(ChatDbMappers.toDomain).toList();
  }

  @override
  Future<void> createChat({
    required String language,
    required String level,
    required String topic,
    required String teacherLanguage,
  }) async {
    await _database.chatDao.insertChat(
      language: language,
      level: level,
      topic: topic,
      teacherLanguage: teacherLanguage,
    );
  }

  @override
  Future<void> deleteChat(int chatId) async {
    await _database.chatDao.deleteChat(chatId);
  }

  @override
  Stream<List<model.Chat>> getChatsStream() {
    return _database.chatDao.getChatsStream().map(
      (rows) => rows.map(ChatDbMappers.toDomain).toList(),
    );
  }

  @override
  Future<List<model.Message>> getMessages(int chatId) async {
    final messageRows = await _database.messageDao.getMessagesByChatId(chatId);
    return messageRows.map(MessageDbMappers.toDomain).toList();
  }

  @override
  Stream<List<model.Message>> getMessagesStream(int chatId) {
    return _database.messageDao
        .getMessagesStream(chatId)
        .map(
          (rows) => rows.map(MessageDbMappers.toDomain).toList(),
        );
  }

  @override
  Future<void> addMessage({
    required String message,
    required String? gptResponseId,
    required model.Chat chat,
  }) async {
    await _database.messageDao.insertMessage(
      message: message,
      gptResponseId: gptResponseId,
      chatId: chat.chatId,
    );
  }

  @override
  Future<void> deleteMessage(int messageId) async {
    await _database.messageDao.deleteMessage(messageId);
  }
}
