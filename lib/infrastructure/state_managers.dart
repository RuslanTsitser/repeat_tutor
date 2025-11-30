// Chat providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/handlers/realtime_call_event_handler.dart';
import '../presentation/notifiers/chat_notifier.dart';
import '../presentation/notifiers/message_notifier.dart';
import '../presentation/notifiers/realtime_call_notifier.dart';
import '../presentation/notifiers/realtime_session_notifier.dart';
import 'core.dart';
import 'use_case.dart';

final chatProvider = ChangeNotifierProvider<ChatNotifier>((ref) {
  return ChatNotifier();
});

// Message providers
final messageProvider = ChangeNotifierProvider.family<MessageNotifier, String>((
  ref,
  String chatId,
) {
  return MessageNotifier(
    chatId: chatId,
  );
});

/// Провайдер для списка сессий
final realtimeSessionListProvider =
    ChangeNotifierProvider<RealtimeSessionListNotifier>((ref) {
      return RealtimeSessionListNotifier(
        getAllSessionsUseCase: ref.watch(getAllRealtimeSessionsUseCaseProvider),
        createSessionUseCase: ref.watch(createRealtimeSessionUseCaseProvider),
        deleteSessionUseCase: ref.watch(deleteRealtimeSessionUseCaseProvider),
      );
    });

/// Провайдер для звонка (family для разных сессий)
final realtimeCallProvider =
    ChangeNotifierProvider.family<RealtimeCallNotifier, String>((
      ref,
      sessionId,
    ) {
      // Получаем сессию из списка
      final sessionListNotifier = ref.watch(realtimeSessionListProvider);
      final session = sessionListNotifier.sessions.firstWhere(
        (s) => s.id == sessionId,
        orElse: () => throw Exception('Сессия не найдена'),
      );

      final notifier = RealtimeCallNotifier(
        connection: ref.watch(realtimeWebRTCConnectionProvider),
        audioManager: ref.watch(realtimeAudioManagerProvider),
        session: session,
      );

      // Создаем обработчик событий после создания нотифаера
      final eventHandler = RealtimeCallEventHandler(
        notifier: notifier,
        connectWithPermissionUseCase: ref.watch(
          connectRealtimeWithPermissionUseCaseProvider,
        ),
        disconnectUseCase: ref.watch(disconnectRealtimeCallUseCaseProvider),
        startRecordingUseCase: ref.watch(startRecordingUseCaseProvider),
        stopRecordingUseCase: ref.watch(stopRecordingUseCaseProvider),
        sendMessageUseCase: ref.watch(sendTextMessageUseCaseProvider),
      );

      // Устанавливаем колбэки в нотифаере
      notifier.onConnectCallback = () async {
        // Начинаем запись после подключения
        if (!notifier.isRecording) {
          await eventHandler.startRecordingInternal();
        }
      };
      notifier.onDisconnectCallback = () {
        // Останавливаем запись при отключении
        eventHandler.stopRecordingInternal();
      };

      return notifier;
    });
