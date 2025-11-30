import '../repositories/chat_repository.dart';

/// Use Case для отметки чата как прочитанного
class MarkChatAsReadUseCase {
  const MarkChatAsReadUseCase({
    required this.repository,
  });

  final ChatRepository repository;

  Future<void> execute(String chatId) async {
    await repository.markAsRead(chatId);
  }
}

