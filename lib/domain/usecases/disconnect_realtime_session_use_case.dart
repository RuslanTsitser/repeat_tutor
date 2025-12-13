import '../../core/realtime/realtime_webrtc_manager.dart';
import '../../presentation/notifiers/realtime_call_notifier.dart';

/// Use case для отключения от Realtime-сессии.
class DisconnectRealtimeSessionUseCase {
  const DisconnectRealtimeSessionUseCase({
    required this.realtimeCallNotifier,
    required this.realtimeWebRTCConnection,
  });

  final RealtimeCallNotifier realtimeCallNotifier;
  final RealtimeWebRTCConnection realtimeWebRTCConnection;

  Future<void> execute() async {
    realtimeWebRTCConnection.disconnect();

    realtimeCallNotifier.setState(
      realtimeCallNotifier.state.copyWith(
        isConnected: false,
        isConnecting: false,
        isRecording: false,
      ),
    );
  }
}
