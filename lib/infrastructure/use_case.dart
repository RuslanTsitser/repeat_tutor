import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/usecases/chats/get_chats_use_case.dart';
import '../domain/usecases/realitime_sessions/connect_realtime_session_use_case.dart';
import '../domain/usecases/realitime_sessions/create_realtime_session_use_case.dart';
import '../domain/usecases/realitime_sessions/delete_realtime_session_use_case.dart';
import '../domain/usecases/realitime_sessions/disconnect_realtime_session_use_case.dart';
import '../domain/usecases/realitime_sessions/get_realtime_sessions_use_case.dart';
import '../domain/usecases/realitime_sessions/open_realtime_session_detail_use_case.dart';
import 'core.dart';
import 'repositories.dart';
import 'state_managers.dart';

final getChatsUseCaseProvider = Provider((ref) {
  return GetChatsUseCase(
    chatRepository: ref.watch(chatRepositoryProvider),
    chatNotifier: ref.watch(chatProvider),
  );
});

final getRealtimeSessionsUseCaseProvider = Provider((ref) {
  return GetRealtimeSessionsUseCase(
    realtimeSessionRepository: ref.watch(realtimeSessionRepositoryProvider),
    realtimeSessionListNotifier: ref.watch(realtimeSessionListProvider),
  );
});

final createRealtimeSessionUseCaseProvider = Provider((ref) {
  return CreateRealtimeSessionUseCase(
    realtimeSessionRepository: ref.watch(realtimeSessionRepositoryProvider),
    realtimeSessionListNotifier: ref.watch(realtimeSessionListProvider),
    createRealtimeSessionNotifier: ref.watch(createRealtimeSessionProvider),
    appRouter: ref.watch(routerProvider),
  );
});

final deleteRealtimeSessionUseCaseProvider = Provider((ref) {
  return DeleteRealtimeSessionUseCase(
    realtimeSessionRepository: ref.watch(realtimeSessionRepositoryProvider),
    realtimeSessionListNotifier: ref.watch(realtimeSessionListProvider),
  );
});

final openRealtimeSessionDetailUseCaseProvider = Provider((ref) {
  return OpenRealtimeSessionDetailUseCase(
    realtimeSessionListNotifier: ref.watch(realtimeSessionListProvider),
    realtimeCallNotifier: ref.watch(realtimeCallProvider),
    appRouter: ref.watch(routerProvider),
  );
});

final connectRealtimeSessionUseCaseProvider = Provider((ref) {
  return ConnectRealtimeSessionUseCase(
    realtimeCallNotifier: ref.watch(realtimeCallProvider),
    realtimeWebRTCConnection: ref.watch(realtimeWebRTCConnectionProvider),
  );
});

final disconnectRealtimeSessionUseCaseProvider = Provider((ref) {
  return DisconnectRealtimeSessionUseCase(
    realtimeCallNotifier: ref.watch(realtimeCallProvider),
    realtimeWebRTCConnection: ref.watch(realtimeWebRTCConnectionProvider),
  );
});
