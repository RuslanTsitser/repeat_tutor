import '../../core/router/router.dart';
import '../../domain/models/session_settings.dart';
import '../../presentation/notifiers/create_realtime_session_notifier.dart';
import '../../presentation/notifiers/realtime_session_notifier.dart';
import '../repositories/realtime_session_repository.dart';

/// Use case для создания новой Realtime-сессии.
class CreateRealtimeSessionUseCase {
  const CreateRealtimeSessionUseCase({
    required this.realtimeSessionRepository,
    required this.realtimeSessionListNotifier,
    required this.createRealtimeSessionNotifier,
    required this.appRouter,
  });

  final RealtimeSessionRepository realtimeSessionRepository;
  final RealtimeSessionListNotifier realtimeSessionListNotifier;
  final CreateRealtimeSessionNotifier createRealtimeSessionNotifier;
  final AppRouter appRouter;

  Future<void> execute() async {
    final currentState = createRealtimeSessionNotifier.state;
    if (currentState.isLoading) return;

    createRealtimeSessionNotifier.setState(
      currentState.copyWith(
        isLoading: true,
        error: null,
      ),
    );

    try {
      final newSession = await realtimeSessionRepository.createSession(
        instructions: _buildInstructions(currentState),
        settings: SessionSettings(
          language: currentState.selectedLanguage,
          level: currentState.selectedLevel,
        ),
      );

      final updatedSessions = [
        ...realtimeSessionListNotifier.state.sessions,
        newSession,
      ];

      realtimeSessionListNotifier.setState(
        realtimeSessionListNotifier.state.copyWith(
          sessions: updatedSessions,
          error: null,
        ),
      );

      appRouter.pop();
    } catch (e) {
      createRealtimeSessionNotifier.setState(
        createRealtimeSessionNotifier.state.copyWith(
          error: e.toString(),
        ),
      );
    } finally {
      createRealtimeSessionNotifier.setState(
        createRealtimeSessionNotifier.state.copyWith(
          isLoading: false,
        ),
      );
    }
  }

  String _buildInstructions(CreateRealtimeSessionState state) {
    final languageName = state.selectedLanguage.localizedName;
    final levelName = state.selectedLevel.localizedName;
    // TODO: Поправить инструкции
    return 'Ты опытный преподаватель $languageName. '
        'Веди живую аудио-беседу с учеником уровня $levelName, '
        'поддерживай естественный диалог, исправляй ошибки и объясняй правила, '
        'поощряй ученика говорить больше.';
  }
}
