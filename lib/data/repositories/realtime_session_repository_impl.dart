import '../../core/database/app_database.dart' as db;
import '../../core/database/daos/realtime_session_dao.dart';
import '../../core/gpt/gpt_service.dart';
import '../../domain/models/realtime_session.dart';
import '../../domain/models/session_settings.dart';
import '../../domain/repositories/realtime_session_repository.dart';
import '../mappers/realtime_session_db_mappers.dart';

/// Реализация репозитория для работы с сессиями Realtime API
class RealtimeSessionRepositoryImpl implements RealtimeSessionRepository {
  const RealtimeSessionRepositoryImpl({
    required this.database,
    required this.gptService,
  });
  final db.AppDatabase database;
  final GptService gptService;

  RealtimeSessionDao get dao => RealtimeSessionDao(database);

  @override
  Future<List<RealtimeSession>> getAllSessions() async {
    // Получаем сессии из локального хранилища
    final dbSessions = await dao.getAllSessions();
    return dbSessions.map(RealtimeSessionDbMappers.toDomain).toList();
  }

  @override
  Future<RealtimeSession> createSession({
    required String instructions,
    required SessionSettings settings,
  }) async {
    final sessionResult = await gptService.createSession(instructions);

    await dao.insertSession(
      sessionId: sessionResult.sessionId,
      language: settings.language.value,
      level: settings.level.value,
      clientSecret: sessionResult.clientSecret,
      clientSecretExpiresAt: sessionResult.clientSecretExpiresAt,
    );

    return RealtimeSession(
      id: sessionResult.sessionId,
      createdAt: DateTime.now(),
      language: settings.language,
      level: settings.level,
      clientSecret: sessionResult.clientSecret,
      clientSecretExpiresAt: sessionResult.clientSecretExpiresAt,
    );
  }

  @override
  Future<void> deleteSession(String id) async {
    await dao.deleteSession(id);
  }
}
