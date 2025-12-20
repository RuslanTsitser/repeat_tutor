import '../enums/difficulty_level.dart';
import '../enums/language.dart';
import '../models/chat.dart';
import '../models/message.dart';

/// Интерфейс репозитория для работы с чатами
abstract interface class ChatRepository {
  /// Получить список всех чатов
  Future<List<Chat>> getChats();

  /// Создать новый чат
  Future<void> createChat({
    required Language language,
    required DifficultyLevel level,
    required String topic,
    required Language teacherLanguage,
  });

  /// Удалить чат
  Future<void> deleteChat(int chatId);

  /// Удалить все сообщения для чата
  Future<void> deleteMessage(int messageId);

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
  });
}
