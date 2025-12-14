import '../../core/gpt/instructions/tutor_instruction.dart';
import 'session_difficulty_level.dart';
import 'session_language.dart';

class Chat {
  const Chat({
    required this.chatId,
    required this.topic,
    required this.language,
    required this.level,
    required this.teacherLanguage,
    required this.createdAt,
    this.lastMessage,
  });
  final int chatId;
  final String topic;
  final SessionLanguage language;
  final SessionDifficultyLevel level;
  final SessionLanguage? teacherLanguage;
  final DateTime createdAt;
  final LastMessage? lastMessage;

  String get systemPrompt => TutorInstruction.build(
    languageName: language.localizedName,
    levelName: level.localizedName,
    teacherLanguageName: teacherLanguage?.localizedName,
  );
}

class LastMessage {
  const LastMessage({
    required this.text,
    required this.id,
  });
  final String text;
  final String id;
}
