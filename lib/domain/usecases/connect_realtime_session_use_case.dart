import '../../core/realtime/realtime_webrtc_manager.dart';
import '../../presentation/notifiers/realtime_call_notifier.dart';

/// Use case для подключения к Realtime-сессии.
class ConnectRealtimeSessionUseCase {
  ConnectRealtimeSessionUseCase({
    required this.realtimeCallNotifier,
    required this.realtimeWebRTCConnection,
  }) {
    _registerCallbacks();
  }

  final RealtimeCallNotifier realtimeCallNotifier;
  final RealtimeWebRTCConnection realtimeWebRTCConnection;

  bool _callbacksRegistered = false;

  void _registerCallbacks() {
    if (_callbacksRegistered) return;
    _callbacksRegistered = true;

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
      realtimeCallNotifier.setState(
        realtimeCallNotifier.state.copyWith(
          isConnected: false,
          isConnecting: false,
          isRecording: false,
        ),
      );
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
