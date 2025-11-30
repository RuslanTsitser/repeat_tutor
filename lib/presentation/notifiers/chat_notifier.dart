import 'package:flutter/foundation.dart';

import '../../domain/models/chat.dart';

/// Нотатор для управления состоянием чатов
/// Хранит только состояние UI, не содержит бизнес-логику
class ChatNotifier extends ChangeNotifier {
  ChatNotifier();

  List<Chat> _chats = [];
  bool _isLoading = false;
  String? _error;

  List<Chat> get chats => _chats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Методы для установки состояния (вызываются из обработчика событий)

  void setChats(List<Chat> value) {
    _chats = value;
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
