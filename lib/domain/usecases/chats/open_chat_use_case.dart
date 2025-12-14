import 'dart:async';

import '../../../core/router/router.dart';
import '../../../presentation/notifiers/message_notifier.dart';
import '../../repositories/chat_repository.dart';

class OpenChatUseCase {
  const OpenChatUseCase({
    required this.chatRepository,
    required this.messageNotifier,
    required this.appRouter,
  });
  final ChatRepository chatRepository;
  final MessageNotifier messageNotifier;
  final AppRouter appRouter;

  Future<void> execute(int chatId) async {
    messageNotifier.unsubscribeFromMessages();
    messageNotifier.subscribeToMessages(
      chatRepository.getMessagesStream(chatId),
    );
    messageNotifier.setState(
      messageNotifier.state.copyWith(
        chatId: chatId,
        isLoading: true,
        error: null,
      ),
    );
    appRouter.push<void>(const ChatRoute());

    final messages = await chatRepository.getMessages(chatId);
    messageNotifier.setState(
      messageNotifier.state.copyWith(
        chatId: chatId,
        messages: messages,
        isLoading: false,
        error: null,
      ),
    );
  }
}
