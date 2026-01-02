import '../../gpt/instructions/tutor_instruction.dart';
import '../enums/difficulty_level.dart';
import '../enums/language.dart';

class Chat {
  const Chat({
    required this.chatId,
    required this.topic,
    required this.chatLanguage,
    required this.level,
    required this.teacherLanguage,
    required this.createdAt,
    this.lastMessage,
  });
  final int chatId;
  final String topic;
  final Language chatLanguage;
  final DifficultyLevel level;
  final Language teacherLanguage;
  final DateTime createdAt;
  final LastMessage? lastMessage;

  String chattyPrompt(Language? tutorLanguage) => TutorInstruction.chattyTutor(
    languageName: chatLanguage.localizedName,
    levelName: level.value,
    teacherLanguageName:
        tutorLanguage?.localizedName ?? teacherLanguage.localizedName,
    topic: topic,
  );

  Chat copyWithLastMessage({LastMessage? lastMessage}) {
    return Chat(
      chatId: chatId,
      topic: topic,
      chatLanguage: chatLanguage,
      level: level,
      teacherLanguage: teacherLanguage,
      createdAt: createdAt,
      lastMessage: lastMessage,
    );
  }
}

class LastMessage {
  const LastMessage({
    required this.text,
    required this.id,
  });
  final String text;
  final String id;
}
