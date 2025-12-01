import '../../core/realtime/realtime_audio_manager.dart';
import '../../core/realtime/realtime_webrtc_manager.dart';
import '../../presentation/notifiers/realtime_call_notifier.dart';

/// Use case для подключения к Realtime-сессии.
class ConnectRealtimeSessionUseCase {
  ConnectRealtimeSessionUseCase({
    required this.realtimeCallNotifier,
    required this.realtimeWebRTCConnection,
    required this.realtimeAudioManager,
  }) {
    _registerCallbacks();
  }

  final RealtimeCallNotifier realtimeCallNotifier;
  final RealtimeWebRTCConnection realtimeWebRTCConnection;
  final RealtimeAudioManager realtimeAudioManager;

  bool _callbacksRegistered = false;

  void _registerCallbacks() {
    if (_callbacksRegistered) return;
    _callbacksRegistered = true;

    realtimeWebRTCConnection.onMessage = (message) {
      if (message.isEmpty) return;
      realtimeCallNotifier.addReceivedMessage(message);
    };

    realtimeWebRTCConnection.onError = (error) {
      realtimeCallNotifier.setState(
        realtimeCallNotifier.state.copyWith(
          error: error.toString(),
          isConnecting: false,
        ),
      );
    };

    realtimeWebRTCConnection.onConnect = () {
      realtimeCallNotifier.setState(
        realtimeCallNotifier.state.copyWith(
          isConnected: true,
          isConnecting: false,
        ),
      );
    };

    realtimeWebRTCConnection.onDisconnect = () {
      realtimeAudioManager.stopRecording();
      realtimeAudioManager.stopPlaying();
      realtimeCallNotifier.setState(
        realtimeCallNotifier.state.copyWith(
          isConnected: false,
          isConnecting: false,
          isRecording: false,
          isPlaying: false,
        ),
      );
    };

    realtimeWebRTCConnection.onAudioTrackReady = () {
      realtimeCallNotifier.setState(
        realtimeCallNotifier.state.copyWith(
          isPlaying: true,
        ),
      );
    };

    realtimeAudioManager.onAudioLevel = (level) {
      realtimeCallNotifier.setState(
        realtimeCallNotifier.state.copyWith(
          audioLevel: level,
        ),
      );
    };

    realtimeAudioManager.onAudioDataBase64 = (data) {
      if (!realtimeWebRTCConnection.isConnected) return;
      realtimeWebRTCConnection.sendAudioChunk(data);
      realtimeWebRTCConnection.commitAudio();
    };
  }

  Future<void> execute() async {
    final currentState = realtimeCallNotifier.state;
    if (currentState.isConnecting || currentState.isConnected) return;

    final session = currentState.session;
    if (session == null) {
      realtimeCallNotifier.setState(
        currentState.copyWith(
          error: 'Сессия не выбрана',
        ),
      );
      return;
    }

    if (!session.isClientSecretValid || session.clientSecret == null) {
      realtimeCallNotifier.setState(
        currentState.copyWith(
          error: 'Секрет сессии недоступен. Обновите сессию.',
        ),
      );
      return;
    }

    realtimeCallNotifier.setState(
      currentState.copyWith(
        isConnecting: true,
        error: null,
      ),
    );

    try {
      await realtimeWebRTCConnection.connect(
        clientSecret: session.clientSecret!,
        sessionId: session.id,
      );

      await realtimeAudioManager.startRecording();
      realtimeCallNotifier.setState(
        realtimeCallNotifier.state.copyWith(
          isRecording: true,
        ),
      );
    } catch (e) {
      realtimeCallNotifier.setState(
        realtimeCallNotifier.state.copyWith(
          isConnecting: false,
          error: e.toString(),
        ),
      );
    }
  }
}
