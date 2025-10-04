import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'chat_dao.g.dart';

/// DAO для работы с чатами
@DriftAccessor(tables: [Chats])
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  /// Получить все чаты
  Future<List<Chat>> getAllChats() async {
    print('ChatDao: Выполняем запрос SELECT * FROM chats');
    final result = await select(chats).get();
    print('ChatDao: Получено ${result.length} записей из таблицы chats');
    return result;
  }

  /// Получить чат по ID
  Future<Chat?> getChatById(String id) {
    return (select(chats)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Создать новый чат
  Future<void> insertChat(ChatsCompanion chat) => into(chats).insert(chat);

  /// Обновить чат
  Future<void> updateChat(ChatsCompanion chat) {
    return (update(
      chats,
    )..where((tbl) => tbl.id.equals(chat.id.value))).write(chat);
  }

  /// Удалить чат
  Future<void> deleteChat(String id) {
    return (delete(chats)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Обновить последнее сообщение в чате
  Future<void> updateLastMessage(
    String chatId,
    String message,
    String time,
  ) async {
    // Сначала получаем текущий unreadCount
    final currentChat = await getChatById(chatId);
    if (currentChat != null) {
      await (update(chats)..where((tbl) => tbl.id.equals(chatId))).write(
        ChatsCompanion(
          lastMessage: Value(message),
          time: Value(time),
          unreadCount: Value(currentChat.unreadCount + 1),
        ),
      );
    }
  }

  /// Отметить чат как прочитанный
  Future<void> markAsRead(String chatId) {
    return (update(chats)..where((tbl) => tbl.id.equals(chatId))).write(
      const ChatsCompanion(unreadCount: Value(0)),
    );
  }
}
