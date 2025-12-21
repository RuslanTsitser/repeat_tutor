import 'package:flutter/foundation.dart';

import '../../../core/domain/models/realtime_session.dart';
import '../../../core/realtime/realtime_webrtc_manager.dart';

/// Нотифаер для управления состоянием звонка Realtime API.
class RealtimeCallNotifier extends ChangeNotifier {
  RealtimeCallNotifier({
    required this.realtimeWebRTCConnection,
  }) {
    _registerCallbacks();
  }
  final RealtimeWebRTCConnection realtimeWebRTCConnection;

  bool _callbacksRegistered = false;

  void _registerCallbacks() {
    if (_callbacksRegistered) return;
    _callbacksRegistered = true;

    realtimeWebRTCConnection.onError = (error) {
      setState(
        state.copyWith(
          error: error.toString(),
          status: RealtimeCallStatus.error,
        ),
      );
    };

    realtimeWebRTCConnection.onConnect = () {
      setState(
        state.copyWith(
          status: RealtimeCallStatus.connected,
        ),
      );
    };

    realtimeWebRTCConnection.onDisconnect = () {
      setState(
        state.copyWith(
          status: RealtimeCallStatus.disconnected,
        ),
      );
    };

    realtimeWebRTCConnection.onMuted = () {
      setState(
        state.copyWith(
          isMuted: true,
        ),
      );
    };

    realtimeWebRTCConnection.onUnMuted = () {
      setState(
        state.copyWith(
          isMuted: false,
        ),
      );
    };
  }

  RealtimeCallState _state = RealtimeCallState.initial();
  RealtimeCallState get state => _state;

  void setState(RealtimeCallState value) {
    _state = value;
    notifyListeners();
  }
}

enum RealtimeCallStatus {
  initial,
  connected,
  disconnected,
  error,
}

class RealtimeCallState {
  const RealtimeCallState({
    required this.session,
    required this.status,
    required this.isMuted,
    required this.error,
  });

  factory RealtimeCallState.initial() {
    return const RealtimeCallState(
      session: null,
      status: RealtimeCallStatus.initial,
      isMuted: false,
      error: null,
    );
  }

  final RealtimeSession? session;
  final RealtimeCallStatus status;
  final bool isMuted;
  final String? error;

  RealtimeCallState copyWith({
    RealtimeSession? session,
    RealtimeCallStatus? status,
    bool? isMuted,
    String? error,
  }) {
    return RealtimeCallState(
      session: session ?? this.session,
      status: status ?? this.status,
      isMuted: isMuted ?? this.isMuted,
      error: error ?? this.error,
    );
  }
}
