import 'package:flutter/cupertino.dart';

import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';

class CreateChatNotifier extends ChangeNotifier {
  CreateChatNotifier();

  CreateChatState _state = CreateChatState.initial();
  CreateChatState get state => _state;

  void setState(CreateChatState value) {
    _state = value;
    notifyListeners();
  }
}

class CreateChatState {
  factory CreateChatState.initial() {
    return const CreateChatState(
      language: Language.english,
      level: DifficultyLevel.beginner,
      teacherLanguage: null,
      topic: '',
    );
  }
  const CreateChatState({
    required this.language,
    required this.level,
    required this.teacherLanguage,
    required this.topic,
  });
  final Language language;
  final DifficultyLevel level;
  final Language? teacherLanguage;
  final String topic;

  CreateChatState copyWith({
    Language? language,
    DifficultyLevel? level,
    Language? teacherLanguage,
    String? topic,
  }) {
    return CreateChatState(
      language: language ?? this.language,
      level: level ?? this.level,
      teacherLanguage: teacherLanguage ?? this.teacherLanguage,
      topic: topic ?? this.topic,
    );
  }
}
