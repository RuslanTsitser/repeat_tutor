import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'message_dao.g.dart';

/// DAO для работы с сообщениями
@DriftAccessor(tables: [Messages])
class MessageDao extends DatabaseAccessor<AppDatabase> with _$MessageDaoMixin {
  MessageDao(super.db);

  /// Получить все сообщения для чата
  Future<List<Message>> getMessagesByChatId(String chatId) {
    return (select(messages)
          ..where((tbl) => tbl.chatId.equals(chatId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.time)]))
        .get();
  }

  /// Получить сообщение по ID
  Future<Message?> getMessageById(String id) {
    return (select(
      messages,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Добавить новое сообщение
  Future<void> insertMessage(MessagesCompanion message) =>
      into(messages).insert(message);

  /// Обновить сообщение
  Future<void> updateMessage(MessagesCompanion message) {
    return (update(
      messages,
    )..where((tbl) => tbl.id.equals(message.id.value))).write(message);
  }

  /// Удалить сообщение
  Future<void> deleteMessage(String id) {
    return (delete(messages)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Очистить все сообщения в чате
  Future<void> clearMessages(String chatId) {
    return (delete(messages)..where((tbl) => tbl.chatId.equals(chatId))).go();
  }
}
