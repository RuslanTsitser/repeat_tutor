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
  Future<Chat?> getChatById(int chatId) async {
    final result = await (select(
      chats,
    )..where((tbl) => tbl.chatId.equals(chatId))).getSingleOrNull();
    return result;
  }

  /// Создать новый чат
  Future<void> insertChat({
    required String language,
    required String level,
    required String topic,
  }) => into(chats).insert(
    ChatsCompanion(
      language: Value(language),
      level: Value(level),
      topic: Value(topic),
    ),
  );

  /// Удалить чат
  Future<void> deleteChat(int chatId) {
    return (delete(chats)..where((tbl) => tbl.chatId.equals(chatId))).go();
  }

  Stream<List<Chat>> getChatsStream() {
    return select(chats).watch();
  }
}
