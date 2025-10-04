import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'daos/chat_dao.dart';
import 'daos/message_dao.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Главный класс базы данных приложения
@DriftDatabase(
  tables: [Chats, Messages],
  daos: [ChatDao, MessageDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Создание соединения с базой данных
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'repeat_tutor');
  }

  /// Инициализация базы данных с начальными данными
  Future<void> initializeDatabase() async {
    // Создаем таблицы
    await customStatement('PRAGMA foreign_keys = ON');

    // Проверяем, есть ли уже данные в базе
    final existingChats = await chatDao.getAllChats();
    if (existingChats.isEmpty) {
      // Добавляем начальные данные только если база пустая
      await _insertInitialChats();
    }
  }

  /// Вставка начальных данных чатов
  Future<void> _insertInitialChats() async {
    final initialChats = [
      ChatsCompanion.insert(
        id: '1',
        name: 'Анна Петрова',
        lastMessage: 'Привет! Как дела?',
        time: '12:30',
        unreadCount: const Value(2),
      ),
      ChatsCompanion.insert(
        id: '2',
        name: 'Иван Сидоров',
        lastMessage: 'Спасибо за помощь с проектом',
        time: '11:45',
        unreadCount: const Value(0),
      ),
      ChatsCompanion.insert(
        id: '3',
        name: 'Мария Козлова',
        lastMessage: 'Встречаемся завтра в 15:00',
        time: '10:20',
        unreadCount: const Value(1),
      ),
      ChatsCompanion.insert(
        id: '4',
        name: 'Алексей Волков',
        lastMessage: 'Отличная работа!',
        time: '09:15',
        unreadCount: const Value(0),
      ),
      ChatsCompanion.insert(
        id: '5',
        name: 'Елена Смирнова',
        lastMessage: 'Документы готовы',
        time: 'Вчера',
        unreadCount: const Value(3),
      ),
      ChatsCompanion.insert(
        id: '6',
        name: 'Дмитрий Новиков',
        lastMessage: 'Спасибо за совет',
        time: 'Вчера',
        unreadCount: const Value(0),
      ),
      ChatsCompanion.insert(
        id: '7',
        name: 'Ольга Морозова',
        lastMessage: 'До встречи!',
        time: 'Понедельник',
        unreadCount: const Value(0),
      ),
    ];

    for (final chat in initialChats) {
      await chatDao.insertChat(chat);
    }

    // Добавляем начальные сообщения для первого чата
    await _insertInitialMessages();
  }

  /// Вставка начальных сообщений
  Future<void> _insertInitialMessages() async {
    // Проверяем, есть ли уже сообщения для первого чата
    final existingMessages = await messageDao.getMessagesByChatId('1');
    if (existingMessages.isNotEmpty) {
      return; // Сообщения уже существуют
    }

    final initialMessages = [
      MessagesCompanion.insert(
        id: '1',
        message: 'Привет! Как дела?',
        isMe: false,
        time: '12:25',
        chatId: '1',
      ),
      MessagesCompanion.insert(
        id: '2',
        message: 'Привет! Всё хорошо, спасибо! А у тебя как?',
        isMe: true,
        time: '12:26',
        chatId: '1',
      ),
      MessagesCompanion.insert(
        id: '3',
        message: 'Тоже всё отлично! Работаю над новым проектом',
        isMe: false,
        time: '12:27',
        chatId: '1',
      ),
      MessagesCompanion.insert(
        id: '4',
        message: 'Здорово! Расскажи подробнее',
        isMe: true,
        time: '12:28',
        chatId: '1',
      ),
    ];

    for (final message in initialMessages) {
      await messageDao.insertMessage(message);
    }
  }
}
