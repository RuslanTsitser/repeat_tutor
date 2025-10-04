import 'package:flutter/foundation.dart';

import '../../domain/models/message.dart';
import '../../domain/repositories/message_repository.dart';

class MessageNotifier extends ChangeNotifier {
  MessageNotifier(this.chatId, this._messageRepository);

  final String chatId;
  final MessageRepository _messageRepository;
  List<Message> _messages = [];
  bool _isLoading = false;
  String? _error;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Загрузить сообщения для чата
  Future<void> loadMessages() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _messages = await _messageRepository.getMessagesByChatId(chatId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Добавить новое сообщение
  Future<void> addMessage(String text) async {
    if (text.trim().isEmpty) return;

    final now = DateTime.now();
    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      isMe: true,
      time: time,
      chatId: chatId,
    );

    try {
      await _messageRepository.addMessage(message);
      await loadMessages(); // Перезагружаем сообщения
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Очистить все сообщения в чате
  Future<void> clearMessages() async {
    try {
      await _messageRepository.clearMessages(chatId);
      await loadMessages(); // Перезагружаем сообщения
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Удалить сообщение
  Future<void> deleteMessage(String messageId) async {
    try {
      await _messageRepository.deleteMessage(messageId);
      await loadMessages(); // Перезагружаем сообщения
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Обновить сообщение
  Future<void> updateMessage(Message message) async {
    try {
      await _messageRepository.updateMessage(message);
      await loadMessages(); // Перезагружаем сообщения
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
