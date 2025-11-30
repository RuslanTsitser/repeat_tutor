import 'package:drift/drift.dart';

class Chats extends Table {
  IntColumn get chatId => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get language => text()();
  TextColumn get level => text()();
  TextColumn get topic => text()();
}

class Messages extends Table {
  IntColumn get messageId => integer().autoIncrement()();
  IntColumn get chatId => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get message => text()();
  BoolColumn get isMe => boolean()();
  TextColumn get audioPath => text().nullable()();
}

class RealtimeSessions extends Table {
  TextColumn get sessionId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get language => text()();
  TextColumn get level => text()();
  TextColumn get clientSecret => text().nullable()();
  DateTimeColumn get clientSecretExpiresAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {sessionId};
}
