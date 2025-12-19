import '../../database/app_database.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../domain/enums/language.dart';
import '../../domain/models/chat.dart';

abstract class ChatDbMappers {
  static Chat toDomain(ChatDb chat) {
    return Chat(
      chatId: chat.chatId,
      topic: chat.topic,
      chatLanguage: Language.fromLanguage(chat.language)!,
      level: DifficultyLevel.fromValue(chat.level)!,
      teacherLanguage: Language.fromLanguage(chat.teacherLanguage)!,
      createdAt: chat.createdAt,
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
