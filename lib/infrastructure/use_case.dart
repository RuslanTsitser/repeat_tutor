import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/chats/use_case/add_message_use_case.dart';
import '../features/chats/use_case/create_chat_use_case.dart';
import '../features/chats/use_case/delete_chat_use_case.dart';
import '../features/home/use_case/initialize_use_case.dart';
import '../features/home/use_case/open_screen_use_case.dart';
import '../features/onboarding/use_case/open_chat_after_onboarding_use_case.dart';
import '../features/paywall/use_case/purchase_use_case.dart';
import '../features/profile/use_case/profile_settings_use_case.dart';
import '../features/realtime_call/use_case/start_realtime_call_use_case.dart';

final createChatUseCaseProvider = Provider((ref) {
  return CreateChatUseCase(ref: ref);
});

final deleteChatUseCaseProvider = Provider((ref) {
  return DeleteChatUseCase(ref: ref);
});

final addMessageUseCaseProvider = Provider((ref) {
  return AddMessageUseCase(ref: ref);
});

final startRealtimeCallUseCaseProvider = Provider((ref) {
  return StartRealtimeCallUseCase(ref: ref);
});

final purchaseUseCaseProvider = Provider((ref) {
  return PurchaseUseCase(ref: ref);
});

final openScreenUseCaseProvider = Provider((ref) {
  return OpenScreenUseCase(ref: ref);
});

final initializeUseCaseProvider = Provider((ref) {
  return InitializeUseCase(ref: ref);
});

final profileSettingsUseCaseProvider = Provider((ref) {
  return ProfileSettingsUseCase(ref: ref);
});

final openChatAfterOnboardingUseCaseProvider = Provider((ref) {
  return OpenChatAfterOnboardingUseCase(ref: ref);
});
