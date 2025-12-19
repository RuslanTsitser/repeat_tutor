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
}

@DataClassName('SessionDurationDb')
class SessionsDurations extends Table {
  IntColumn get sessionId => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get durationInMilliseconds =>
      integer().withDefault(const Constant(0))();
}
