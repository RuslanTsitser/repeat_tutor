import '../models/realtime_session.dart';
import '../models/session_settings.dart';
import '../repositories/realtime_session_repository.dart';

/// Use Case для создания сессии Realtime API
class CreateRealtimeSessionUseCase {
  const CreateRealtimeSessionUseCase({
    required this.repository,
  });
  final RealtimeSessionRepository repository;

  Future<RealtimeSession> execute(SessionSettings settings) async {
    // Генерируем промпт из настроек
    final instructions = _generatePrompt(settings);
    return await repository.createSession(
      instructions: instructions,
      settings: settings,
    );
  }

  String _generatePrompt(SessionSettings settings) {
    // Простая генерация промпта на основе настроек
    // В реальном приложении это может быть более сложная логика
    final languageName = settings.language.localizedName;
    final levelDescription = settings.level.value;

    return '''
Speak to the user only in $languageName with complexity $levelDescription.
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
