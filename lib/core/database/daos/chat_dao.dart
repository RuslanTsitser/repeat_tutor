import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'chat_dao.g.dart';

/// DAO для работы с чатами
@DriftAccessor(tables: [Chats])
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  /// Получить все чаты
  Future<List<Chat>> getAllChats() => select(chats).get();

  /// Получить чат по ID
  Future<Chat?> getChatById(String id) {
    return (select(
      chats,
    )..where((tbl) => tbl.chatId.equals(id))).getSingleOrNull();
  }

  /// Создать новый чат
  Future<void> insertChat({
    required String chatId,
    required String language,
    required String level,
    required String topic,
  }) {
    final now = DateTime.now();
    return into(chats).insert(
      ChatsCompanion(
        chatId: Value(chatId),
        createdAt: Value(now),
        language: Value(language),
        level: Value(level),
        topic: Value(topic),
      ),
    );
  }

  /// Обновить чат
  Future<void> updateChat({
    required String chatId,
    required String language,
    required String level,
    required String topic,
  }) {
    return (update(chats)..where((tbl) => tbl.chatId.equals(chatId))).write(
      ChatsCompanion(
        chatId: Value(chatId),
        language: Value(language),
        level: Value(level),
        topic: Value(topic),
      ),
    );
  }

  /// Удалить чат
  Future<void> deleteChat(String chatId) {
    return (delete(chats)..where((tbl) => tbl.chatId.equals(chatId))).go();
  }
}
