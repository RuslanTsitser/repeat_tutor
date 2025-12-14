import '../models/chat.dart';
import '../models/message.dart';

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

  /// Получить сообщения для чата
  Future<List<Message>> getMessages(int chatId);

  /// Получить поток всех сообщений для чата
  Stream<List<Message>> getMessagesStream(int chatId);

  /// Добавить новое сообщение
  Future<void> addMessage({
    required String message,
    required String? gptResponseId,
    required Chat chat,
    String? audioPath,
  });
}
