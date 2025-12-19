import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/chats/use_case/add_message_use_case.dart';
import '../features/chats/use_case/create_chat_use_case.dart';
import '../features/chats/use_case/delete_chat_use_case.dart';
import '../features/chats/use_case/open_chat_use_case.dart';
import 'core.dart';
import 'repositories.dart';
import 'state_managers.dart';

final openChatUseCaseProvider = Provider((ref) {
  return OpenChatUseCase(
    chatRepository: ref.watch(chatRepositoryProvider),
    messageNotifier: ref.watch(messageProvider),
    appRouter: ref.watch(routerProvider),
  );
});

final createChatUseCaseProvider = Provider((ref) {
  return CreateChatUseCase(
    chatRepository: ref.watch(chatRepositoryProvider),
    router: ref.watch(routerProvider),
  );
});

final deleteChatUseCaseProvider = Provider((ref) {
  return DeleteChatUseCase(
    chatRepository: ref.watch(chatRepositoryProvider),
  );
});

final addMessageUseCaseProvider = Provider((ref) {
  return AddMessageUseCase(
    chatRepository: ref.watch(chatRepositoryProvider),
    messageNotifier: ref.watch(messageProvider),
    speechRecognizer: ref.watch(speechRecognizerProvider),
    audioService: ref.watch(audioServiceProvider),
    gptService: ref.watch(gptServiceProvider),
  );
});
