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

  void addReceivedMessage(String message) {
    setState(
      _state.copyWith(
        receivedMessages: [..._state.receivedMessages, message],
      ),
    );
  }
}

class RealtimeCallState {
  const RealtimeCallState({
    required this.session,
    required this.isConnected,
    required this.isConnecting,
    required this.isRecording,
    required this.isPlaying,
    required this.audioLevel,
    required this.receivedMessages,
    required this.error,
  });

  factory RealtimeCallState.initial() {
    return const RealtimeCallState(
      session: null,
      isConnected: false,
      isConnecting: false,
      isRecording: false,
      isPlaying: false,
      audioLevel: 0,
      receivedMessages: [],
      error: null,
    );
  }

  static const Object _errorSentinel = Object();
  static const Object _sessionSentinel = Object();

  final RealtimeSession? session;
  final bool isConnected;
  final bool isConnecting;
  final bool isRecording;
  final bool isPlaying;
  final double audioLevel;
  final List<String> receivedMessages;
  final String? error;

  RealtimeCallState copyWith({
    Object? session = _sessionSentinel,
    bool? isConnected,
    bool? isConnecting,
    bool? isRecording,
    bool? isPlaying,
    double? audioLevel,
    List<String>? receivedMessages,
    Object? error = _errorSentinel,
  }) {
    return RealtimeCallState(
      session: identical(session, _sessionSentinel)
          ? this.session
          : session as RealtimeSession?,
      isConnected: isConnected ?? this.isConnected,
      isConnecting: isConnecting ?? this.isConnecting,
      isRecording: isRecording ?? this.isRecording,
      isPlaying: isPlaying ?? this.isPlaying,
      audioLevel: audioLevel ?? this.audioLevel,
      receivedMessages: receivedMessages ?? this.receivedMessages,
      error: identical(error, _errorSentinel) ? this.error : error as String?,
    );
  }
}
