import 'dart:async';

import '../../../core/router/router.dart';
import '../../../presentation/notifiers/message_notifier.dart';
import '../../models/chat.dart';
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
