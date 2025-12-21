/// Уровни сложности
enum DifficultyLevel {
  beginner,
  elementary,
  intermediate,
  upperIntermediate,
  advanced,
  proficiency;

  String get value {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'beginner';
      case DifficultyLevel.elementary:
        return 'elementary';
      case DifficultyLevel.intermediate:
        return 'intermediate';
      case DifficultyLevel.upperIntermediate:
        return 'upperIntermediate';
      case DifficultyLevel.advanced:
        return 'advanced';
      case DifficultyLevel.proficiency:
        return 'proficiency';
    }
  }

  static DifficultyLevel? fromValue(String value) {
    switch (value) {
      case 'beginner':
        return DifficultyLevel.beginner;
      case 'elementary':
        return DifficultyLevel.elementary;
      case 'intermediate':
        return DifficultyLevel.intermediate;
      case 'upperIntermediate':
        return DifficultyLevel.upperIntermediate;
      case 'advanced':
        return DifficultyLevel.advanced;
      case 'proficiency':
        return DifficultyLevel.proficiency;
      default:
        return null;
    }
  }

  String get localizedName {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'Beginner A1';
      case DifficultyLevel.elementary:
        return 'Elementary A2';
      case DifficultyLevel.intermediate:
        return 'Intermediate B1';
      case DifficultyLevel.upperIntermediate:
        return 'Upper Intermediate B2';
      case DifficultyLevel.advanced:
        return 'Advanced C1';
      case DifficultyLevel.proficiency:
        return 'Proficiency C2';
    }
  }

  String get shortLocalizedName {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'A1';
      case DifficultyLevel.elementary:
        return 'A2';
      case DifficultyLevel.intermediate:
        return 'B1';
      case DifficultyLevel.upperIntermediate:
        return 'B2';
      case DifficultyLevel.advanced:
        return 'C1';
      case DifficultyLevel.proficiency:
        return 'C2';
    }
  }
}
