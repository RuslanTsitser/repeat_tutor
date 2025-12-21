import '../../database/app_database.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../domain/enums/language.dart';
import '../../domain/models/chat.dart';

abstract class ChatDbMappers {
  static Chat toDomain(
    ChatDb chat, {
    List<MessageDb>? messages,
  }) {
    final message = messages?.isNotEmpty ?? false ? messages!.last : null;
    final lastMessage = message != null
        ? LastMessage(
            text: message.gptResponseId != null
                ? message.assistantMessage ?? message.message
                : message.message,
            id: message.messageId.toString(),
          )
        : null;
    return Chat(
      chatId: chat.chatId,
      topic: chat.topic,
      chatLanguage: Language.fromLanguage(chat.language)!,
      level: DifficultyLevel.fromValue(chat.level)!,
      teacherLanguage: Language.fromLanguage(chat.teacherLanguage)!,
      createdAt: chat.createdAt,
      lastMessage: lastMessage,
    );
  }

  static ChatDb toDb(Chat chat) {
    return ChatDb(
      chatId: chat.chatId,
      topic: chat.topic,
      language: chat.chatLanguage.value,
      level: chat.level.value,
      teacherLanguage: chat.teacherLanguage.value,
      createdAt: chat.createdAt,
    );
  }
}
