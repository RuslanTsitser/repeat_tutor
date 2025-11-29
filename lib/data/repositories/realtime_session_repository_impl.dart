import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../../core/database/app_database.dart' as db;
import '../../core/database/daos/realtime_session_dao.dart';
import '../../domain/models/realtime_session.dart';
import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';
import '../../domain/models/session_settings.dart';
import '../../domain/repositories/realtime_session_repository.dart';

/// Реализация репозитория для работы с сессиями Realtime API
class RealtimeSessionRepositoryImpl implements RealtimeSessionRepository {
  const RealtimeSessionRepositoryImpl({
    required this.database,
    required this.dio,
    required this.apiKey,
  });
  final db.AppDatabase database;
  final Dio dio;
  final String apiKey;

  RealtimeSessionDao get dao => RealtimeSessionDao(database);

  @override
  Future<List<RealtimeSession>> getAllSessions() async {
    // Получаем сессии из локального хранилища
    final dbSessions = await dao.getAllSessions();
    return dbSessions.map((dbSession) => _fromDb(dbSession)).toList();
  }

  @override
  Future<RealtimeSession> createSession({
    required String instructions,
    required SessionSettings settings,
  }) async {
    // Создаем сессию через API
    final url = 'https://api.openai.com/v1/realtime/sessions';
    final requestBody = {
      'model': 'gpt-realtime',
      'instructions': instructions,
      'voice': 'cedar',
      'turn_detection': {'type': 'semantic_vad'},
    };

    final response = await dio.post<Map<String, dynamic>>(
      url,
      data: requestBody,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
          'OpenAI-Beta': 'realtime=v1',
        },
      ),
    );

    final data = response.data as Map<String, dynamic>;
    final sessionId = data['id'] as String;
    final clientSecretData = data['client_secret'] as Map<String, dynamic>;
    final clientSecret = clientSecretData['value'] as String;
    final expiresAt = clientSecretData['expires_at'] as int;
    final serverURL = data['server_url'] as String?;

    final expiresAtDate = DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000);

    // Сохраняем в локальное хранилище
    final session = db.RealtimeSessionsCompanion(
      id: Value(sessionId),
      createdAt: Value(DateTime.now()),
      language: Value(settings.language.value),
      level: Value(settings.level.value),
      clientSecret: Value(clientSecret),
      clientSecretExpiresAt: Value(expiresAtDate),
      serverURL: Value(serverURL),
    );

    await dao.insertSession(session);

    return RealtimeSession(
      id: sessionId,
      createdAt: DateTime.now(),
      language: settings.language,
      level: settings.level,
      clientSecret: clientSecret,
      clientSecretExpiresAt: expiresAtDate,
      serverURL: serverURL,
    );
  }

  @override
  Future<void> deleteSession(RealtimeSession session) async {
    await dao.deleteSession(session.id);
  }

  @override
  Future<void> updateSession(RealtimeSession session) async {
    await dao.updateSession(
      db.RealtimeSessionsCompanion(
        id: Value(session.id),
        callStartedAt: Value(session.callStartedAt),
        callDurationMinutes: Value(session.callDurationMinutes),
      ),
    );
  }

  RealtimeSession _fromDb(db.RealtimeSession dbSession) {
    return RealtimeSession(
      id: dbSession.id,
      createdAt: dbSession.createdAt,
      language: dbSession.language != null
          ? SessionLanguage.fromValue(dbSession.language!)
          : null,
      level: dbSession.level != null
          ? SessionDifficultyLevel.fromValue(dbSession.level!)
          : null,
      clientSecret: dbSession.clientSecret,
      clientSecretExpiresAt: dbSession.clientSecretExpiresAt,
      serverURL: dbSession.serverURL,
      callStartedAt: dbSession.callStartedAt,
      callDurationMinutes: dbSession.callDurationMinutes,
    );
  }
}
