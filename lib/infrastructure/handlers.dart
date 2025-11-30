import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/handlers/chat_event_handler.dart';
import '../presentation/handlers/message_event_handler.dart';
import '../presentation/handlers/realtime_call_event_handler.dart';
import 'core.dart';
import 'state_managers.dart';
import 'use_case.dart';

/// Провайдер для обработчика событий чатов
final chatEventHandlerProvider = Provider<ChatEventHandler>((ref) {
  final notifier = ref.watch(chatProvider);
  return ChatEventHandler(
    notifier: notifier,
    getChatsUseCase: ref.watch(getChatsUseCaseProvider),
    updateChatLastMessageUseCase: ref.watch(
      updateChatLastMessageUseCaseProvider,
    ),
    markChatAsReadUseCase: ref.watch(markChatAsReadUseCaseProvider),
    createChatUseCase: ref.watch(createChatUseCaseProvider),
    deleteChatUseCase: ref.watch(deleteChatUseCaseProvider),
  );
});

/// Провайдер для обработчика событий сообщений (family для разных чатов)
final messageEventHandlerProvider =
    Provider.family<MessageEventHandler, String>((ref, chatId) {
      final notifier = ref.watch(messageProvider(chatId));
      return MessageEventHandler(
        notifier: notifier,
        getMessagesUseCase: ref.watch(getMessagesUseCaseProvider),
        addMessageUseCase: ref.watch(addMessageUseCaseProvider),
        deleteMessageUseCase: ref.watch(deleteMessageUseCaseProvider),
        updateMessageUseCase: ref.watch(updateMessageUseCaseProvider),
        clearMessagesUseCase: ref.watch(clearMessagesUseCaseProvider),
      );
    });

// Realtime providers

/// Провайдер для обработчика событий звонка (family для разных сессий)
/// Управляет подписками на события connection и audioManager
final realtimeCallEventHandlerProvider =
    Provider.family<RealtimeCallEventHandler, String>((ref, sessionId) {
      final notifier = ref.watch(realtimeCallProvider(sessionId));
      final connection = ref.watch(realtimeWebRTCConnectionProvider);
      final audioManager = ref.watch(realtimeAudioManagerProvider);

      final eventHandler = RealtimeCallEventHandler(
        notifier: notifier,
        connection: connection,
        audioManager: audioManager,
        connectWithPermissionUseCase: ref.watch(
          connectRealtimeWithPermissionUseCaseProvider,
        ),
        disconnectUseCase: ref.watch(disconnectRealtimeCallUseCaseProvider),
        startRecordingUseCase: ref.watch(startRecordingUseCaseProvider),
        stopRecordingUseCase: ref.watch(stopRecordingUseCaseProvider),
      );

      // Очищаем колбэки при удалении провайдера
      ref.onDispose(() {
        eventHandler.dispose();
      });

      return eventHandler;
    });
