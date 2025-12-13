import 'package:flutter/foundation.dart';

import '../../domain/models/realtime_session.dart';

/// Нотифаер для управления состоянием звонка Realtime API.
class RealtimeCallNotifier extends ChangeNotifier {
  RealtimeCallNotifier();

  RealtimeCallState _state = RealtimeCallState.initial();
  RealtimeCallState get state => _state;

  void setState(RealtimeCallState value) {
    _state = value;
    notifyListeners();
  }
}

class RealtimeCallState {
  const RealtimeCallState({
    required this.session,
    required this.isConnected,
    required this.isConnecting,
    required this.isRecording,
    required this.error,
  });

  factory RealtimeCallState.initial() {
    return const RealtimeCallState(
      session: null,
      isConnected: false,
      isConnecting: false,
      isRecording: false,
      error: null,
    );
  }

  static const Object _errorSentinel = Object();
  static const Object _sessionSentinel = Object();

  final RealtimeSession? session;
  final bool isConnected;
  final bool isConnecting;
  final bool isRecording;
  final String? error;

  RealtimeCallState copyWith({
    Object? session = _sessionSentinel,
    bool? isConnected,
    bool? isConnecting,
    bool? isRecording,
    Object? error = _errorSentinel,
  }) {
    return RealtimeCallState(
      session: identical(session, _sessionSentinel)
          ? this.session
          : session as RealtimeSession?,
      isConnected: isConnected ?? this.isConnected,
      isConnecting: isConnecting ?? this.isConnecting,
      isRecording: isRecording ?? this.isRecording,
      error: identical(error, _errorSentinel) ? this.error : error as String?,
    );
  }
}
