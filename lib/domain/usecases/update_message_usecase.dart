import '../models/message.dart';
import '../repositories/message_repository.dart';

/// Use Case для обновления сообщения
class UpdateMessageUseCase {
  const UpdateMessageUseCase({
    required this.repository,
  });

  final MessageRepository repository;

  Future<Message> execute(Message message) async {
    return await repository.updateMessage(message);
  }
}

