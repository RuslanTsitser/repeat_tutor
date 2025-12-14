import '../../core/database/app_database.dart' as db;
import '../../domain/models/message.dart' as domain;

abstract class MessageDbMappers {
  static domain.Message toDomain(db.Message message) {
    return domain.Message(
      id: message.messageId,
      gptResponseId: message.gptResponseId,
      text: message.message,
      chatId: message.chatId,
      audioPath: message.audioPath,
      createdAt: message.createdAt,
    );
  }

  static db.Message toDb(domain.Message message) {
    return db.Message(
      messageId: message.id,
      gptResponseId: message.gptResponseId,
      message: message.text,
      chatId: message.chatId,
      audioPath: message.audioPath,
      createdAt: message.createdAt,
    );
  }
}
