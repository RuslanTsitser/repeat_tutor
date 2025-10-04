import '../../domain/models/message.dart';
import '../../domain/repositories/message_repository.dart';

/// Реализация репозитория для работы с сообщениями
class MessageRepositoryImpl implements MessageRepository {
  // Временное хранилище в памяти (в будущем можно заменить на базу данных)
  final Map<String, List<Message>> _messagesByChatId = {};

  /// Получить начальные сообщения для чата
  static List<Message> _getInitialMessages(String chatId) {
    return [
      Message(
        id: '1',
        text: 'Привет! Как дела?',
        isMe: false,
        time: '12:25',
        chatId: chatId,
      ),
      Message(
        id: '2',
        text: 'Привет! Всё хорошо, спасибо! А у тебя как?',
        isMe: true,
        time: '12:26',
        chatId: chatId,
      ),
      Message(
        id: '3',
        text: 'Тоже всё отлично! Работаю над новым проектом',
        isMe: false,
        time: '12:27',
        chatId: chatId,
      ),
      Message(
        id: '4',
        text: 'Здорово! Расскажи подробнее',
        isMe: true,
        time: '12:28',
        chatId: chatId,
      ),
    ];
  }

  @override
  Future<List<Message>> getMessagesByChatId(String chatId) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    
    if (!_messagesByChatId.containsKey(chatId)) {
      _messagesByChatId[chatId] = _getInitialMessages(chatId);
    }
    
    return List.from(_messagesByChatId[chatId]!);
  }

  @override
  Future<Message?> getMessageById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    
    for (final messages in _messagesByChatId.values) {
      try {
        return messages.firstWhere((message) => message.id == id);
      } catch (e) {
        continue;
      }
    }
    return null;
  }

  @override
  Future<Message> addMessage(Message message) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    
    if (!_messagesByChatId.containsKey(message.chatId)) {
      _messagesByChatId[message.chatId] = [];
    }
    
    _messagesByChatId[message.chatId]!.add(message);
    return message;
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    
    for (final messages in _messagesByChatId.values) {
      messages.removeWhere((message) => message.id == messageId);
    }
  }

  @override
  Future<void> clearMessages(String chatId) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    _messagesByChatId[chatId]?.clear();
  }

  @override
  Future<Message> updateMessage(Message message) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    
    final messages = _messagesByChatId[message.chatId];
    if (messages != null) {
      final index = messages.indexWhere((m) => m.id == message.id);
      if (index != -1) {
        messages[index] = message;
      }
    }
    
    return message;
  }
}
