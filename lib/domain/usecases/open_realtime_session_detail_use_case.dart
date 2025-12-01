import '../../core/router/router.dart';
import '../../presentation/notifiers/realtime_call_notifier.dart';
import '../../presentation/notifiers/realtime_session_notifier.dart';

/// Use case для открытия экрана деталей Realtime-сессии.
class OpenRealtimeSessionDetailUseCase {
  const OpenRealtimeSessionDetailUseCase({
    required this.realtimeSessionListNotifier,
    required this.realtimeCallNotifier,
    required this.appRouter,
  });

  final RealtimeSessionListNotifier realtimeSessionListNotifier;
  final RealtimeCallNotifier realtimeCallNotifier;
  final AppRouter appRouter;

  Future<void> execute(String sessionId) async {
    final sessions = realtimeSessionListNotifier.state.sessions;
    try {
      final session = sessions.firstWhere(
        (session) => session.id == sessionId,
      );
      realtimeCallNotifier.setState(
        realtimeCallNotifier.state.copyWith(
          session: session,
          isConnected: false,
          isConnecting: false,
          isRecording: false,
          isPlaying: false,
          receivedMessages: const [],
          error: null,
        ),
      );
      await appRouter.push(const RealtimeSessionDetailRoute());
    } on StateError {
      realtimeSessionListNotifier.setState(
        realtimeSessionListNotifier.state.copyWith(
          error: 'Сессия не найдена',
        ),
      );
    }
  }
}
