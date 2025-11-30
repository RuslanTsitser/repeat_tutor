import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'chat_configuration_dao.g.dart';

/// DAO для дополнительных настроек чатов
@DriftAccessor(tables: [ChatConfigurations])
class ChatConfigurationDao extends DatabaseAccessor<AppDatabase>
    with _$ChatConfigurationDaoMixin {
  ChatConfigurationDao(super.db);

  /// Получить все конфигурации
  Future<List<ChatConfiguration>> getAll() => select(chatConfigurations).get();

  /// Получить конфигурацию по chatId
  Future<ChatConfiguration?> getByChatId(String chatId) {
    return (select(
      chatConfigurations,
    )..where((tbl) => tbl.chatId.equals(chatId))).getSingleOrNull();
  }

  /// Создать или обновить конфигурацию
  Future<void> upsert(ChatConfigurationsCompanion configuration) {
    return into(chatConfigurations).insertOnConflictUpdate(configuration);
  }

  /// Удалить конфигурацию
  Future<void> deleteByChatId(String chatId) {
    return (delete(
      chatConfigurations,
    )..where((tbl) => tbl.chatId.equals(chatId))).go();
  }
}
