// Chat providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/ab_test/enum/placement_type.dart';
import '../features/chats/logic/chat_list_notifier.dart';
import '../features/chats/logic/chat_notifier.dart';
import '../features/chats/logic/create_chat_notifier.dart';
import '../features/home/logic/home_screen_notifier.dart';
import '../features/onboarding/logic/onboarding_notifier.dart';
import '../features/paywall/logic/paywall_change_notifier.dart';
import '../features/profile/logic/profile_notifier.dart';
import '../features/realtime_call/logic/realtime_call_notifier.dart';
import 'core.dart';
import 'repositories.dart';

final chatListNotifierProvider = ChangeNotifierProvider((ref) {
  return ChatListNotifier(
    chatRepository: ref.watch(chatRepositoryProvider),
  );
});

// Message providers
final chatNotifierProvider = ChangeNotifierProvider((ref) {
  return ChatNotifier();
});

/// Провайдер для списка сессий
final createChatProvider = ChangeNotifierProvider.autoDispose((ref) {
  return CreateChatNotifier();
});

/// Провайдер для звонка (family для разных сессий)
final realtimeCallProvider = ChangeNotifierProvider((ref) {
  return RealtimeCallNotifier(
    realtimeWebRTCConnection: ref.watch(realtimeWebRTCConnectionProvider),
  );
});

/// Провайдер для настроек профиля
final profileProvider = ChangeNotifierProvider((ref) {
  return ProfileNotifier();
});

final paywallChangeNotifierProvider = ChangeNotifierProvider.family((
  ref,
  PlacementType placement,
) {
  return PaywallChangeNotifier(placement: placement);
});

final homeScreenNotifierProvider = ChangeNotifierProvider((ref) {
  return HomeScreenNotifier();
});

final onboardingNotifierProvider = ChangeNotifierProvider((ref) {
  return OnboardingNotifier();
});
