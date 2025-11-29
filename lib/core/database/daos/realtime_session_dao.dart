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
  Future<RealtimeSession?> getSessionById(String id) {
    return (select(
      realtimeSessions,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Создать новую сессию
  Future<void> insertSession(RealtimeSessionsCompanion session) =>
      into(realtimeSessions).insert(session);

  /// Обновить сессию
  Future<void> updateSession(RealtimeSessionsCompanion session) {
    return (update(
      realtimeSessions,
    )..where((tbl) => tbl.id.equals(session.id.value))).write(session);
  }

  /// Удалить сессию
  Future<void> deleteSession(String id) {
    return (delete(realtimeSessions)..where((tbl) => tbl.id.equals(id))).go();
  }
}
