import '../models/chat.dart';

/// Интерфейс репозитория для работы с чатами
abstract interface class ChatRepository {
  /// Получить список всех чатов
  Future<List<Chat>> getChats();

  /// Создать новый чат
  Future<void> createChat({
    required String language,
    required String level,
    required String topic,
  });

  /// Удалить чат
  Future<void> deleteChat(int chatId);

  /// Получить поток всех чатов
  Stream<List<Chat>> getChatsStream();
}
