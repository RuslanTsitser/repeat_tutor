import '../../../core/realtime/realtime_audio_manager.dart';
import '../../../core/realtime/realtime_webrtc_manager.dart';

/// Use Case для отключения от Realtime звонка
class DisconnectRealtimeCallUseCase {
  const DisconnectRealtimeCallUseCase({
    required this.connection,
    required this.audioManager,
  });

  final RealtimeWebRTCConnection connection;
  final RealtimeAudioManager audioManager;

  void execute() {
    connection.disconnect();
    audioManager.stopRecording();
    audioManager.stopPlaying();
  }
}

