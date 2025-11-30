import 'package:flutter/foundation.dart';

import '../../domain/models/message.dart';
import '../../domain/usecases/add_message_usecase.dart';
import '../../domain/usecases/clear_messages_usecase.dart';
import '../../domain/usecases/delete_message_usecase.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/update_message_usecase.dart';

class MessageNotifier extends ChangeNotifier {
  MessageNotifier({
    required this.chatId,
    required this.getMessagesUseCase,
    required this.addMessageUseCase,
    required this.deleteMessageUseCase,
    required this.updateMessageUseCase,
    required this.clearMessagesUseCase,
  });

  final String chatId;
  final GetMessagesUseCase getMessagesUseCase;
  final AddMessageUseCase addMessageUseCase;
  final DeleteMessageUseCase deleteMessageUseCase;
  final UpdateMessageUseCase updateMessageUseCase;
  final ClearMessagesUseCase clearMessagesUseCase;
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
      _messages = await getMessagesUseCase.execute(chatId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Добавить новое сообщение
  Future<void> addMessage(String text) async {
    try {
      await addMessageUseCase.execute(chatId: chatId, text: text);
      await loadMessages(); // Перезагружаем сообщения
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Очистить все сообщения в чате
  Future<void> clearMessages() async {
    try {
      await clearMessagesUseCase.execute(chatId);
      await loadMessages(); // Перезагружаем сообщения
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Удалить сообщение
  Future<void> deleteMessage(String messageId) async {
    try {
      await deleteMessageUseCase.execute(messageId);
      await loadMessages(); // Перезагружаем сообщения
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Обновить сообщение
  Future<void> updateMessage(Message message) async {
    try {
      await updateMessageUseCase.execute(message);
      await loadMessages(); // Перезагружаем сообщения
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
