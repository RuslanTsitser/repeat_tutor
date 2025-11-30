import 'package:equatable/equatable.dart';

import 'session_difficulty_level.dart';
import 'session_language.dart';

/// Конфигурация практического чата
class ChatConfiguration extends Equatable {
  const ChatConfiguration({
    required this.chatId,
    required this.language,
    required this.difficulty,
    required this.topic,
    required this.createdAt,
    required this.updatedAt,
  });

  final String chatId;
  final SessionLanguage language;
  final SessionDifficultyLevel difficulty;
  final String topic;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatConfiguration copyWith({
    SessionLanguage? language,
    SessionDifficultyLevel? difficulty,
    String? topic,
    DateTime? updatedAt,
  }) {
    return ChatConfiguration(
      chatId: chatId,
      language: language ?? this.language,
      difficulty: difficulty ?? this.difficulty,
      topic: topic ?? this.topic,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    chatId,
    language,
    difficulty,
    topic,
    createdAt,
    updatedAt,
  ];
}
