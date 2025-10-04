import 'package:drift/drift.dart';

import 'daos/chat_dao.dart';
import 'daos/message_dao.dart';
import 'open_connection/open_db_connection.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Главный класс базы данных приложения
@DriftDatabase(
  tables: [Chats, Messages],
  daos: [ChatDao, MessageDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openDbConnection()) {
    print('AppDatabase: Конструктор вызван');
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      print('AppDatabase: Создаем таблицы базы данных');
      await m.createAll();
      print('AppDatabase: Вставляем начальные данные');
      await _insertInitialData();
      print('AppDatabase: Инициализация базы данных завершена');
    },
  );

  /// Вставка начальных данных (вызывается только при создании базы)
  Future<void> _insertInitialData() async {
    await _insertInitialChats();
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

    print('AppDatabase: Начинаем вставку ${initialChats.length} чатов');
    for (final chat in initialChats) {
      await chatDao.insertChat(chat);
    }
    print('AppDatabase: Вставка чатов завершена');

    // Добавляем начальные сообщения для первого чата
    await _insertInitialMessages();
  }

  /// Вставка начальных сообщений
  Future<void> _insertInitialMessages() async {
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
