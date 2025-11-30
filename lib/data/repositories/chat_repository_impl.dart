import '../../core/database/app_database.dart';
import '../../domain/models/chat.dart' as model;
import '../../domain/repositories/chat_repository.dart';
import '../mappers/chat_db_mappers.dart';

/// Реализация репозитория для работы с чатами
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._database);
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
  }) async {
    await _database.chatDao.insertChat(
      language: language,
      level: level,
      topic: topic,
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
}
