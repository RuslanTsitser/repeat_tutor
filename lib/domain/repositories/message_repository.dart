import '../models/message.dart';

/// Интерфейс репозитория для работы с сообщениями
abstract interface class MessageRepository {
  /// Получить все сообщения для чата
  Future<List<Message>> getMessagesByChatId(String chatId);

  /// Получить сообщение по ID
  Future<Message?> getMessageById(String id);

  /// Добавить новое сообщение
  Future<Message> addMessage(Message message);

  /// Удалить сообщение
  Future<void> deleteMessage(String messageId);

  /// Очистить все сообщения в чате
  Future<void> clearMessages(String chatId);

  /// Обновить сообщение
  Future<Message> updateMessage(Message message);
}
