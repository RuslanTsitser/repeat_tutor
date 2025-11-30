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
  TextColumn get contentType => text().withDefault(const Constant('text'))();
  TextColumn get audioPath => text().nullable()();
  TextColumn get transcription => text().nullable()();
  TextColumn get corrections => text().nullable()();
  TextColumn get language => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

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

/// Дополнительные настройки для практических чатов
class ChatConfigurations extends Table {
  TextColumn get chatId => text()();
  TextColumn get language => text()();
  TextColumn get difficulty => text()();
  TextColumn get topic => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {chatId};
}
