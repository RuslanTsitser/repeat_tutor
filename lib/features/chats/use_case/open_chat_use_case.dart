import 'dart:async';

import '../../../core/domain/models/chat.dart';
import '../../../core/domain/repositories/chat_repository.dart';
import '../../../core/router/router.dart';
import '../logic/chat_notifier.dart';

class OpenChatUseCase {
  const OpenChatUseCase({
    required this.chatRepository,
    required this.messageNotifier,
    required this.appRouter,
  });
  final ChatRepository chatRepository;
  final ChatNotifier messageNotifier;
  final AppRouter appRouter;

  Future<void> execute(Chat chat) async {
    messageNotifier.unsubscribeFromMessages();
    messageNotifier.subscribeToMessages(
      chatRepository.getMessagesStream(chat.chatId),
    );
    messageNotifier.setState(
      messageNotifier.state.copyWith(
        chat: chat,
        isLoading: true,
        error: null,
      ),
    );
    appRouter.push<void>(const ChatRoute());

    final messages = await chatRepository.getMessages(chat.chatId);
    messageNotifier.setState(
      messageNotifier.state.copyWith(
        chat: chat,
        messages: messages,
        isLoading: false,
        error: null,
      ),
    );
  }
}
