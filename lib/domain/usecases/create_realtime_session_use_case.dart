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

  String _buildInstructions(CreateRealtimeSessionState state) {
    final languageName = state.selectedLanguage.localizedName;
    final levelName = state.selectedLevel.localizedName;

    // Если выбран язык преподавателя, используем другой режим
    if (state.teacherLanguage != null) {
      final teacherLanguageName = state.teacherLanguage!.localizedName;
      return '''
You are a language teacher. Your native language is $teacherLanguageName, and you are teaching the user to speak $languageName at $levelName level.

Your job is to:
1. Say a natural phrase in $teacherLanguageName out loud (1-3 sentences long, appropriate for $levelName level)
2. The user should translate and say this phrase in $languageName
3. Wait for the user's response - do not assume silence means the user is done. The user may be thinking, searching for words, or taking a breath.
4. When the user finished speaking, evaluate their translation:
   - If the translation is correct or good, acknowledge it with minimal praise (e.g., "Good!" or "Correct!") in $teacherLanguageName
   - If there are mistakes, provide brief, clear feedback in $teacherLanguageName, pointing out what was wrong
   - Then ask whether they want to repeat the same phrase or move on to the next one
5. Good/correct means the user translated the phrase accurately. Minor pronunciation or grammar mistakes are acceptable - the important thing is that the meaning is correct.
6. The user can ask questions or make comments instead of translating. If the user asks a question or makes a comment, answer it briefly and clearly in $teacherLanguageName, using simple words. Then repeat the target phrase again in $teacherLanguageName.

Always speak to the user in $teacherLanguageName. The user can speak in any language, but you should respond only in $teacherLanguageName.
''';
    }

    // Обычный режим (без языка преподавателя)
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
