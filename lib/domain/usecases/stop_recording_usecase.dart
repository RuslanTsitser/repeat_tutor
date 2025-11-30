import '../../../core/realtime/realtime_audio_manager.dart';
import '../../../core/realtime/realtime_webrtc_manager.dart';

/// Use Case для остановки записи аудио
class StopRecordingUseCase {
  const StopRecordingUseCase({
    required this.audioManager,
    required this.connection,
  });

  final RealtimeAudioManager audioManager;
  final RealtimeWebRTCConnection connection;

  void execute() {
    audioManager.stopRecording();
    try {
      connection.commitAudio();
    } catch (e) {
      // Игнорируем ошибки, если data channel не готов
      rethrow;
    }
  }
}

