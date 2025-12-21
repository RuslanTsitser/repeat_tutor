import '../enums/difficulty_level.dart';
import '../enums/language.dart';

/// Доменная модель сессии Realtime API
class RealtimeSession {
  const RealtimeSession({
    required this.createdAt,
    required this.topic,
    required this.language,
    required this.level,
    required this.teacherLanguage,
    required this.clientSecret,
  });
  final DateTime createdAt;
  final String topic;
  final Language language;
  final DifficultyLevel level;
  final Language teacherLanguage;
  final String clientSecret;
}
