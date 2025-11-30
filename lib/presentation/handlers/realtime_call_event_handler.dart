import '../../core/realtime/realtime_audio_manager.dart';
import '../../core/realtime/realtime_webrtc_manager.dart';
import '../../domain/usecases/connect_realtime_with_permission_usecase.dart';
import '../../domain/usecases/disconnect_realtime_call_usecase.dart';
import '../../domain/usecases/start_recording_usecase.dart';
import '../../domain/usecases/stop_recording_usecase.dart';
import '../notifiers/realtime_call_notifier.dart';

/// Обработчик событий для RealtimeCallNotifier
/// Управляет подписками на события connection и audioManager
class RealtimeCallEventHandler {
  RealtimeCallEventHandler({
    required this.notifier,
    required this.connection,
    required this.audioManager,
    required this.connectWithPermissionUseCase,
    required this.disconnectUseCase,
    required this.startRecordingUseCase,
    required this.stopRecordingUseCase,
  }) {
    _setupCallbacks();
  }

  final RealtimeCallNotifier notifier;
  final RealtimeWebRTCConnection connection;
  final RealtimeAudioManager audioManager;
  final ConnectRealtimeWithPermissionUseCase connectWithPermissionUseCase;
  final DisconnectRealtimeCallUseCase disconnectUseCase;
  final StartRecordingUseCase startRecordingUseCase;
  final StopRecordingUseCase stopRecordingUseCase;

  void _setupCallbacks() {
    connection.onMessage = (message) {
      notifier.addReceivedMessage(message);
    };

    connection.onAudioTrackReady = () {
      // Аудио трек готов к воспроизведению
      notifier.setPlaying(true);
    };

    connection.onError = (error) {
      notifier.setError(error.toString());
      notifier.setConnected(false);
      notifier.setConnecting(false);
    };

    connection.onConnect = () {
      notifier.setConnected(true);
      notifier.setConnecting(false);
      notifier.setError(null);
      // Начинаем запись после подключения
      if (!notifier.isRecording) {
        startRecordingInternal();
      }
    };

    connection.onDataChannelReady = () {
      // Data channel готов, можно начинать отправку данных
      // Состояние уже обновлено через onConnect
    };

    connection.onDisconnect = () {
      notifier.setConnected(false);
      notifier.setConnecting(false);
      notifier.setPlaying(false);
      // Останавливаем запись при отключении
      stopRecordingInternal();
    };

    audioManager.onAudioDataBase64 = (base64) {
      try {
        connection.sendAudioChunk(base64);
      } catch (e) {
        // Игнорируем ошибки, если data channel еще не готов
        if (!e.toString().contains('Data channel не готов')) {
          notifier.setError('Ошибка отправки аудио: ${e.toString()}');
        }
      }
    };

    audioManager.onAudioLevel = (level) {
      notifier.setAudioLevel(level);
    };
  }

  void dispose() {
    connection.onMessage = null;
    connection.onError = null;
    connection.onConnect = null;
    connection.onDisconnect = null;
    connection.onAudioTrackReady = null;
    connection.onDataChannelReady = null;
    audioManager.onAudioDataBase64 = null;
    audioManager.onAudioLevel = null;
  }

  /// Обработка события подключения
  Future<void> onConnectPressed() async {
    if (notifier.isConnecting || notifier.isConnected) return;

    notifier.setConnecting(true);
    notifier.setError(null);

    try {
      final newSession = await connectWithPermissionUseCase.execute(
        notifier.session,
      );
      if (newSession != null) {
        notifier.setSession(newSession);
      }
      // Состояние подключения устанавливается через колбэк connection.onConnect
    } catch (e) {
      notifier.setError(e.toString());
      notifier.setConnecting(false);
    }
  }

  /// Обработка события отключения
  void onDisconnectPressed() {
    disconnectUseCase.execute();
    // Состояние отключения устанавливается через колбэк connection.onDisconnect
  }

  /// Обработка события начала записи
  Future<void> onStartRecordingPressed() async {
    try {
      await startRecordingUseCase.execute();
      notifier.setRecording(true);
      notifier.setError(null);
    } catch (e) {
      notifier.setRecording(false);
      notifier.setError(e.toString());
    }
  }

  /// Обработка события остановки записи
  void onStopRecordingPressed() {
    try {
      stopRecordingUseCase.execute();
      notifier.setRecording(false);
      notifier.setAudioLevel(0.0);
    } catch (e) {
      notifier.setError('Ошибка завершения аудио: ${e.toString()}');
    }
  }

  /// Внутренний метод для начала записи (используется в колбэках)
  Future<void> startRecordingInternal() async {
    try {
      await startRecordingUseCase.execute();
      notifier.setRecording(true);
      notifier.setError(null);
    } catch (e) {
      notifier.setRecording(false);
      notifier.setError(e.toString());
    }
  }

  /// Внутренний метод для остановки записи (используется в колбэках)
  void stopRecordingInternal() {
    try {
      stopRecordingUseCase.execute();
      notifier.setRecording(false);
      notifier.setAudioLevel(0.0);
    } catch (e) {
      notifier.setError('Ошибка завершения аудио: ${e.toString()}');
    }
  }
}
