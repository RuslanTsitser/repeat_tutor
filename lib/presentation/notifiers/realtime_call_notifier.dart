import 'package:flutter/foundation.dart';

import '../../domain/models/realtime_session.dart';

/// Нотифаер для управления состоянием звонка Realtime API
/// Хранит только состояние UI, не содержит бизнес-логику
class RealtimeCallNotifier extends ChangeNotifier {
  RealtimeCallNotifier({
    required this.session,
  });

  RealtimeSession session;

  bool _isConnected = false;
  bool _isConnecting = false;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _error;
  List<String> _receivedMessages = [];
  double _audioLevel = 0.0;

  bool get isConnected => _isConnected;
  bool get isConnecting => _isConnecting;
  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;
  String? get error => _error;
  List<String> get receivedMessages => _receivedMessages;
  double get audioLevel => _audioLevel;

  // Методы для установки состояния (вызываются из обработчика событий)

  void setConnecting(bool value) {
    _isConnecting = value;
    notifyListeners();
  }

  void setConnected(bool value) {
    _isConnected = value;
    notifyListeners();
  }

  void setRecording(bool value) {
    _isRecording = value;
    notifyListeners();
  }

  void setPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  void setError(String? value) {
    _error = value;
    notifyListeners();
  }

  void setSession(RealtimeSession value) {
    session = value;
    notifyListeners();
  }

  void setAudioLevel(double value) {
    _audioLevel = value;
    notifyListeners();
  }

  void addReceivedMessage(String message) {
    _receivedMessages = [..._receivedMessages, message];
    notifyListeners();
  }
}
