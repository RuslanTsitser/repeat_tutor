import '../../domain/usecases/connect_realtime_with_permission_usecase.dart';
import '../../domain/usecases/disconnect_realtime_call_usecase.dart';
import '../../domain/usecases/send_text_message_usecase.dart';
import '../../domain/usecases/start_recording_usecase.dart';
import '../../domain/usecases/stop_recording_usecase.dart';
import '../notifiers/realtime_call_notifier.dart';

/// Обработчик событий для RealtimeCallNotifier
class RealtimeCallEventHandler {
  RealtimeCallEventHandler({
    required this.notifier,
    required this.connectWithPermissionUseCase,
    required this.disconnectUseCase,
    required this.startRecordingUseCase,
    required this.stopRecordingUseCase,
    required this.sendMessageUseCase,
  });

  final RealtimeCallNotifier notifier;
  final ConnectRealtimeWithPermissionUseCase connectWithPermissionUseCase;
  final DisconnectRealtimeCallUseCase disconnectUseCase;
  final StartRecordingUseCase startRecordingUseCase;
  final StopRecordingUseCase stopRecordingUseCase;
  final SendTextMessageUseCase sendMessageUseCase;

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

  /// Обработка события отправки сообщения
  void onSendMessagePressed(String message) {
    try {
      sendMessageUseCase.execute(message);
    } catch (e) {
      notifier.setError(e.toString());
    }
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
