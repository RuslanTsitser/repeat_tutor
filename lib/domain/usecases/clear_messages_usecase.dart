import '../repositories/message_repository.dart';

/// Use Case для очистки всех сообщений в чате
class ClearMessagesUseCase {
  const ClearMessagesUseCase({
    required this.repository,
  });

  final MessageRepository repository;

  Future<void> execute(String chatId) async {
    await repository.clearMessages(chatId);
  }
}

