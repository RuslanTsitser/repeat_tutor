import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/permission/microphone_permission_request.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/repositories.dart';
import '../../../infrastructure/state_managers.dart';

class AddMessageUseCase {
  const AddMessageUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<void> addMessage(
    String message, {
    bool addFirstMessage = true,
  }) async {
    final chatNotifier = ref.read(chatNotifierProvider);
    final chatRepository = ref.read(chatRepositoryProvider);
    final gptService = ref.read(gptServiceProvider);
    final profileNotifier = ref.read(profileProvider);
    final lastGptResponseId = chatNotifier.state.messages
        .lastWhereOrNull((message) => !message.isMe)
        ?.gptResponseId;
    if (addFirstMessage) {
      await chatRepository.addMessage(
        message: message,
        conversationContinue: null,
        gptResponseId: null,
        chat: chatNotifier.state.chat,
      );
    }
    final messageId = await chatRepository.addMessage(
      message: '',
      conversationContinue: null,
      gptResponseId: 'null',
      chat: chatNotifier.state.chat,
    );
    final (tutorAnswer, gptResponseId) = await gptService.getTutorAnswer(
      systemPrompt: chatNotifier.state.chat.chattyPrompt(
        profileNotifier.state.defaultTeacherLanguage,
      ),
      text: message,
      previousMessageId: lastGptResponseId,
    );
    await chatRepository.updateMessage(
      messageId: messageId,
      message: message,
      gptResponseId: gptResponseId,
      chat: chatNotifier.state.chat,
      caseType: tutorAnswer.caseType.toStringValue(),
      assistantMessage: tutorAnswer.assistantMessage,
      correctionOriginal: tutorAnswer.correction?.original,
      correctionCorrectedMarkdown: tutorAnswer.correction?.correctedMarkdown,
      correctionExplanation: tutorAnswer.correction?.explanation,
      suggestedTranslationUserMeaning:
          tutorAnswer.suggestedTranslation?.userMeaning,
      suggestedTranslationTranslation:
          tutorAnswer.suggestedTranslation?.translation,
      userQuestionAnswerQuestion: tutorAnswer.userQuestionAnswer?.question,
      userQuestionAnswerAnswer: tutorAnswer.userQuestionAnswer?.answer,
      conversationContinue: tutorAnswer.conversationContinue,
    );
  }

  Future<void> toggleAudioMode() async {
    final chatNotifier = ref.read(chatNotifierProvider);
    await HapticFeedback.heavyImpact();
    final microphoneGranted = await requestMicrophonePermission();
    if (!microphoneGranted) {
      return;
    }

    chatNotifier.setState(
      chatNotifier.state.copyWith(
        isAudioRecordingMode: !chatNotifier.state.isAudioRecordingMode,
      ),
    );
  }

  Future<void> toggleRecording() async {
    final chatNotifier = ref.read(chatNotifierProvider);
    if (chatNotifier.state.isSpeechRecording) {
      await stopAudioRecording();
      return;
    } else {
      await startAudioRecording();
    }
  }

  Future<void> startAudioRecording() async {
    final chatNotifier = ref.read(chatNotifierProvider);
    final audioService = ref.read(audioServiceProvider);
    if (chatNotifier.state.isSpeechRecording) {
      return;
    }
    await audioService.startRecording();
    chatNotifier.setState(
      chatNotifier.state.copyWith(
        isSpeechRecording: true,
      ),
    );
  }

  Future<void> stopAudioRecording() async {
    final chatNotifier = ref.read(chatNotifierProvider);
    final audioService = ref.read(audioServiceProvider);
    final chatRepository = ref.read(chatRepositoryProvider);
    final gptService = ref.read(gptServiceProvider);
    final profileNotifier = ref.read(profileProvider);
    if (!chatNotifier.state.isSpeechRecording) {
      return;
    }
    final result = await audioService.stopRecording();

    chatNotifier.setState(
      chatNotifier.state.copyWith(
        isSpeechRecording: false,
      ),
    );
    if (result != null) {
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          isMessageSending: true,
        ),
      );
      final lastGptResponseId = chatNotifier.state.messages
          .lastWhereOrNull((message) => !message.isMe)
          ?.gptResponseId;
      final messageId = await chatRepository.addMessage(
        message: '',
        conversationContinue: null,
        gptResponseId: null,
        chat: chatNotifier.state.chat,
      );
      final message = await gptService.sendAudio(result);
      await chatRepository.updateMessage(
        messageId: messageId,
        message: message,
        gptResponseId: null,
        chat: chatNotifier.state.chat,
      );
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          isMessageSending: false,
        ),
      );
      final (tutorAnswer, gptResponseId) = await gptService.getTutorAnswer(
        systemPrompt: chatNotifier.state.chat.chattyPrompt(
          profileNotifier.state.defaultTeacherLanguage,
        ),
        text: message,
        previousMessageId: lastGptResponseId,
      );
      await chatRepository.addMessage(
        message: message,
        gptResponseId: gptResponseId,
        chat: chatNotifier.state.chat,
        caseType: tutorAnswer.caseType.toStringValue(),
        assistantMessage: tutorAnswer.assistantMessage,
        correctionOriginal: tutorAnswer.correction?.original,
        correctionCorrectedMarkdown: tutorAnswer.correction?.correctedMarkdown,
        correctionExplanation: tutorAnswer.correction?.explanation,
        suggestedTranslationUserMeaning:
            tutorAnswer.suggestedTranslation?.userMeaning,
        suggestedTranslationTranslation:
            tutorAnswer.suggestedTranslation?.translation,
        userQuestionAnswerQuestion: tutorAnswer.userQuestionAnswer?.question,
        userQuestionAnswerAnswer: tutorAnswer.userQuestionAnswer?.answer,
        conversationContinue: tutorAnswer.conversationContinue,
      );
    }
  }

  Future<void> cancelAudioRecording() async {
    final chatNotifier = ref.read(chatNotifierProvider);
    final audioService = ref.read(audioServiceProvider);
    if (!chatNotifier.state.isSpeechRecording) {
      return;
    }
    await audioService.stopRecording();
    chatNotifier.setState(
      chatNotifier.state.copyWith(
        isSpeechRecording: false,
      ),
    );
  }
}
