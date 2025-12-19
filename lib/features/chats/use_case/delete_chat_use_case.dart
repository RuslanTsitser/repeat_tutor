import '../../../core/domain/repositories/chat_repository.dart';

class DeleteChatUseCase {
  const DeleteChatUseCase({
    required this.chatRepository,
  });
  final ChatRepository chatRepository;

  Future<void> execute(int chatId) async {
    await chatRepository.deleteChat(chatId);
  }
}
