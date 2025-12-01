import '../../core/realtime/realtime_audio_manager.dart';
import '../../core/realtime/realtime_webrtc_manager.dart';
import '../../presentation/notifiers/realtime_call_notifier.dart';

/// Use case для отключения от Realtime-сессии.
class DisconnectRealtimeSessionUseCase {
  const DisconnectRealtimeSessionUseCase({
    required this.realtimeCallNotifier,
    required this.realtimeWebRTCConnection,
    required this.realtimeAudioManager,
  });

  final RealtimeCallNotifier realtimeCallNotifier;
  final RealtimeWebRTCConnection realtimeWebRTCConnection;
  final RealtimeAudioManager realtimeAudioManager;

  Future<void> execute() async {
    realtimeAudioManager.stopRecording();
    realtimeAudioManager.stopPlaying();
    realtimeWebRTCConnection.disconnect();

    realtimeCallNotifier.setState(
      realtimeCallNotifier.state.copyWith(
        isConnected: false,
        isConnecting: false,
        isRecording: false,
        isPlaying: false,
        audioLevel: 0,
      ),
    );
  }
}
