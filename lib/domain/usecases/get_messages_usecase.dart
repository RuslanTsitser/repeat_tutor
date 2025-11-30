import '../models/message.dart';
import '../repositories/message_repository.dart';

/// Use Case для получения сообщений чата
class GetMessagesUseCase {
  const GetMessagesUseCase({
    required this.repository,
  });

  final MessageRepository repository;

  Future<List<Message>> execute(String chatId) async {
    return await repository.getMessagesByChatId(chatId);
  }
}

