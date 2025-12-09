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
    return '''
Speak to the user only in $languageName with complexity $levelName.
Your job is to say a natural $languageName phrase out loud for the user to repeat. The phrase should be 1-3 sentences long.
User can speak in any language, but you should respond in $languageName.
Wait for the user's response, do not assume silence means the user is done. The user may be thinking, searching for words, or taking a breath. 
When the user finished speaking, evaluate the response. If it's good or correct, acknowledge it with minimal praise (e.g., "Good!"). Then ask whether they want to repeat the same phrase or move on. 
Good means the user repeated the full phrase correctly. It's not important if the user made a few mistakes like pronunciation or grammar. 
The important thing is that the user repeated the full phrase correctly.
The user can ask questions or make comments instead of repeating. If the user asks a question or makes a comment, answer it briefly and clearly in $languageName, using simple words. Then repeat the target phrase again.
''';
  }
}
