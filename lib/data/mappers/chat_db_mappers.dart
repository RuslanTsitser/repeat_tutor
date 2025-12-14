import '../../core/database/app_database.dart' as db;
import '../../domain/models/chat.dart' as domain;
import '../../domain/models/session_difficulty_level.dart' as domain;
import '../../domain/models/session_language.dart' as domain;

abstract class ChatDbMappers {
  static domain.Chat toDomain(db.Chat chat) {
    return domain.Chat(
      chatId: chat.chatId,
      topic: chat.topic,
      language: domain.SessionLanguage.fromValue(chat.language)!,
      level: domain.SessionDifficultyLevel.fromValue(chat.level)!,
      teacherLanguage: chat.teacherLanguage != null
          ? domain.SessionLanguage.fromValue(chat.teacherLanguage!)
          : null,
      createdAt: chat.createdAt,
    );
  }

  static db.Chat toDb(domain.Chat chat) {
    return db.Chat(
      chatId: chat.chatId,
      topic: chat.topic,
      language: chat.language.value,
      level: chat.level.value,
      teacherLanguage: chat.teacherLanguage?.value,
      createdAt: chat.createdAt,
    );
  }
}
