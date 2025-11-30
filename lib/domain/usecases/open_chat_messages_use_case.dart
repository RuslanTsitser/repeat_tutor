import '../../core/router/router.dart';
import '../../presentation/notifiers/message_notifier.dart';
import '../repositories/chat_repository.dart';
import '../repositories/message_repository.dart';

class OpenChatMessagesUseCase {
  const OpenChatMessagesUseCase({
    required this.chatRepository,
    required this.messageRepository,
    required this.messageNotifier,
    required this.appRouter,
  });
  final ChatRepository chatRepository;
  final MessageRepository messageRepository;
  final MessageNotifier messageNotifier;
  final AppRouter appRouter;

  Future<void> execute(int chatId) async {
    if (messageNotifier.state.isLoading) return;
    try {
      messageNotifier.setState(
        messageNotifier.state.copyWith(
          chatId: chatId,
          isLoading: true,
        ),
      );
      final messages = await messageRepository.getMessagesByChatId(chatId);
      messageNotifier.setState(
        messageNotifier.state.copyWith(
          messages: messages,
          error: null,
        ),
      );
      await appRouter.push(const ChatRoute());
    } catch (e) {
      messageNotifier.setState(
        messageNotifier.state.copyWith(
          error: e.toString(),
        ),
      );
    } finally {
      messageNotifier.setState(
        messageNotifier.state.copyWith(
          isLoading: false,
        ),
      );
    }
  }
}
