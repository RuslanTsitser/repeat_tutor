import 'package:drift/drift.dart';

class Chats extends Table {
  IntColumn get chatId => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get language => text()();
  TextColumn get level => text()();
  TextColumn get teacherLanguage => text().nullable()();
  TextColumn get topic => text()();
}

class Messages extends Table {
  IntColumn get messageId => integer().autoIncrement()();
  IntColumn get chatId => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get message => text()();
  TextColumn get gptResponseId => text().nullable()();
  TextColumn get audioPath => text().nullable()();
}

class RealtimeSessions extends Table {
  TextColumn get sessionId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get language => text()();
  TextColumn get level => text()();
  TextColumn get clientSecret => text().nullable()();
  DateTimeColumn get clientSecretExpiresAt => dateTime().nullable()();
  TextColumn get topic => text().nullable()();

  @override
  Set<Column> get primaryKey => {sessionId};
}

class SessionsDurations extends Table {
  IntColumn get sessionId => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get durationInMilliseconds =>
      integer().withDefault(const Constant(0))();
}
