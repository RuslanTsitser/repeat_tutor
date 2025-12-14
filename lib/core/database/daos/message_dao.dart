import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'message_dao.g.dart';

/// DAO для работы с сообщениями
@DriftAccessor(tables: [Messages])
class MessageDao extends DatabaseAccessor<AppDatabase> with _$MessageDaoMixin {
  MessageDao(super.db);

  /// Получить все сообщения для чата
  Future<List<Message>> getMessagesByChatId(int chatId) {
    return (select(messages)
          ..where((tbl) => tbl.chatId.equals(chatId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]))
        .get();
  }

  /// Добавить новое сообщение
  Future<void> insertMessage({
    required String message,
    required String? gptResponseId,
    required int chatId,
    String? audioPath,
  }) => into(messages).insert(
    MessagesCompanion(
      message: Value(message),
      gptResponseId: Value(gptResponseId),
      chatId: Value(chatId),
      audioPath: Value(audioPath),
    ),
  );

  /// Удалить сообщение
  Future<void> deleteMessage(int messageId) {
    return (delete(
      messages,
    )..where((tbl) => tbl.messageId.equals(messageId))).go();
  }

  /// Очистить все сообщения в чате
  Future<void> clearMessages(int chatId) {
    return (delete(messages)..where((tbl) => tbl.chatId.equals(chatId))).go();
  }

  Stream<List<Message>> getMessagesStream(int chatId) {
    return (select(messages)
          ..where((tbl) => tbl.chatId.equals(chatId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]))
        .watch();
  }
}
