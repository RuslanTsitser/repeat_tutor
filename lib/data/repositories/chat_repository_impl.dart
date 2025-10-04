import '../../domain/models/chat.dart';
import '../../domain/repositories/chat_repository.dart';

/// Реализация репозитория для работы с чатами
class ChatRepositoryImpl implements ChatRepository {
  // Временное хранилище в памяти (в будущем можно заменить на базу данных)
  List<Chat> _chats = _initialChats;

  static const List<Chat> _initialChats = [
    Chat(
      id: '1',
      name: 'Анна Петрова',
      lastMessage: 'Привет! Как дела?',
      time: '12:30',
      unreadCount: 2,
    ),
    Chat(
      id: '2',
      name: 'Иван Сидоров',
      lastMessage: 'Спасибо за помощь с проектом',
      time: '11:45',
      unreadCount: 0,
    ),
    Chat(
      id: '3',
      name: 'Мария Козлова',
      lastMessage: 'Встречаемся завтра в 15:00',
      time: '10:20',
      unreadCount: 1,
    ),
    Chat(
      id: '4',
      name: 'Алексей Волков',
      lastMessage: 'Отличная работа!',
      time: '09:15',
      unreadCount: 0,
    ),
    Chat(
      id: '5',
      name: 'Елена Смирнова',
      lastMessage: 'Документы готовы',
      time: 'Вчера',
      unreadCount: 3,
    ),
    Chat(
      id: '6',
      name: 'Дмитрий Новиков',
      lastMessage: 'Спасибо за совет',
      time: 'Вчера',
      unreadCount: 0,
    ),
    Chat(
      id: '7',
      name: 'Ольга Морозова',
      lastMessage: 'До встречи!',
      time: 'Понедельник',
      unreadCount: 0,
    ),
  ];

  @override
  Future<List<Chat>> getChats() async {
    // Имитация задержки сети
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return List.from(_chats);
  }

  @override
  Future<Chat?> getChatById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    try {
      return _chats.firstWhere((chat) => chat.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateLastMessage(
    String chatId,
    String message,
    String time,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    _chats = _chats.map((chat) {
      if (chat.id == chatId) {
        return chat.copyWith(
          lastMessage: message,
          time: time,
          unreadCount: chat.unreadCount + 1,
        );
      }
      return chat;
    }).toList();
  }

  @override
  Future<void> markAsRead(String chatId) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    _chats = _chats.map((chat) {
      if (chat.id == chatId) {
        return chat.copyWith(unreadCount: 0);
      }
      return chat;
    }).toList();
  }

  @override
  Future<Chat> createChat(Chat chat) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    _chats = [..._chats, chat];
    return chat;
  }

  @override
  Future<void> deleteChat(String chatId) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    _chats.removeWhere((chat) => chat.id == chatId);
  }
}
