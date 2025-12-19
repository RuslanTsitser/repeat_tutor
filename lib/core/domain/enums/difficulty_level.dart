/// Уровни сложности
enum DifficultyLevel {
  beginner,
  intermediate,
  advanced;

  String get value {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'beginner';
      case DifficultyLevel.intermediate:
        return 'intermediate';
      case DifficultyLevel.advanced:
        return 'advanced';
    }
  }

  static DifficultyLevel? fromValue(String value) {
    switch (value) {
      case 'beginner':
        return DifficultyLevel.beginner;
      case 'intermediate':
        return DifficultyLevel.intermediate;
      case 'advanced':
        return DifficultyLevel.advanced;
      default:
        return null;
    }
  }

  String get localizedName {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'Начальный';
      case DifficultyLevel.intermediate:
        return 'Средний';
      case DifficultyLevel.advanced:
        return 'Продвинутый';
    }
  }
}
