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
