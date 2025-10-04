import 'package:flutter/foundation.dart';

import '../../domain/models/chat.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatNotifier extends ChangeNotifier {
  ChatNotifier(this._chatRepository);

  final ChatRepository _chatRepository;
  List<Chat> _chats = [];
  bool _isLoading = false;
  String? _error;

  List<Chat> get chats => _chats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Загрузить список чатов
  Future<void> loadChats() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _chats = await _chatRepository.getChats();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Обновить последнее сообщение в чате
  Future<void> updateChatLastMessage(String chatId, String message, String time) async {
    try {
      await _chatRepository.updateLastMessage(chatId, message, time);
      await loadChats(); // Перезагружаем список чатов
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Отметить чат как прочитанный
  Future<void> markAsRead(String chatId) async {
    try {
      await _chatRepository.markAsRead(chatId);
      await loadChats(); // Перезагружаем список чатов
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Создать новый чат
  Future<void> createChat(Chat chat) async {
    try {
      await _chatRepository.createChat(chat);
      await loadChats(); // Перезагружаем список чатов
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Удалить чат
  Future<void> deleteChat(String chatId) async {
    try {
      await _chatRepository.deleteChat(chatId);
      await loadChats(); // Перезагружаем список чатов
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
