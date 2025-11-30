import 'package:equatable/equatable.dart';

import 'session_difficulty_level.dart';
import 'session_language.dart';

/// Доменная модель сессии Realtime API
class RealtimeSession extends Equatable {
  const RealtimeSession({
    required this.id,
    required this.createdAt,
    required this.language,
    required this.level,
    this.clientSecret,
    this.clientSecretExpiresAt,
  });
  final String id;
  final DateTime createdAt;
  final SessionLanguage language;
  final SessionDifficultyLevel level;
  final String? clientSecret;
  final DateTime? clientSecretExpiresAt;

  bool get isClientSecretValid {
    if (clientSecret == null || clientSecret!.isEmpty) {
      return false;
    }

    if (clientSecretExpiresAt != null) {
      return DateTime.now().isBefore(clientSecretExpiresAt!);
    }

    // Если expires_at не указан, считаем что валиден
    return true;
  }

  @override
  List<Object?> get props => [
    id,
    createdAt,
    language,
    level,
    clientSecret,
    clientSecretExpiresAt,
  ];
}
