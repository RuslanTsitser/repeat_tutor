import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/chat.dart';
import '../../../core/router/router.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/repositories.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';

class OpenScreenUseCase {
  const OpenScreenUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<void> openChat(Chat chat) async {
    final appRouter = ref.read(routerProvider);
    final chatRepository = ref.read(chatRepositoryProvider);
    final messageNotifier = ref.read(chatNotifierProvider);
    final addMessageUseCase = ref.read(addMessageUseCaseProvider);
    final l10n = ref.read(l10nProvider);

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
