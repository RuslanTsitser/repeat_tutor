import '../../database/app_database.dart';
import '../../domain/models/message.dart';
import '../../gpt/gpt_service.dart';

abstract class MessageDbMappers {
  static Message toDomain(MessageDb message) {
    TutorAnswer? tutorAnswer;

    // Создаем TutorAnswer только если есть все обязательные поля
    if (message.caseType != null &&
        message.assistantMessage != null &&
        message.conversationContinue != null) {
      tutorAnswer = TutorAnswer(
        caseType: CaseType.fromString(message.caseType!),
        assistantMessage: message.assistantMessage!,
        correction:
            message.correctionOriginal != null &&
                message.correctionCorrectedMarkdown != null &&
                message.correctionExplanation != null
            ? Correction(
                original: message.correctionOriginal!,
                correctedMarkdown: message.correctionCorrectedMarkdown!,
                explanation: message.correctionExplanation!,
              )
            : null,
        suggestedTranslation:
            message.suggestedTranslationUserMeaning != null &&
                message.suggestedTranslationTranslation != null
            ? SuggestedTranslation(
                userMeaning: message.suggestedTranslationUserMeaning!,
                translation: message.suggestedTranslationTranslation!,
              )
            : null,
        userQuestionAnswer:
            message.userQuestionAnswerQuestion != null &&
                message.userQuestionAnswerAnswer != null
            ? UserQuestionAnswer(
                question: message.userQuestionAnswerQuestion!,
                answer: message.userQuestionAnswerAnswer!,
              )
            : null,
        conversationContinue: message.conversationContinue!,
      );
    }

    return Message(
      id: message.messageId,
      gptResponseId: message.gptResponseId,
      text: message.message,
      chatId: message.chatId,
      createdAt: message.createdAt,
      tutorAnswer: tutorAnswer,
    );
  }

  static MessageDb toDb(Message message) {
    return MessageDb(
      messageId: message.id,
      gptResponseId: message.gptResponseId,
      message: message.text,
      chatId: message.chatId,
      createdAt: message.createdAt,
      caseType: message.tutorAnswer?.caseType.toStringValue(),
      assistantMessage: message.tutorAnswer?.assistantMessage,
      correctionOriginal: message.tutorAnswer?.correction?.original,
      correctionCorrectedMarkdown:
          message.tutorAnswer?.correction?.correctedMarkdown,
      correctionExplanation: message.tutorAnswer?.correction?.explanation,
      suggestedTranslationUserMeaning:
          message.tutorAnswer?.suggestedTranslation?.userMeaning,
      suggestedTranslationTranslation:
          message.tutorAnswer?.suggestedTranslation?.translation,
      userQuestionAnswerQuestion:
          message.tutorAnswer?.userQuestionAnswer?.question,
      userQuestionAnswerAnswer: message.tutorAnswer?.userQuestionAnswer?.answer,
      conversationContinue: message.tutorAnswer?.conversationContinue,
    );
  }
}
