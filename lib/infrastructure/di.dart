import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../data/repositories/message_repository_impl.dart';
import '../../data/repositories/realtime_session_repository_impl.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/repositories/message_repository.dart';
import '../../domain/repositories/realtime_session_repository.dart';
import '../../domain/usecases/connect_realtime_webrtc_usecase.dart';
import '../../domain/usecases/create_realtime_session_usecase.dart';
import '../../domain/usecases/delete_realtime_session_usecase.dart';
import '../../domain/usecases/get_all_realtime_sessions_usecase.dart';
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

// Chat providers
final chatProvider = ChangeNotifierProvider<ChatNotifier>((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatNotifier(chatRepository);
});

// Message providers
final messageProvider = ChangeNotifierProvider.family<MessageNotifier, String>((
  ref,
  String chatId,
) {
  final messageRepository = ref.watch(messageRepositoryProvider);
  return MessageNotifier(chatId, messageRepository);
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
      final generatePromptUseCase = const GeneratePromptFromSettingsUseCase();
      return CreateRealtimeSessionUseCase(
        repository: repository,
        generatePromptUseCase: generatePromptUseCase,
      );
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
        connectUseCase: ref.watch(connectRealtimeWebRTCUseCaseProvider),
        sessionRepository: ref.watch(realtimeSessionRepositoryProvider),
        createSessionUseCase: ref.watch(createRealtimeSessionUseCaseProvider),
        deleteSessionUseCase: ref.watch(deleteRealtimeSessionUseCaseProvider),
        session: session,
      );
    });
