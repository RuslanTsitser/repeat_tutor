import 'package:flutter/foundation.dart';

import '../../domain/models/chat.dart';
import '../../domain/models/message.dart';

/// Нотатор для управления состоянием сообщений
/// Хранит только состояние UI, не содержит бизнес-логику
class MessageNotifier extends ChangeNotifier {
  MessageNotifier();

  Chat? _chat;
  String? get chatId => _chat?.id;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // Методы для установки состояния (вызываются из обработчика событий)
  void setChat(Chat value) {
    _chat = value;
    notifyListeners();
  }

  void setMessages(List<Message> value) {
    _messages = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _error = value;
    notifyListeners();
  }
}
