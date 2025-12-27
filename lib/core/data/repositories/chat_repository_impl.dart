import '../../database/app_database.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../domain/enums/language.dart';
import '../../domain/models/chat.dart' as model;
import '../../domain/models/message.dart' as model;
import '../../domain/repositories/chat_repository.dart';
import '../mappers/chat_db_mappers.dart';
import '../mappers/message_db_mappers.dart';

/// Реализация репозитория для работы с чатами
class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._database);
  final AppDatabase _database;

  @override
  Future<List<model.Chat>> getChats() async {
    final chatRows = await _database.chatDao.getAllChats();
    final result = <model.Chat>[];
    for (final chatRow in chatRows) {
      final lastMessageRow = await _database.messageDao.getChatsLastMessage(
        chatRow.chatId,
      );
      if (lastMessageRow != null) {
        result.add(
          ChatDbMappers.toDomain(
            chatRow,
            messages: [lastMessageRow],
          ),
        );
      } else {
        result.add(ChatDbMappers.toDomain(chatRow));
      }
    }
    return result;
  }

  @override
  Future<model.Chat> createChat({
    required Language language,
    required DifficultyLevel level,
    required String topic,
    required Language teacherLanguage,
  }) async {
    final chatId = await _database.chatDao.insertChat(
      language: language.value,
      level: level.value,
      topic: topic,
      teacherLanguage: teacherLanguage.value,
    );
    final chatRow = await _database.chatDao.getChatById(chatId);
    if (chatRow == null) {
      throw Exception('Chat not found');
    }
    return ChatDbMappers.toDomain(chatRow);
  }

  @override
  Future<void> deleteChat(int chatId) async {
    await _database.chatDao.deleteChat(chatId);
  }

  @override
  Stream<List<model.Chat>> getChatsStream() {
    return _database.chatDao.getChatsStream().map(
      (rows) => rows.map(ChatDbMappers.toDomain).toList(),
    );
  }

  @override
  Future<List<model.Message>> getMessages(int chatId) async {
    final messageRows = await _database.messageDao.getMessagesByChatId(chatId);
    return messageRows.map(MessageDbMappers.toDomain).toList();
  }

  @override
  Stream<model.Message?> getLastMessageStream() {
    return _database.messageDao.getLastMessageStream().map(
      (row) => row != null ? MessageDbMappers.toDomain(row) : null,
    );
  }

  @override
  Stream<List<model.Message>> getMessagesStream(int chatId) {
    return _database.messageDao
        .getMessagesStream(chatId)
        .map(
          (rows) => rows.map(MessageDbMappers.toDomain).toList(),
        );
  }

  @override
  Future<int> addMessage({
    required String message,
    required String? gptResponseId,
    required model.Chat chat,
    String? caseType,
    String? assistantMessage,
    String? correctionOriginal,
    String? correctionCorrectedMarkdown,
    String? correctionExplanation,
    String? suggestedTranslationUserMeaning,
    String? suggestedTranslationTranslation,
    String? userQuestionAnswerQuestion,
    String? userQuestionAnswerAnswer,
    String? conversationContinue,
  }) async {
    return _database.messageDao.insertMessage(
      message: message,
      gptResponseId: gptResponseId,
      chatId: chat.chatId,
      caseType: caseType,
      assistantMessage: assistantMessage,
      correctionOriginal: correctionOriginal,
      correctionCorrectedMarkdown: correctionCorrectedMarkdown,
      correctionExplanation: correctionExplanation,
      suggestedTranslationUserMeaning: suggestedTranslationUserMeaning,
      suggestedTranslationTranslation: suggestedTranslationTranslation,
      userQuestionAnswerQuestion: userQuestionAnswerQuestion,
      userQuestionAnswerAnswer: userQuestionAnswerAnswer,
      conversationContinue: conversationContinue,
    );
  }

  @override
  Future<void> deleteMessage(int messageId) async {
    await _database.messageDao.deleteMessage(messageId);
  }

  @override
  Future<void> updateMessage({
    required int messageId,
    required String message,
    required String? gptResponseId,
    required model.Chat chat,
    String? caseType,
    String? assistantMessage,
    String? correctionOriginal,
    String? correctionCorrectedMarkdown,
    String? correctionExplanation,
    String? suggestedTranslationUserMeaning,
    String? suggestedTranslationTranslation,
    String? userQuestionAnswerQuestion,
    String? userQuestionAnswerAnswer,
    String? conversationContinue,
  }) {
    return _database.messageDao.updateMessage(
      messageId: messageId,
      message: message,
      gptResponseId: gptResponseId,
      chatId: chat.chatId,
      caseType: caseType,
      assistantMessage: assistantMessage,
      correctionOriginal: correctionOriginal,
      correctionCorrectedMarkdown: correctionCorrectedMarkdown,
      correctionExplanation: correctionExplanation,
      suggestedTranslationUserMeaning: suggestedTranslationUserMeaning,
      suggestedTranslationTranslation: suggestedTranslationTranslation,
      userQuestionAnswerQuestion: userQuestionAnswerQuestion,
      userQuestionAnswerAnswer: userQuestionAnswerAnswer,
      conversationContinue: conversationContinue,
    );
  }
}
