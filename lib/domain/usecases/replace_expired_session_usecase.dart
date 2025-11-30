import '../models/realtime_session.dart';
import '../models/session_difficulty_level.dart';
import '../models/session_language.dart';
import '../models/session_settings.dart';
import 'create_realtime_session_usecase.dart';
import 'delete_realtime_session_usecase.dart';

/// Use Case для замены истекшей сессии
class ReplaceExpiredSessionUseCase {
  const ReplaceExpiredSessionUseCase({
    required this.createSessionUseCase,
    required this.deleteSessionUseCase,
  });

  final CreateRealtimeSessionUseCase createSessionUseCase;
  final DeleteRealtimeSessionUseCase deleteSessionUseCase;

  Future<RealtimeSession> execute(RealtimeSession expiredSession) async {
    // Сохраняем параметры текущей сессии
    final settings = SessionSettings(
      language: expiredSession.language ?? SessionLanguage.japanese,
      level: expiredSession.level ?? SessionDifficultyLevel.beginner,
    );

    // Создаем новую сессию
    final newSession = await createSessionUseCase.execute(settings);

    // Удаляем старую сессию
    await deleteSessionUseCase.execute(expiredSession);

    return newSession;
  }
}
