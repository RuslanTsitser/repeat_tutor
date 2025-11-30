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
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]))
        .get();
  }

  /// Добавить новое сообщение
  Future<void> insertMessage({
    required String messageId,
    required String message,
    required bool isMe,
    required String chatId,
    required String audioPath,
  }) {
    final now = DateTime.now();
    return into(messages).insert(
      MessagesCompanion(
        messageId: Value(messageId),
        createdAt: Value(now),
        message: Value(message),
        isMe: Value(isMe),
        chatId: Value(chatId),
        audioPath: Value(audioPath),
      ),
    );
  }

  /// Обновить сообщение
  Future<void> updateMessage({
    required String messageId,
    required String message,
    required bool isMe,
    required String chatId,
    required String audioPath,
  }) {
    return (update(
      messages,
    )..where((tbl) => tbl.messageId.equals(messageId))).write(
      MessagesCompanion(
        messageId: Value(messageId),
        message: Value(message),
        isMe: Value(isMe),
        chatId: Value(chatId),
        audioPath: Value(audioPath),
      ),
    );
  }

  /// Удалить сообщение
  Future<void> deleteMessage(String messageId) {
    return (delete(
      messages,
    )..where((tbl) => tbl.messageId.equals(messageId))).go();
  }

  /// Очистить все сообщения в чате
  Future<void> clearMessages(String chatId) {
    return (delete(messages)..where((tbl) => tbl.chatId.equals(chatId))).go();
  }
}
