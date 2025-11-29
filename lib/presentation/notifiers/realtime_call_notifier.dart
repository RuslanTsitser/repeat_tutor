import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/models/realtime_session.dart';
import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';
import '../../domain/models/session_settings.dart';
import '../../domain/repositories/realtime_session_repository.dart';
import '../../domain/usecases/connect_realtime_webrtc_usecase.dart';
import '../../domain/usecases/create_realtime_session_usecase.dart';
import '../../domain/usecases/delete_realtime_session_usecase.dart';
import '../../infrastructure/realtime/realtime_audio_manager.dart';
import '../../infrastructure/realtime/realtime_webrtc_manager.dart';

/// Нотатор для управления звонком Realtime API
class RealtimeCallNotifier extends ChangeNotifier {
  RealtimeCallNotifier({
    required this.connection,
    required this.audioManager,
    required this.connectUseCase,
    required this.sessionRepository,
    required this.createSessionUseCase,
    required this.deleteSessionUseCase,
    required this.session,
  }) {
    _setupCallbacks();
  }
  final RealtimeWebRTCConnection connection;
  final RealtimeAudioManager audioManager;
  final ConnectRealtimeWebRTCUseCase connectUseCase;
  final RealtimeSessionRepository sessionRepository;
  final CreateRealtimeSessionUseCase createSessionUseCase;
  final DeleteRealtimeSessionUseCase deleteSessionUseCase;

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
        startRecording();
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
      stopRecording();
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

    // Сначала запрашиваем разрешение на микрофон
    try {
      var status = await Permission.microphone.status;
      if (!status.isGranted) {
        status = await Permission.microphone.request();
      }

      if (!status.isGranted) {
        _isConnecting = false;
        if (status.isPermanentlyDenied) {
          await openAppSettings();
          _error =
              'Разрешение на микрофон было отклонено навсегда. '
              'Пожалуйста, включите его в настройках приложения и попробуйте снова.';
        } else {
          _error =
              'Для работы реалтайм звонков необходимо разрешение на микрофон. '
              'Пожалуйста, предоставьте доступ к микрофону.';
        }
        notifyListeners();
        return;
      }
    } catch (e) {
      _isConnecting = false;
      _error = 'Ошибка при запросе разрешения на микрофон: ${e.toString()}';
      notifyListeners();
      return;
    }

    if (session.clientSecret == null || !session.isClientSecretValid) {
      // Если секрет истек, создаем новую сессию
      await _replaceExpiredSession();
      return;
    }

    try {
      await connectUseCase.execute(
        sessionId: session.id,
        clientSecret: session.clientSecret!,
      );
    } catch (e) {
      _error = e.toString();
      _isConnecting = false;
      notifyListeners();
    }
  }

  /// Заменить истекшую сессию
  Future<void> _replaceExpiredSession() async {
    try {
      // Сохраняем параметры текущей сессии
      final settings = SessionSettings(
        language: session.language ?? SessionLanguage.japanese,
        level: session.level ?? SessionDifficultyLevel.beginner,
      );

      // Создаем новую сессию
      final newSession = await createSessionUseCase.execute(settings);

      // Удаляем старую сессию
      await deleteSessionUseCase.execute(session);

      // Обновляем текущую сессию
      session = newSession;
      notifyListeners();

      // Пытаемся подключиться с новой сессией
      if (newSession.clientSecret != null && newSession.isClientSecretValid) {
        await connectUseCase.execute(
          sessionId: newSession.id,
          clientSecret: newSession.clientSecret!,
        );
      } else {
        _error = 'Не удалось получить client secret';
        _isConnecting = false;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Ошибка при замене сессии: ${e.toString()}';
      _isConnecting = false;
      notifyListeners();
    }
  }

  /// Отключиться от сессии
  void disconnect() {
    connection.disconnect();
    audioManager.stopRecording();
    audioManager.stopPlaying();
    _isRecording = false;
    _isPlaying = false;
    _isConnecting = false;
    notifyListeners();
  }

  /// Отправить текстовое сообщение
  void sendMessage(String message) {
    try {
      connection.sendText(message);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Начать запись
  Future<void> startRecording() async {
    try {
      await audioManager.startRecording();
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
    audioManager.stopRecording();
    _isRecording = false;
    _audioLevel = 0.0;
    try {
      connection.commitAudio();
    } catch (e) {
      _error = 'Ошибка завершения аудио: ${e.toString()}';
      notifyListeners();
    }
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
    disconnect();
    super.dispose();
  }
}
