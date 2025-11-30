import '../repositories/chat_repository.dart';

/// Use Case для удаления чата
class DeleteChatUseCase {
  const DeleteChatUseCase({
    required this.repository,
  });

  final ChatRepository repository;

  Future<void> execute(String chatId) async {
    await repository.deleteChat(chatId);
  }
}

