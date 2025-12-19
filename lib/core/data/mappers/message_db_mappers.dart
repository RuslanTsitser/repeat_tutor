import '../../database/app_database.dart';
import '../../domain/models/message.dart';

abstract class MessageDbMappers {
  static Message toDomain(MessageDb message) {
    return Message(
      id: message.messageId,
      gptResponseId: message.gptResponseId,
      text: message.message,
      chatId: message.chatId,
      createdAt: message.createdAt,
    );
  }

  static MessageDb toDb(Message message) {
    return MessageDb(
      messageId: message.id,
      gptResponseId: message.gptResponseId,
      message: message.text,
      chatId: message.chatId,
      createdAt: message.createdAt,
    );
  }
}
