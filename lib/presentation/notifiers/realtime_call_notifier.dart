import 'package:flutter/foundation.dart';

import '../../core/realtime/realtime_audio_manager.dart';
import '../../core/realtime/realtime_webrtc_manager.dart';
import '../../domain/models/realtime_session.dart';

/// Нотатор для управления состоянием звонка Realtime API
/// Хранит только состояние UI, не содержит бизнес-логику
class RealtimeCallNotifier extends ChangeNotifier {
  RealtimeCallNotifier({
    required this.connection,
    required this.audioManager,
    required this.session,
  }) {
    _setupCallbacks();
  }

  final RealtimeWebRTCConnection connection;
  final RealtimeAudioManager audioManager;
  RealtimeSession session;

  /// Колбэк для начала записи после подключения
  Future<void> Function()? onConnectCallback;

  /// Колбэк для остановки записи при отключении
  void Function()? onDisconnectCallback;

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

  void _setupCallbacks() {
    connection.onMessage = (message) {
      _receivedMessages = [..._receivedMessages, message];
      notifyListeners();
    };

    connection.onAudioTrackReady = () {
      // Аудио трек готов к воспроизведению
      notifyListeners();
    };

    connection.onError = (error) {
      _error = error.toString();
      _isConnected = false;
      _isConnecting = false;
      notifyListeners();
    };

    connection.onConnect = () {
      _isConnected = true;
      _isConnecting = false;
      _error = null;
      notifyListeners();
      // Начинаем запись после подключения через колбэк
      if (!_isRecording && onConnectCallback != null) {
        onConnectCallback!();
      }
    };

    connection.onDataChannelReady = () {
      // Data channel готов, можно начинать отправку данных
      notifyListeners();
    };

    connection.onDisconnect = () {
      _isConnected = false;
      _isConnecting = false;
      _isPlaying = false;
      if (onDisconnectCallback != null) {
        onDisconnectCallback!();
      }
      notifyListeners();
    };

    audioManager.onAudioDataBase64 = (base64) {
      try {
        connection.sendAudioChunk(base64);
      } catch (e) {
        // Игнорируем ошибки, если data channel еще не готов
        if (!e.toString().contains('Data channel не готов')) {
          _error = 'Ошибка отправки аудио: ${e.toString()}';
          notifyListeners();
        }
      }
    };

    audioManager.onAudioLevel = (level) {
      _audioLevel = level;
      notifyListeners();
    };
  }

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

  @override
  void dispose() {
    connection.onMessage = null;
    connection.onError = null;
    connection.onConnect = null;
    connection.onDisconnect = null;
    connection.onAudioTrackReady = null;
    connection.onDataChannelReady = null;
    audioManager.onAudioDataBase64 = null;
    audioManager.onAudioLevel = null;
    super.dispose();
  }
}
