import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'realtime_session_dao.g.dart';

/// DAO для работы с сессиями Realtime API
@DriftAccessor(tables: [RealtimeSessions])
class RealtimeSessionDao extends DatabaseAccessor<AppDatabase>
    with _$RealtimeSessionDaoMixin {
  RealtimeSessionDao(super.db);

  /// Получить все сессии
  Future<List<RealtimeSession>> getAllSessions() =>
      select(realtimeSessions).get();

  /// Получить сессию по ID
  Future<RealtimeSession?> getSessionById(String sessionId) {
    return (select(
      realtimeSessions,
    )..where((tbl) => tbl.sessionId.equals(sessionId))).getSingleOrNull();
  }

  /// Создать новую сессию
  Future<void> insertSession({
    required String sessionId,
    required String language,
    required String level,
    required String clientSecret,
    required DateTime clientSecretExpiresAt,
  }) {
    final now = DateTime.now();
    return into(realtimeSessions).insert(
      RealtimeSessionsCompanion(
        sessionId: Value(sessionId),
        createdAt: Value(now),
        language: Value(language),
        level: Value(level),
        clientSecret: Value(clientSecret),
        clientSecretExpiresAt: Value(clientSecretExpiresAt),
      ),
    );
  }

  /// Обновить сессию
  Future<void> updateSession({
    required String sessionId,
    required String language,
    required String level,
    required String clientSecret,
    required DateTime clientSecretExpiresAt,
  }) {
    return (update(
      realtimeSessions,
    )..where((tbl) => tbl.sessionId.equals(sessionId))).write(
      RealtimeSessionsCompanion(
        sessionId: Value(sessionId),
        language: Value(language),
        level: Value(level),
        clientSecret: Value(clientSecret),
        clientSecretExpiresAt: Value(clientSecretExpiresAt),
      ),
    );
  }

  /// Удалить сессию
  Future<void> deleteSession(String id) {
    return (delete(
      realtimeSessions,
    )..where((tbl) => tbl.sessionId.equals(id))).go();
  }
}
