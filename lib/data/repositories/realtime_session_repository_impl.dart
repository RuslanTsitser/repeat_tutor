import 'package:dio/dio.dart';

import '../../core/database/app_database.dart' as db;
import '../../core/database/daos/realtime_session_dao.dart';
import '../../domain/models/realtime_session.dart';
import '../../domain/models/session_settings.dart';
import '../../domain/repositories/realtime_session_repository.dart';
import '../mappers/realtime_session_db_mappers.dart';

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
    return dbSessions.map(RealtimeSessionDbMappers.toDomain).toList();
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

    final expiresAtDate = DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000);

    await dao.insertSession(
      sessionId: sessionId,
      language: settings.language.value,
      level: settings.level.value,
      clientSecret: clientSecret,
      clientSecretExpiresAt: expiresAtDate,
    );

    return RealtimeSession(
      id: sessionId,
      createdAt: DateTime.now(),
      language: settings.language,
      level: settings.level,
      clientSecret: clientSecret,
      clientSecretExpiresAt: expiresAtDate,
    );
  }

  @override
  Future<void> deleteSession(String id) async {
    await dao.deleteSession(id);
  }

  @override
  Future<void> updateSession(RealtimeSession session) async {
    await dao.updateSession(
      sessionId: session.id,
      language: session.language.value,
      level: session.level.value,
      clientSecret: session.clientSecret!,
      clientSecretExpiresAt: session.clientSecretExpiresAt!,
    );
  }

  @override
  Stream<List<RealtimeSession>> getSessionStream() {
    return dao.getSessionStream().map(
      (rows) => rows.map(RealtimeSessionDbMappers.toDomain).toList(),
    );
  }
}
