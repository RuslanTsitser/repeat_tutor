import '../models/realtime_session.dart';
import '../models/session_settings.dart';

/// Протокол репозитория для работы с сессиями Realtime API
abstract interface class RealtimeSessionRepository {
  /// Получить все сессии
  Future<List<RealtimeSession>> getAllSessions();

  /// Создать новую сессию
  Future<RealtimeSession> createSession({
    required String instructions,
    required SessionSettings settings,
  });

  /// Удалить сессию
  Future<void> deleteSession(RealtimeSession session);
}
