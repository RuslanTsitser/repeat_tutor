abstract interface class GptService {
  /// Создает сессию в OpenAI API
  Future<CreateSessionResult> createSession(String prompt);

  /// Отправляет Offer в OpenAI API
  /// Возвращает Answer в формате SDP
  Future<String> sendOffer(String offer, String clientSecret);

  /// Отправляет сообщение в OpenAI API
  Future<ConversationMessage> sendMessage({
    required String systemPrompt,
    String? previousMessageId,
    String? text,
    String? audioBase64,
  });

  /// Отправляет аудио в OpenAI API
  Future<String> sendAudio(String filePath);

  /// Отправляет ответ на вопрос от юзера
  Future<TutorAnswer> getTutorAnswer({
    required String systemPrompt,
    required String text,
    String? previousMessageId,
  });
}

class CreateSessionResult {
  const CreateSessionResult({
    required this.sessionId,
    required this.clientSecret,
    required this.clientSecretExpiresAt,
  });
  final String sessionId;
  final String clientSecret;
  final DateTime clientSecretExpiresAt;
}

class ConversationMessage {
  const ConversationMessage({
    required this.text,
    required this.id,
  });
  final String text;
  final String id;
}

class TutorAnswer {
  const TutorAnswer({
    required this.caseType,
    required this.assistantMessage,
    required this.correction,
    required this.suggestedTranslation,
    required this.userQuestionAnswer,
    required this.conversationContinue,
  });

  factory TutorAnswer.fromJson(Map<String, dynamic> json) {
    return TutorAnswer(
      caseType: CaseType.fromString(json['case_type'] as String),
      assistantMessage: json['assistant_message'] as String,
      correction: json['correction'] == null
          ? null
          : Correction.fromJson(json['correction'] as Map<String, dynamic>),
      suggestedTranslation: json['suggested_translation'] == null
          ? null
          : SuggestedTranslation.fromJson(
              json['suggested_translation'] as Map<String, dynamic>,
            ),
      userQuestionAnswer: json['user_question_answer'] == null
          ? null
          : UserQuestionAnswer.fromJson(
              json['user_question_answer'] as Map<String, dynamic>,
            ),
      conversationContinue: json['conversation_continue'] as String,
    );
  }
  final CaseType caseType;
  final String assistantMessage;
  final Correction? correction;
  final SuggestedTranslation? suggestedTranslation;
  final UserQuestionAnswer? userQuestionAnswer;
  final String conversationContinue;
}

class UserQuestionAnswer {
  const UserQuestionAnswer({
    required this.question,
    required this.answer,
  });

  factory UserQuestionAnswer.fromJson(Map<String, dynamic> json) {
    return UserQuestionAnswer(
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }
  final String question;
  final String answer;
}

class SuggestedTranslation {
  const SuggestedTranslation({
    required this.userMeaning,
    required this.translation,
  });

  factory SuggestedTranslation.fromJson(Map<String, dynamic> json) {
    return SuggestedTranslation(
      userMeaning: json['user_meaning'] as String,
      translation: json['translation'] as String,
    );
  }
  final String userMeaning;
  final String translation;
}

class Correction {
  const Correction({
    required this.original,
    required this.correctedMarkdown,
    required this.explanation,
  });

  factory Correction.fromJson(Map<String, dynamic> json) {
    return Correction(
      original: json['original'] as String,
      correctedMarkdown: json['corrected_markdown'] as String,
      explanation: json['explanation'] as String,
    );
  }
  final String original;
  final String correctedMarkdown;
  final String explanation;
}

enum CaseType {
  correctAnswer,
  correctedAnswer,
  nativeLanguageAnswer,
  offTopicAnswer,
  noAnswer,
  userQuestion,
  mixedCase;

  static CaseType fromString(String value) {
    switch (value) {
      case 'correct_answer':
        return CaseType.correctAnswer;
      case 'corrected_answer':
        return CaseType.correctedAnswer;
      case 'native_language_answer':
        return CaseType.nativeLanguageAnswer;
      case 'off_topic_answer':
        return CaseType.offTopicAnswer;
      case 'no_answer':
        return CaseType.noAnswer;
      case 'user_question':
        return CaseType.userQuestion;
      case 'mixed_case':
        return CaseType.mixedCase;
      default:
        throw ArgumentError('Unknown case_type: $value');
    }
  }
}
