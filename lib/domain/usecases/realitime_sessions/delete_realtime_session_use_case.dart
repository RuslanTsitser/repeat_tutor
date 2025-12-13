import '../../../presentation/notifiers/realtime_session_notifier.dart';
import '../../repositories/realtime_session_repository.dart';

/// Use case для удаления Realtime-сессии.
class DeleteRealtimeSessionUseCase {
  const DeleteRealtimeSessionUseCase({
    required this.realtimeSessionRepository,
    required this.realtimeSessionListNotifier,
  });

  final RealtimeSessionRepository realtimeSessionRepository;
  final RealtimeSessionListNotifier realtimeSessionListNotifier;

  Future<void> execute(String sessionId) async {
    final currentState = realtimeSessionListNotifier.state;
    if (currentState.isLoading) return;

    realtimeSessionListNotifier.setState(
      currentState.copyWith(
        isLoading: true,
        error: null,
      ),
    );

    try {
      await realtimeSessionRepository.deleteSession(sessionId);
      final updatedSessions = realtimeSessionListNotifier.state.sessions
          .where((session) => session.id != sessionId)
          .toList();

      realtimeSessionListNotifier.setState(
        realtimeSessionListNotifier.state.copyWith(
          sessions: updatedSessions,
        ),
      );
    } catch (e) {
      realtimeSessionListNotifier.setState(
        realtimeSessionListNotifier.state.copyWith(
          error: e.toString(),
        ),
      );
    } finally {
      realtimeSessionListNotifier.setState(
        realtimeSessionListNotifier.state.copyWith(
          isLoading: false,
        ),
      );
    }
  }
}
