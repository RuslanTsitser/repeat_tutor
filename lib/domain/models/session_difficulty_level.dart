/// Уровни сложности
enum SessionDifficultyLevel {
  beginner,
  intermediate,
  advanced;

  String get value {
    switch (this) {
      case SessionDifficultyLevel.beginner:
        return 'beginner';
      case SessionDifficultyLevel.intermediate:
        return 'intermediate';
      case SessionDifficultyLevel.advanced:
        return 'advanced';
    }
  }

  static SessionDifficultyLevel? fromValue(String value) {
    switch (value) {
      case 'beginner':
        return SessionDifficultyLevel.beginner;
      case 'intermediate':
        return SessionDifficultyLevel.intermediate;
      case 'advanced':
        return SessionDifficultyLevel.advanced;
      default:
        return null;
    }
  }
}
