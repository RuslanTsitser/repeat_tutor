import '../../../presentation/notifiers/chat_notifier.dart';
import '../../repositories/chat_repository.dart';

class GetChatsUseCase {
  const GetChatsUseCase({
    required this.chatRepository,
    required this.chatNotifier,
  });
  final ChatRepository chatRepository;
  final ChatNotifier chatNotifier;

  Future<void> execute() async {
    if (chatNotifier.state.isLoading) return;
    chatNotifier.unsubscribeFromChats();
    chatNotifier.subscribeToChats(chatRepository.getChatsStream());
    try {
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          isLoading: true,
          error: null,
        ),
      );
      final chats = await chatRepository.getChats();
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          chats: chats,
          error: null,
        ),
      );
    } on Exception catch (e) {
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          error: e.toString(),
        ),
      );
    } finally {
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          isLoading: false,
        ),
      );
    }
  }
}
