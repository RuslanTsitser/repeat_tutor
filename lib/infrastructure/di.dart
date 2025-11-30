import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../data/repositories/message_repository_impl.dart';
import '../../data/repositories/realtime_session_repository_impl.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/repositories/message_repository.dart';
import '../../domain/repositories/realtime_session_repository.dart';
import '../../domain/usecases/add_message_usecase.dart';
import '../../domain/usecases/clear_messages_usecase.dart';
import '../../domain/usecases/connect_realtime_with_permission_usecase.dart';
import '../../domain/usecases/connect_realtime_webrtc_usecase.dart';
import '../../domain/usecases/create_chat_usecase.dart';
import '../../domain/usecases/create_realtime_session_usecase.dart';
import '../../domain/usecases/delete_chat_usecase.dart';
import '../../domain/usecases/delete_message_usecase.dart';
import '../../domain/usecases/delete_realtime_session_usecase.dart';
import '../../domain/usecases/disconnect_realtime_call_usecase.dart';
import '../../domain/usecases/get_all_realtime_sessions_usecase.dart';
import '../../domain/usecases/get_chats_usecase.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/mark_chat_as_read_usecase.dart';
import '../../domain/usecases/replace_expired_session_usecase.dart';
import '../../domain/usecases/request_microphone_permission_usecase.dart';
import '../../domain/usecases/send_text_message_usecase.dart';
import '../../domain/usecases/start_recording_usecase.dart';
import '../../domain/usecases/stop_recording_usecase.dart';
import '../../domain/usecases/update_chat_last_message_usecase.dart';
import '../../domain/usecases/update_message_usecase.dart';
import '../core/ab_test/ab_test_prod.dart';
import '../core/logging/app_logger.dart';
import '../core/realtime/realtime_audio_manager.dart';
import '../core/realtime/realtime_webrtc_manager.dart';
import '../presentation/notifiers/chat_notifier.dart';
import '../presentation/notifiers/message_notifier.dart';
import '../presentation/notifiers/realtime_call_notifier.dart';
import '../presentation/notifiers/realtime_session_notifier.dart';

// Database provider
/// Провайдер для базы данных
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// Repository providers
/// Провайдер для ChatRepository
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ChatRepositoryImpl(database);
});

/// Провайдер для MessageRepository
final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return MessageRepositoryImpl(database);
});

// Chat Use Cases
final getChatsUseCaseProvider = Provider<GetChatsUseCase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetChatsUseCase(repository: repository);
});

final updateChatLastMessageUseCaseProvider =
    Provider<UpdateChatLastMessageUseCase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return UpdateChatLastMessageUseCase(repository: repository);
});

final markChatAsReadUseCaseProvider = Provider<MarkChatAsReadUseCase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return MarkChatAsReadUseCase(repository: repository);
});

final createChatUseCaseProvider = Provider<CreateChatUseCase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return CreateChatUseCase(repository: repository);
});

final deleteChatUseCaseProvider = Provider<DeleteChatUseCase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return DeleteChatUseCase(repository: repository);
});

// Message Use Cases
final getMessagesUseCaseProvider = Provider<GetMessagesUseCase>((ref) {
  final repository = ref.watch(messageRepositoryProvider);
  return GetMessagesUseCase(repository: repository);
});

final addMessageUseCaseProvider = Provider<AddMessageUseCase>((ref) {
  final repository = ref.watch(messageRepositoryProvider);
  return AddMessageUseCase(repository: repository);
});

final deleteMessageUseCaseProvider = Provider<DeleteMessageUseCase>((ref) {
  final repository = ref.watch(messageRepositoryProvider);
  return DeleteMessageUseCase(repository: repository);
});

final updateMessageUseCaseProvider = Provider<UpdateMessageUseCase>((ref) {
  final repository = ref.watch(messageRepositoryProvider);
  return UpdateMessageUseCase(repository: repository);
});

final clearMessagesUseCaseProvider = Provider<ClearMessagesUseCase>((ref) {
  final repository = ref.watch(messageRepositoryProvider);
  return ClearMessagesUseCase(repository: repository);
});

// Chat providers
final chatProvider = ChangeNotifierProvider<ChatNotifier>((ref) {
  return ChatNotifier(
    getChatsUseCase: ref.watch(getChatsUseCaseProvider),
    updateChatLastMessageUseCase: ref.watch(updateChatLastMessageUseCaseProvider),
    markChatAsReadUseCase: ref.watch(markChatAsReadUseCaseProvider),
    createChatUseCase: ref.watch(createChatUseCaseProvider),
    deleteChatUseCase: ref.watch(deleteChatUseCaseProvider),
  );
});

// Message providers
final messageProvider = ChangeNotifierProvider.family<MessageNotifier, String>((
  ref,
  String chatId,
) {
  return MessageNotifier(
    chatId: chatId,
    getMessagesUseCase: ref.watch(getMessagesUseCaseProvider),
    addMessageUseCase: ref.watch(addMessageUseCaseProvider),
    deleteMessageUseCase: ref.watch(deleteMessageUseCaseProvider),
    updateMessageUseCase: ref.watch(updateMessageUseCaseProvider),
    clearMessagesUseCase: ref.watch(clearMessagesUseCaseProvider),
  );
});

// Realtime providers
/// API ключ OpenAI (должен быть установлен через переменные окружения)
final openAIApiKeyProvider = Provider<String>((ref) {
  const apiKey = String.fromEnvironment('OPENAI_API_KEY', defaultValue: '');
  if (apiKey.isEmpty) {
    throw StateError(
      'OPENAI_API_KEY не установлен. Установите переменную окружения OPENAI_API_KEY.',
    );
  }
  return apiKey;
});

/// Провайдер для Dio
final dioProvider = Provider<Dio>((ref) {
  return Dio()
    ..interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: false,
        logPrint: logInfo,
      ),
    );
});

/// Провайдер для RealtimeSessionRepository
final realtimeSessionRepositoryProvider = Provider<RealtimeSessionRepository>((
  ref,
) {
  final database = ref.watch(databaseProvider);
  final dio = ref.watch(dioProvider);
  final apiKey = ref.watch(openAIApiKeyProvider);
  return RealtimeSessionRepositoryImpl(
    database: database,
    dio: dio,
    apiKey: apiKey,
  );
});

/// Провайдер для RealtimeWebRTCConnection
final realtimeWebRTCConnectionProvider = Provider<RealtimeWebRTCConnection>((
  ref,
) {
  return RealtimeWebRTCManagerImpl();
});

/// Провайдер для RealtimeAudioManager
final realtimeAudioManagerProvider = Provider<RealtimeAudioManager>((
  ref,
) {
  return RealtimeAudioManagerImpl();
});

/// Провайдер для Use Cases
final getAllRealtimeSessionsUseCaseProvider =
    Provider<GetAllRealtimeSessionsUseCase>((ref) {
      final repository = ref.watch(realtimeSessionRepositoryProvider);
      return GetAllRealtimeSessionsUseCase(repository: repository);
    });

final createRealtimeSessionUseCaseProvider =
    Provider<CreateRealtimeSessionUseCase>((ref) {
      final repository = ref.watch(realtimeSessionRepositoryProvider);
      return CreateRealtimeSessionUseCase(repository: repository);
    });

final deleteRealtimeSessionUseCaseProvider =
    Provider<DeleteRealtimeSessionUseCase>((ref) {
      final repository = ref.watch(realtimeSessionRepositoryProvider);
      return DeleteRealtimeSessionUseCase(repository: repository);
    });

final connectRealtimeWebRTCUseCaseProvider =
    Provider<ConnectRealtimeWebRTCUseCase>((ref) {
      final connection = ref.watch(realtimeWebRTCConnectionProvider);
      return ConnectRealtimeWebRTCUseCase(connection: connection);
    });

final requestMicrophonePermissionUseCaseProvider =
    Provider<RequestMicrophonePermissionUseCase>((ref) {
      return const RequestMicrophonePermissionUseCase();
    });

final replaceExpiredSessionUseCaseProvider =
    Provider<ReplaceExpiredSessionUseCase>((ref) {
      return ReplaceExpiredSessionUseCase(
        createSessionUseCase: ref.watch(createRealtimeSessionUseCaseProvider),
        deleteSessionUseCase: ref.watch(deleteRealtimeSessionUseCaseProvider),
      );
    });

final connectRealtimeWithPermissionUseCaseProvider =
    Provider<ConnectRealtimeWithPermissionUseCase>((ref) {
      return ConnectRealtimeWithPermissionUseCase(
        requestPermissionUseCase: ref.watch(requestMicrophonePermissionUseCaseProvider),
        replaceExpiredSessionUseCase: ref.watch(replaceExpiredSessionUseCaseProvider),
        connectUseCase: ref.watch(connectRealtimeWebRTCUseCaseProvider),
      );
    });

final startRecordingUseCaseProvider = Provider<StartRecordingUseCase>((ref) {
  final audioManager = ref.watch(realtimeAudioManagerProvider);
  return StartRecordingUseCase(audioManager: audioManager);
});

final stopRecordingUseCaseProvider = Provider<StopRecordingUseCase>((ref) {
  final audioManager = ref.watch(realtimeAudioManagerProvider);
  final connection = ref.watch(realtimeWebRTCConnectionProvider);
  return StopRecordingUseCase(
    audioManager: audioManager,
    connection: connection,
  );
});

final sendTextMessageUseCaseProvider = Provider<SendTextMessageUseCase>((ref) {
  final connection = ref.watch(realtimeWebRTCConnectionProvider);
  return SendTextMessageUseCase(connection: connection);
});

final disconnectRealtimeCallUseCaseProvider =
    Provider<DisconnectRealtimeCallUseCase>((ref) {
      final connection = ref.watch(realtimeWebRTCConnectionProvider);
      final audioManager = ref.watch(realtimeAudioManagerProvider);
      return DisconnectRealtimeCallUseCase(
        connection: connection,
        audioManager: audioManager,
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

      return RealtimeCallNotifier(
        connection: ref.watch(realtimeWebRTCConnectionProvider),
        audioManager: ref.watch(realtimeAudioManagerProvider),
        connectWithPermissionUseCase: ref.watch(connectRealtimeWithPermissionUseCaseProvider),
        disconnectUseCase: ref.watch(disconnectRealtimeCallUseCaseProvider),
        startRecordingUseCase: ref.watch(startRecordingUseCaseProvider),
        stopRecordingUseCase: ref.watch(stopRecordingUseCaseProvider),
        sendMessageUseCase: ref.watch(sendTextMessageUseCaseProvider),
        session: session,
      );
    });

final abTestServiceProvider = Provider<AbTestService>((ref) {
  const appKey = String.fromEnvironment('APPHUD_APP_KEY', defaultValue: '');
  if (appKey.isEmpty) {
    throw StateError(
      'APPHUD_APP_KEY не установлен. Установите переменную окружения APPHUD_APP_KEY.',
    );
  }
  return AbTestService(appKey);
});

final initializeServiceProvider = FutureProvider<void>((ref) async {
  final abTestService = ref.watch(abTestServiceProvider);
  await abTestService.init();
});
