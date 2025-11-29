import 'package:equatable/equatable.dart';

import 'session_difficulty_level.dart';
import 'session_language.dart';

/// Настройки сессии для кастомизации промпта
class SessionSettings extends Equatable {
  const SessionSettings({
    required this.language,
    required this.level,
  });
  final SessionLanguage language;
  final SessionDifficultyLevel level;

  @override
  List<Object?> get props => [language, level];
}
