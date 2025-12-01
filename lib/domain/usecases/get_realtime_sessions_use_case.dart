import '../../presentation/notifiers/realtime_session_notifier.dart';
import '../repositories/realtime_session_repository.dart';

/// Use case для загрузки списка Realtime-сессий.
class GetRealtimeSessionsUseCase {
  const GetRealtimeSessionsUseCase({
    required this.realtimeSessionRepository,
    required this.realtimeSessionListNotifier,
  });

  final RealtimeSessionRepository realtimeSessionRepository;
  final RealtimeSessionListNotifier realtimeSessionListNotifier;

  Future<void> execute() async {
    final currentState = realtimeSessionListNotifier.state;
    if (currentState.isLoading) return;

    realtimeSessionListNotifier.setState(
      currentState.copyWith(
        isLoading: true,
        error: null,
      ),
    );

    try {
      final sessions = await realtimeSessionRepository.getAllSessions();
      realtimeSessionListNotifier.setState(
        realtimeSessionListNotifier.state.copyWith(
          sessions: sessions,
          error: null,
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

