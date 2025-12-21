import 'package:drift/drift.dart';

@DataClassName('ChatDb')
class Chats extends Table {
  IntColumn get chatId => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get language => text()();
  TextColumn get level => text()();
  TextColumn get teacherLanguage => text()();
  TextColumn get topic => text()();
}

@DataClassName('MessageDb')
class Messages extends Table {
  IntColumn get messageId => integer().autoIncrement()();
  IntColumn get chatId => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get message => text()();
  TextColumn get gptResponseId => text().nullable()();
  // --- tutor answer ---
  TextColumn get caseType => text().nullable()();
  TextColumn get assistantMessage => text().nullable()();
  TextColumn get correctionOriginal => text().nullable()();
  TextColumn get correctionCorrectedMarkdown => text().nullable()();
  TextColumn get correctionExplanation => text().nullable()();
  TextColumn get suggestedTranslationUserMeaning => text().nullable()();
  TextColumn get suggestedTranslationTranslation => text().nullable()();
  TextColumn get userQuestionAnswerQuestion => text().nullable()();
  TextColumn get userQuestionAnswerAnswer => text().nullable()();
  TextColumn get conversationContinue => text().nullable()();
  // --- end of tutor answer ---
}

@DataClassName('SessionDurationDb')
class SessionsDurations extends Table {
  IntColumn get sessionId => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get durationInMilliseconds =>
      integer().withDefault(const Constant(0))();
}

@DataClassName('SettingDb')
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {key};
}
