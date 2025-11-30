import 'package:equatable/equatable.dart';

import 'session_difficulty_level.dart';
import 'session_language.dart';

class Chat extends Equatable {
  const Chat({
    required this.chatId,
    required this.topic,
    required this.language,
    required this.level,
    required this.createdAt,
  });
  final int chatId;
  final String topic;
  final SessionLanguage language;
  final SessionDifficultyLevel level;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
    chatId,
    topic,
    language,
    level,
    createdAt,
  ];

  Chat copyWith({
    int? chatId,
    String? topic,
    SessionLanguage? language,
    SessionDifficultyLevel? level,
    DateTime? createdAt,
  }) {
    return Chat(
      chatId: chatId ?? this.chatId,
      topic: topic ?? this.topic,
      language: language ?? this.language,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
