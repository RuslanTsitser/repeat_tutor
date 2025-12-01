// Chat providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/notifiers/chat_notifier.dart';
import '../presentation/notifiers/create_realtime_session_notifier.dart';
import '../presentation/notifiers/message_notifier.dart';
import '../presentation/notifiers/realtime_call_notifier.dart';
import '../presentation/notifiers/realtime_session_notifier.dart';

final chatProvider = ChangeNotifierProvider((ref) {
  return ChatNotifier();
});

// Message providers
final messageProvider = ChangeNotifierProvider((ref) {
  return MessageNotifier();
});

/// Провайдер для списка сессий
final realtimeSessionListProvider = ChangeNotifierProvider((ref) {
  return RealtimeSessionListNotifier();
});

/// Провайдер для формы создания сессии
final createRealtimeSessionProvider = ChangeNotifierProvider.autoDispose((ref) {
  return CreateRealtimeSessionNotifier();
});

/// Провайдер для звонка (family для разных сессий)
final realtimeCallProvider = ChangeNotifierProvider((ref) {
  return RealtimeCallNotifier();
});
