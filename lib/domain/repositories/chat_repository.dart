import '../models/chat.dart';

/// Интерфейс репозитория для работы с чатами
abstract interface class ChatRepository {
  /// Получить список всех чатов
  Future<List<Chat>> getChats();

  /// Получить чат по ID
  Future<Chat?> getChatById(String id);

  /// Обновить последнее сообщение в чате
  Future<void> updateLastMessage(String chatId, String message, String time);

  /// Отметить чат как прочитанный
  Future<void> markAsRead(String chatId);

  /// Создать новый чат
  Future<Chat> createChat(Chat chat);

  /// Удалить чат
  Future<void> deleteChat(String chatId);
}
