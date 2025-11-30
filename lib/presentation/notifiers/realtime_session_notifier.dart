import 'package:flutter/foundation.dart';

import '../../domain/models/realtime_session.dart';

/// Нотатор для управления списком сессий Realtime API
class RealtimeSessionListNotifier extends ChangeNotifier {
  RealtimeSessionListNotifier();

  List<RealtimeSession> _sessions = [];
  bool _isLoading = false;
  String? _error;

  List<RealtimeSession> get sessions => _sessions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setSessions(List<RealtimeSession> value) {
    _sessions = value;
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
