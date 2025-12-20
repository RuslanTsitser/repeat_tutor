import 'package:drift/drift.dart';

import 'daos/chat_dao.dart';
import 'daos/message_dao.dart';
import 'daos/sessions_durations_dao.dart';
import 'open_connection/open_db_connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Главный класс базы данных приложения
@DriftDatabase(
  tables: [Chats, Messages, SessionsDurations],
  daos: [ChatDao, MessageDao, SessionsDurationsDao],
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
    onUpgrade: (Migrator m, int from, int to) async {
      if (from == 1 && to == 2) {
        await m.addColumn(messages, messages.caseType);
        await m.addColumn(messages, messages.assistantMessage);
        await m.addColumn(messages, messages.correctionOriginal);
        await m.addColumn(messages, messages.correctionCorrectedMarkdown);
        await m.addColumn(messages, messages.correctionExplanation);
        await m.addColumn(messages, messages.suggestedTranslationUserMeaning);
        await m.addColumn(messages, messages.suggestedTranslationTranslation);
        await m.addColumn(messages, messages.userQuestionAnswerQuestion);
        await m.addColumn(messages, messages.userQuestionAnswerAnswer);
        await m.addColumn(messages, messages.conversationContinue);
      }
    },
  );
}
