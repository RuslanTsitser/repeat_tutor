import 'package:drift/drift.dart';

import '../../core/database/app_database.dart' as db;
import '../../core/database/daos/chat_configuration_dao.dart';
import '../../domain/models/chat_configuration.dart' as model;
import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';
import '../../domain/repositories/chat_configuration_repository.dart';

class ChatConfigurationRepositoryImpl implements ChatConfigurationRepository {
  ChatConfigurationRepositoryImpl(this._database);

  final db.AppDatabase _database;

  ChatConfigurationDao get _dao => ChatConfigurationDao(_database);

  @override
  Future<List<model.ChatConfiguration>> getAll() async {
    final rows = await _dao.getAll();
    return rows.map(_mapToDomain).toList();
  }

  @override
  Future<model.ChatConfiguration?> getByChatId(String chatId) async {
    final row = await _dao.getByChatId(chatId);
    return row != null ? _mapToDomain(row) : null;
  }

  @override
  Future<model.ChatConfiguration> upsert(
    model.ChatConfiguration configuration,
  ) async {
    final companion = db.ChatConfigurationsCompanion(
      chatId: Value(configuration.chatId),
      language: Value(configuration.language.value),
      difficulty: Value(configuration.difficulty.value),
      topic: Value(configuration.topic),
      createdAt: Value(configuration.createdAt),
      updatedAt: Value(configuration.updatedAt),
    );

    await _dao.upsert(companion);
    return configuration;
  }

  @override
  Future<void> deleteByChatId(String chatId) {
    return _dao.deleteByChatId(chatId);
  }

  model.ChatConfiguration _mapToDomain(db.ChatConfiguration row) {
    final language = SessionLanguage.fromValue(row.language);
    final difficulty = SessionDifficultyLevel.fromValue(row.difficulty);

    if (language == null) {
      throw StateError('Не удалось распарсить язык ${row.language}');
    }
    if (difficulty == null) {
      throw StateError('Не удалось распарсить уровень ${row.difficulty}');
    }

    return model.ChatConfiguration(
      chatId: row.chatId,
      language: language,
      difficulty: difficulty,
      topic: row.topic,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
