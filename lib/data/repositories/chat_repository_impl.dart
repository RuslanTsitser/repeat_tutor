import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';
import '../../domain/models/chat.dart' as model;
import '../../domain/repositories/chat_repository.dart';

/// Реализация репозитория для работы с чатами
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._database);
  final AppDatabase _database;

  @override
  Future<List<model.Chat>> getChats() async {
    print('ChatRepositoryImpl: Загружаем чаты из базы данных');
    final chatRows = await _database.chatDao.getAllChats();
    print('ChatRepositoryImpl: Получено ${chatRows.length} чатов из базы данных');
    return chatRows.map((row) => _mapToDomainModel(row)).toList();
  }

  @override
  Future<model.Chat?> getChatById(String id) async {
    final chatRow = await _database.chatDao.getChatById(id);
    return chatRow != null ? _mapToDomainModel(chatRow) : null;
  }

  @override
  Future<void> updateLastMessage(
    String chatId,
    String message,
    String time,
  ) async {
    await _database.chatDao.updateLastMessage(chatId, message, time);
  }

  @override
  Future<void> markAsRead(String chatId) async {
    await _database.chatDao.markAsRead(chatId);
  }

  @override
  Future<model.Chat> createChat(model.Chat chat) async {
    final chatCompanion = ChatsCompanion.insert(
      id: chat.id,
      name: chat.name,
      lastMessage: chat.lastMessage,
      time: chat.time,
      unreadCount: Value(chat.unreadCount),
      avatarUrl: Value(chat.avatarUrl),
    );

    await _database.chatDao.insertChat(chatCompanion);
    return chat;
  }

  @override
  Future<void> deleteChat(String chatId) async {
    await _database.chatDao.deleteChat(chatId);
  }

  /// Преобразование модели базы данных в доменную модель
  model.Chat _mapToDomainModel(Chat chatData) {
    return model.Chat(
      id: chatData.id,
      name: chatData.name,
      lastMessage: chatData.lastMessage,
      time: chatData.time,
      unreadCount: chatData.unreadCount,
      avatarUrl: chatData.avatarUrl,
    );
  }
}
