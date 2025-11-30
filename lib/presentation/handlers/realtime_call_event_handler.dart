import '../../core/realtime/realtime_audio_manager.dart';
import '../../core/realtime/realtime_webrtc_manager.dart';
import '../../core/router/router.dart';
import '../../domain/models/realtime_session.dart';
import '../../domain/models/session_settings.dart';
import '../../domain/usecases/connect_realtime_with_permission_usecase.dart';
import '../../domain/usecases/create_realtime_session_usecase.dart';
import '../../domain/usecases/delete_realtime_session_usecase.dart';
import '../../domain/usecases/disconnect_realtime_call_usecase.dart';
import '../../domain/usecases/get_all_realtime_sessions_usecase.dart';
import '../../domain/usecases/replace_expired_session_usecase.dart';
import '../../domain/usecases/start_recording_usecase.dart';
import '../../domain/usecases/stop_recording_usecase.dart';
import '../notifiers/realtime_call_notifier.dart';
import '../notifiers/realtime_session_notifier.dart';

/// Обработчик событий для RealtimeCallNotifier
/// Управляет подписками на события connection и audioManager
class RealtimeCallEventHandler {
  const RealtimeCallEventHandler({
    required this.router,
    required this.notifier,
    required this.realtimeSessionListNotifier,
    required this.connection,
    required this.audioManager,
    required this.connectWithPermissionUseCase,
    required this.disconnectUseCase,
    required this.startRecordingUseCase,
    required this.stopRecordingUseCase,
    required this.createSessionUseCase,
    required this.getAllSessionsUseCase,
    required this.deleteSessionUseCase,
    required this.replaceExpiredSessionUseCase,
  });

  final AppRouter router;
  final RealtimeCallNotifier notifier;
  final RealtimeSessionListNotifier realtimeSessionListNotifier;
  final RealtimeWebRTCConnection connection;
  final RealtimeAudioManager audioManager;
  final ConnectRealtimeWithPermissionUseCase connectWithPermissionUseCase;
  final DisconnectRealtimeCallUseCase disconnectUseCase;
  final StartRecordingUseCase startRecordingUseCase;
  final StopRecordingUseCase stopRecordingUseCase;
  final CreateRealtimeSessionUseCase createSessionUseCase;
  final GetAllRealtimeSessionsUseCase getAllSessionsUseCase;
  final DeleteRealtimeSessionUseCase deleteSessionUseCase;
  final ReplaceExpiredSessionUseCase replaceExpiredSessionUseCase;

  void setupWebRTCCallbacks() {
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
        notifier.session!,
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

  Future<void> onLoadSessions() async {
    realtimeSessionListNotifier.setLoading(true);
    final sessions = await getAllSessionsUseCase.execute();
    realtimeSessionListNotifier.setSessions(sessions);
    realtimeSessionListNotifier.setLoading(false);
  }

  Future<void> onCreateSession(SessionSettings settings) async {
    final session = await createSessionUseCase.execute(settings);
    notifier.setSession(session);
    await router.push(const RealtimeSessionDetailRoute());
  }

  Future<void> onDeleteSession(RealtimeSession session) async {
    await deleteSessionUseCase.execute(session);
    final sessions = await getAllSessionsUseCase.execute();
    realtimeSessionListNotifier.setSessions(sessions);
  }

  Future<void> onReplaceExpiredSession(RealtimeSession expiredSession) async {
    final session = await replaceExpiredSessionUseCase.execute(expiredSession);
    notifier.setSession(session);
  }
}
