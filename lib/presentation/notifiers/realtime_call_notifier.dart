import 'package:flutter/foundation.dart';

import '../../core/realtime/realtime_audio_manager.dart';
import '../../core/realtime/realtime_webrtc_manager.dart';
import '../../domain/models/realtime_session.dart';
import '../../domain/usecases/connect_realtime_with_permission_usecase.dart';
import '../../domain/usecases/disconnect_realtime_call_usecase.dart';
import '../../domain/usecases/send_text_message_usecase.dart';
import '../../domain/usecases/start_recording_usecase.dart';
import '../../domain/usecases/stop_recording_usecase.dart';

/// Нотатор для управления звонком Realtime API
class RealtimeCallNotifier extends ChangeNotifier {
  RealtimeCallNotifier({
    required this.connection,
    required this.audioManager,
    required this.connectWithPermissionUseCase,
    required this.disconnectUseCase,
    required this.startRecordingUseCase,
    required this.stopRecordingUseCase,
    required this.sendMessageUseCase,
    required this.session,
  }) {
    _setupCallbacks();
  }
  final RealtimeWebRTCConnection connection;
  final RealtimeAudioManager audioManager;
  final ConnectRealtimeWithPermissionUseCase connectWithPermissionUseCase;
  final DisconnectRealtimeCallUseCase disconnectUseCase;
  final StartRecordingUseCase startRecordingUseCase;
  final StopRecordingUseCase stopRecordingUseCase;
  final SendTextMessageUseCase sendMessageUseCase;

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
      // Начинаем запись после подключения
      // Разрешение уже должно быть получено в методе connect()
      if (!_isRecording) {
        _startRecordingInternal();
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
      _stopRecordingInternal();
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

  /// Подключиться к сессии
  Future<void> connect() async {
    if (_isConnecting || _isConnected) return;

    _error = null;
    _isConnecting = true;
    notifyListeners();

    try {
      final newSession = await connectWithPermissionUseCase.execute(session);
      if (newSession != null) {
        session = newSession;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      _isConnecting = false;
      notifyListeners();
    }
  }

  /// Отключиться от сессии
  void disconnect() {
    disconnectUseCase.execute();
    _isRecording = false;
    _isPlaying = false;
    _isConnecting = false;
    notifyListeners();
  }

  /// Отправить текстовое сообщение
  void sendMessage(String message) {
    try {
      sendMessageUseCase.execute(message);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Начать запись
  Future<void> startRecording() async {
    try {
      await startRecordingUseCase.execute();
      _isRecording = true;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isRecording = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Остановить запись
  void stopRecording() {
    try {
      stopRecordingUseCase.execute();
      _isRecording = false;
      _audioLevel = 0.0;
      notifyListeners();
    } catch (e) {
      _error = 'Ошибка завершения аудио: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Внутренний метод для начала записи (используется в колбэках)
  Future<void> _startRecordingInternal() async {
    try {
      await startRecordingUseCase.execute();
      _isRecording = true;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isRecording = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Внутренний метод для остановки записи (используется в колбэках)
  void _stopRecordingInternal() {
    try {
      stopRecordingUseCase.execute();
      _isRecording = false;
      _audioLevel = 0.0;
    } catch (e) {
      _error = 'Ошибка завершения аудио: ${e.toString()}';
    }
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
    disconnect();
    super.dispose();
  }
}
