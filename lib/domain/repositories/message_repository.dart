import '../models/message.dart';

/// Интерфейс репозитория для работы с сообщениями
abstract interface class MessageRepository {
  /// Получить все сообщения для чата
  Future<List<Message>> getMessagesByChatId(int chatId);

  /// Добавить новое сообщение
  Future<void> addMessage({
    required int chatId,
    required String message,
    required bool isMe,
    String? audioPath,
  });

  /// Удалить сообщение
  Future<void> deleteMessage(int messageId);

  /// Получить поток всех сообщений для чата
  Stream<List<Message>> getMessagesStream(int chatId);
}
