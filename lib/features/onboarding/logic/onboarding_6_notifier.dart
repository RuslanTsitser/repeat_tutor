import 'package:flutter/cupertino.dart';

import '../../../core/domain/enums/difficulty_level.dart';

class Onboarding6Notifier with ChangeNotifier {
  Onboarding6Notifier();

  Onboarding6State _state = Onboarding6State.initial();
  Onboarding6State get state => _state;

  void setState(Onboarding6State value) {
    _state = value;
    notifyListeners();
  }

  void setCurrentLevel(DifficultyLevel? level) {
    setState(_state.copyWith(currentLevel: level));
  }

  void setSelectedTopic(String? topic) {
    setState(_state.copyWith(selectedTopic: topic));
  }
}

class Onboarding6State {
  factory Onboarding6State.initial() {
    return const Onboarding6State(
      currentLevel: null,
      selectedTopic: null,
    );
  }

  const Onboarding6State({
    required this.currentLevel,
    required this.selectedTopic,
  });

  final DifficultyLevel? currentLevel;
  final String? selectedTopic;

  Onboarding6State copyWith({
    DifficultyLevel? currentLevel,
    String? selectedTopic,
  }) {
    return Onboarding6State(
      currentLevel: currentLevel ?? this.currentLevel,
      selectedTopic: selectedTopic ?? this.selectedTopic,
    );
  }
}

