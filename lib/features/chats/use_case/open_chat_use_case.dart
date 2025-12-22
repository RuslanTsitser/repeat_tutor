import 'dart:async';

import '../../../core/domain/models/chat.dart';
import '../../../core/domain/repositories/chat_repository.dart';
import '../../../core/localization/generated/l10n.dart';
import '../../../core/router/router.dart';
import '../logic/chat_notifier.dart';
import 'add_message_use_case.dart';

class OpenChatUseCase {
  const OpenChatUseCase({
    required this.chatRepository,
    required this.messageNotifier,
    required this.appRouter,
    required this.addMessageUseCase,
    required this.l10n,
  });
  final ChatRepository chatRepository;
  final ChatNotifier messageNotifier;
  final AppRouter appRouter;
  final AddMessageUseCase addMessageUseCase;
  final S l10n;

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
    if (messages.isEmpty) {
      await addMessageUseCase.addMessage(l10n.hello);
    }
  }
}
