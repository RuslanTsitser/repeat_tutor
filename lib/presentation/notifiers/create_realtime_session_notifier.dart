import 'package:flutter/foundation.dart';

import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';

/// Нотифаер для формы создания Realtime-сессии.
class CreateRealtimeSessionNotifier extends ChangeNotifier {
  CreateRealtimeSessionNotifier();

  CreateRealtimeSessionState _state = CreateRealtimeSessionState.initial();
  CreateRealtimeSessionState get state => _state;

  void setState(CreateRealtimeSessionState value) {
    _state = value;
    notifyListeners();
  }

  void selectLanguage(SessionLanguage language) {
    setState(
      _state.copyWith(
        selectedLanguage: language,
      ),
    );
  }

  void selectLevel(SessionDifficultyLevel level) {
    setState(
      _state.copyWith(
        selectedLevel: level,
      ),
    );
  }
}

class CreateRealtimeSessionState {
  factory CreateRealtimeSessionState.initial() {
    return const CreateRealtimeSessionState(
      selectedLanguage: SessionLanguage.english,
      selectedLevel: SessionDifficultyLevel.beginner,
      isLoading: false,
      error: null,
    );
  }

  const CreateRealtimeSessionState({
    required this.selectedLanguage,
    required this.selectedLevel,
    required this.isLoading,
    required this.error,
  });

  final SessionLanguage selectedLanguage;
  final SessionDifficultyLevel selectedLevel;
  final bool isLoading;
  final String? error;

  CreateRealtimeSessionState copyWith({
    SessionLanguage? selectedLanguage,
    SessionDifficultyLevel? selectedLevel,
    bool? isLoading,
    String? error,
  }) {
    return CreateRealtimeSessionState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

