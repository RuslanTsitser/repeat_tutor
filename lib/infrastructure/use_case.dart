import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/chats/use_case/add_message_use_case.dart';
import '../features/chats/use_case/create_chat_use_case.dart';
import '../features/chats/use_case/delete_chat_use_case.dart';
import '../features/home/use_case/initialize_use_case.dart';
import '../features/home/use_case/open_screen_use_case.dart';
import '../features/paywall/use_case/purchase_use_case.dart';
import '../features/realtime_call/use_case/start_realtime_call_use_case.dart';
import 'core.dart';
import 'repositories.dart';
import 'state_managers.dart';

final createChatUseCaseProvider = Provider((ref) {
  return CreateChatUseCase(
    chatRepository: ref.watch(chatRepositoryProvider),
    router: ref.watch(routerProvider),
    profileSettingsNotifier: ref.watch(profileProvider),
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
    chatNotifier: ref.watch(chatNotifierProvider),
    speechRecognizer: ref.watch(speechRecognizerProvider),
    audioService: ref.watch(audioServiceProvider),
    gptService: ref.watch(gptServiceProvider),
  );
});

final startRealtimeCallUseCaseProvider = Provider((ref) {
  return StartRealtimeCallUseCase(
    gptService: ref.watch(gptServiceProvider),
    realtimeWebRTCConnection: ref.watch(realtimeWebRTCConnectionProvider),
    realtimeCallNotifier: ref.watch(realtimeCallProvider),
    sessionsDurationsDao: ref.watch(databaseProvider).sessionsDurationsDao,
  );
});

final purchaseUseCaseProvider = Provider((ref) {
  return PurchaseUseCase(
    abTestService: ref.watch(abTestServiceProvider),
    paywallChangeNotifier: ref.watch(paywallChangeNotifierProvider),
    appRouter: ref.watch(routerProvider),
    profileSettingsNotifier: ref.watch(profileProvider),
  );
});

final openScreenUseCaseProvider = Provider((ref) {
  return OpenScreenUseCase(ref: ref);
});

final initializeUseCaseProvider = Provider((ref) {
  return InitializeUseCase(ref: ref);
});
