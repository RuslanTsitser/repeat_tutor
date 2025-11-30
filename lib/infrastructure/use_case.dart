// Chat Use Cases
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/usecases/add_message_usecase.dart';
import '../domain/usecases/clear_messages_usecase.dart';
import '../domain/usecases/connect_realtime_webrtc_usecase.dart';
import '../domain/usecases/connect_realtime_with_permission_usecase.dart';
import '../domain/usecases/create_chat_usecase.dart';
import '../domain/usecases/create_realtime_session_usecase.dart';
import '../domain/usecases/delete_chat_usecase.dart';
import '../domain/usecases/delete_message_usecase.dart';
import '../domain/usecases/delete_realtime_session_usecase.dart';
import '../domain/usecases/disconnect_realtime_call_usecase.dart';
import '../domain/usecases/get_all_realtime_sessions_usecase.dart';
import '../domain/usecases/get_chats_usecase.dart';
import '../domain/usecases/get_messages_usecase.dart';
import '../domain/usecases/mark_chat_as_read_usecase.dart';
import '../domain/usecases/replace_expired_session_usecase.dart';
import '../domain/usecases/request_microphone_permission_usecase.dart';
import '../domain/usecases/start_recording_usecase.dart';
import '../domain/usecases/stop_recording_usecase.dart';
import '../domain/usecases/update_chat_last_message_usecase.dart';
import '../domain/usecases/update_message_usecase.dart';
import 'core.dart';
import 'repositories.dart';

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
        requestPermissionUseCase: ref.watch(
          requestMicrophonePermissionUseCaseProvider,
        ),
        replaceExpiredSessionUseCase: ref.watch(
          replaceExpiredSessionUseCaseProvider,
        ),
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

final disconnectRealtimeCallUseCaseProvider =
    Provider<DisconnectRealtimeCallUseCase>((ref) {
      final connection = ref.watch(realtimeWebRTCConnectionProvider);
      final audioManager = ref.watch(realtimeAudioManagerProvider);
      return DisconnectRealtimeCallUseCase(
        connection: connection,
        audioManager: audioManager,
      );
    });
