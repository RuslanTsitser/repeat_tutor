import '../repositories/message_repository.dart';

/// Use Case для удаления сообщения
class DeleteMessageUseCase {
  const DeleteMessageUseCase({
    required this.repository,
  });

  final MessageRepository repository;

  Future<void> execute(String messageId) async {
    await repository.deleteMessage(messageId);
  }
}

