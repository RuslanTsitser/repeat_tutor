import 'package:flutter/foundation.dart';

import '../../domain/models/message.dart';

/// Нотатор для управления состоянием сообщений
/// Хранит только состояние UI, не содержит бизнес-логику
class MessageNotifier extends ChangeNotifier {
  MessageNotifier({
    required this.chatId,
  });

  final String chatId;
  List<Message> _messages = [];
  bool _isLoading = false;
  String? _error;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Методы для установки состояния (вызываются из обработчика событий)

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
