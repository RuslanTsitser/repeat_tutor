import '../repositories/chat_repository.dart';

/// Use Case для обновления последнего сообщения в чате
class UpdateChatLastMessageUseCase {
  const UpdateChatLastMessageUseCase({
    required this.repository,
  });

  final ChatRepository repository;

  Future<void> execute({
    required String chatId,
    required String message,
    required String time,
  }) async {
    await repository.updateLastMessage(chatId, message, time);
  }
}

