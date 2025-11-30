import '../../core/database/app_database.dart' as db;
import '../../domain/models/realtime_session.dart' as domain;
import '../../domain/models/session_difficulty_level.dart' as domain;
import '../../domain/models/session_language.dart' as domain;

abstract class RealtimeSessionDbMappers {
  static domain.RealtimeSession toDomain(db.RealtimeSession session) {
    return domain.RealtimeSession(
      id: session.sessionId,
      createdAt: session.createdAt,
      language: domain.SessionLanguage.fromValue(session.language)!,
      level: domain.SessionDifficultyLevel.fromValue(session.level)!,
      clientSecret: session.clientSecret,
      clientSecretExpiresAt: session.clientSecretExpiresAt,
    );
  }

  static db.RealtimeSession toDb(domain.RealtimeSession session) {
    return db.RealtimeSession(
      sessionId: session.id,
      createdAt: session.createdAt,
      language: session.language.value,
      level: session.level.value,
      clientSecret: session.clientSecret,
      clientSecretExpiresAt: session.clientSecretExpiresAt,
    );
  }
}
