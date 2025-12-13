import '../../../core/gpt/instructions/tutor_instruction.dart';
import '../../../core/router/router.dart';
import '../../../presentation/notifiers/create_realtime_session_notifier.dart';
import '../../../presentation/notifiers/realtime_session_notifier.dart';
import '../../models/session_settings.dart';
import '../../repositories/realtime_session_repository.dart';

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

    final instructions = TutorInstruction.build(
      languageName: currentState.selectedLanguage.localizedName,
      levelName: currentState.selectedLevel.localizedName,
      teacherLanguageName: currentState.teacherLanguage?.localizedName,
    );

    try {
      final newSession = await realtimeSessionRepository.createSession(
        instructions: instructions,
        settings: SessionSettings(
          language: currentState.selectedLanguage,
          level: currentState.selectedLevel,
          teacherLanguage: currentState.teacherLanguage,
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
}
