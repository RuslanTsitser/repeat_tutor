import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ab_test/enum/placement_type.dart';
import '../../../core/domain/enums/language.dart';
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
      final chatLocale = chat.chatLanguage;
      final firstMessage = switch (chatLocale) {
        Language.japanese => 'こんにちは',
        Language.russian => 'Привет',
        Language.english => 'Hello',
        Language.french => 'Bonjour',
        Language.german => 'Hallo',
        Language.spanish => 'Hola',
        Language.portugueseEuropean => 'Olá',
        Language.portugueseBrazilian => 'Olá',
        Language.italian => 'Ciao',
      };
      await addMessageUseCase.addMessage(firstMessage, addFirstMessage: false);
    }
  }

  Future<void> openProPaywall() async {
    final appRouter = ref.read(routerProvider);
    // TODO: change to the correct placement
    appRouter.push<void>(
      PaywallRoute(
        placement: PlacementType.placementStart,
      ),
    );
  }
}
