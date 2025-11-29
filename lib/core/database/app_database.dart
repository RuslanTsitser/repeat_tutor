import 'package:drift/drift.dart';

import 'daos/chat_dao.dart';
import 'daos/message_dao.dart';
import 'daos/realtime_session_dao.dart';
import 'open_connection/open_db_connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Главный класс базы данных приложения
@DriftDatabase(
  tables: [Chats, Messages, RealtimeSessions],
  daos: [ChatDao, MessageDao, RealtimeSessionDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openDbConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
  );
}
