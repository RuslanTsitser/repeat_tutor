import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../core/domain/models/realtime_session.dart';
import '../../../core/logging/app_logger.dart';
import '../../../core/realtime/realtime_webrtc_manager.dart';
import '../models/realtime_event.dart';

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

    realtimeWebRTCConnection.onMessage = _onMessage;

    realtimeWebRTCConnection.onAudioLevelChanged = (decibels, isLocal) {
      _onAudioLevelChanged(decibels, isLocal);
    };
  }

  void _onAudioLevelChanged(double decibels, bool isLocal) {
    if (isLocal) {
      setState(
        state.copyWith(myAudioLevel: decibels),
      );
    } else {
      setState(
        state.copyWith(tutorAudioLevel: decibels),
      );
    }
  }

  void _onMessage(String message) {
    try {
      final json = jsonDecode(message);
      final event = RealtimeEvent.fromJson(json as Map<String, dynamic>);
      switch (event.type) {
        case EventType.responseContentPartAdded:
          setState(
            // ignore: avoid_dynamic_calls
            state.copyWithTutorMessage(json['part']['transcript'] as String),
          );
          break;
        case EventType.responseAudioTranscriptDelta:
          final message = state.tutorMessage ?? '';
          final delta = json['delta'] as String;
          setState(
            state.copyWithTutorMessage(message + delta),
          );
          break;
        case EventType.responseAudioTranscriptDone:
          final transcript = json['transcript'] as String;
          setState(
            state.copyWithTutorMessage(transcript),
          );
          break;
        case EventType.responseDone ||
            EventType.sessionCreated ||
            EventType.rateLimitsUpdated:
          logInfo(json);
          break;
        default:
          break;
      }
    } catch (e) {
      logError(e);
    }
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
    required this.sessionId,
    required this.session,
    required this.status,
    required this.isMuted,
    required this.error,
    required this.tutorMessage,
    required this.callDuration,
    required this.myAudioLevel,
    required this.tutorAudioLevel,
  });

  factory RealtimeCallState.initial() {
    return const RealtimeCallState(
      sessionId: null,
      session: null,
      status: RealtimeCallStatus.initial,
      isMuted: false,
      error: null,
      tutorMessage: null,
      callDuration: Duration.zero,
      myAudioLevel: null,
      tutorAudioLevel: null,
    );
  }

  final int? sessionId;
  final RealtimeSession? session;
  final RealtimeCallStatus status;
  final bool isMuted;
  final String? error;
  final String? tutorMessage;
  final Duration callDuration;
  final double? myAudioLevel;
  final double? tutorAudioLevel;

  RealtimeCallState copyWith({
    int? sessionId,
    RealtimeSession? session,
    RealtimeCallStatus? status,
    bool? isMuted,
    String? error,
    String? tutorMessage,
    Duration? callDuration,
    double? myAudioLevel,
    double? tutorAudioLevel,
  }) {
    return RealtimeCallState(
      sessionId: sessionId ?? this.sessionId,
      session: session ?? this.session,
      status: status ?? this.status,
      isMuted: isMuted ?? this.isMuted,
      error: error ?? this.error,
      tutorMessage: tutorMessage ?? this.tutorMessage,
      callDuration: callDuration ?? this.callDuration,
      myAudioLevel: myAudioLevel ?? this.myAudioLevel,
      tutorAudioLevel: tutorAudioLevel ?? this.tutorAudioLevel,
    );
  }

  RealtimeCallState copyWithTutorMessage(String value) {
    return copyWith(tutorMessage: value);
  }
}
