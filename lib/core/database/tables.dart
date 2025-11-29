import 'package:drift/drift.dart';

/// Таблица чатов
class Chats extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get lastMessage => text()();
  TextColumn get time => text()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  TextColumn get avatarUrl => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Таблица сообщений
class Messages extends Table {
  TextColumn get id => text()();
  TextColumn get message => text()();
  BoolColumn get isMe => boolean()();
  TextColumn get time => text()();
  TextColumn get chatId => text()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Таблица сессий Realtime API
class RealtimeSessions extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get language => text().nullable()();
  TextColumn get level => text().nullable()();
  TextColumn get clientSecret => text().nullable()();
  DateTimeColumn get clientSecretExpiresAt => dateTime().nullable()();
  TextColumn get serverURL => text().nullable()();
  DateTimeColumn get callStartedAt => dateTime().nullable()();
  IntColumn get callDurationMinutes =>
      integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
