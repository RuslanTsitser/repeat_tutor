import 'package:drift/drift.dart';

class Chats extends Table {
  TextColumn get chatId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get language => text()();
  TextColumn get level => text()();
  TextColumn get topic => text()();

  @override
  Set<Column> get primaryKey => {chatId};
}

class Messages extends Table {
  TextColumn get messageId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get message => text()();
  BoolColumn get isMe => boolean()();
  TextColumn get chatId => text()();
  TextColumn get audioPath => text().nullable()();

  @override
  Set<Column> get primaryKey => {messageId};
}

class RealtimeSessions extends Table {
  TextColumn get sessionId => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get language => text()();
  TextColumn get level => text()();
  TextColumn get clientSecret => text().nullable()();
  DateTimeColumn get clientSecretExpiresAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {sessionId};
}
