import 'package:drift/drift.dart';

import 'daos/chat_configuration_dao.dart';
import 'daos/chat_dao.dart';
import 'daos/message_dao.dart';
import 'daos/realtime_session_dao.dart';
import 'open_connection/open_db_connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Главный класс базы данных приложения
@DriftDatabase(
  tables: [Chats, Messages, RealtimeSessions, ChatConfigurations],
  daos: [ChatDao, MessageDao, RealtimeSessionDao, ChatConfigurationDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openDbConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 3) {
        await m.createTable(chatConfigurations);
        await m.addColumn(messages, messages.contentType);
        await m.addColumn(messages, messages.audioPath);
        await m.addColumn(messages, messages.transcription);
        await m.addColumn(messages, messages.corrections);
        await m.addColumn(messages, messages.language);
        await m.addColumn(messages, messages.createdAt);
      }
    },
  );
}
