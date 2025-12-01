import 'package:flutter/foundation.dart';

import '../../domain/models/realtime_session.dart';

/// Нотифаер для управления списком сессий Realtime API.
class RealtimeSessionListNotifier extends ChangeNotifier {
  RealtimeSessionListNotifier();

  RealtimeSessionsState _state = RealtimeSessionsState.initial();
  RealtimeSessionsState get state => _state;

  void setState(RealtimeSessionsState value) {
    _state = value;
    notifyListeners();
  }
}

class RealtimeSessionsState {
  const RealtimeSessionsState({
    required this.sessions,
    required this.isLoading,
    required this.error,
  });

  factory RealtimeSessionsState.initial() {
    return const RealtimeSessionsState(
      sessions: [],
      isLoading: false,
      error: null,
    );
  }

  static const Object _errorSentinel = Object();

  final List<RealtimeSession> sessions;
  final bool isLoading;
  final String? error;

  RealtimeSessionsState copyWith({
    List<RealtimeSession>? sessions,
    bool? isLoading,
    Object? error = _errorSentinel,
  }) {
    return RealtimeSessionsState(
      sessions: sessions ?? this.sessions,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _errorSentinel) ? this.error : error as String?,
    );
  }
}
