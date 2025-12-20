import 'package:collection/collection.dart';
import 'package:flutter/services.dart';

import '../../../core/audio/audio_service.dart';
import '../../../core/domain/repositories/chat_repository.dart';
import '../../../core/gpt/gpt_service.dart';
import '../../../core/permission/microphone_permission_request.dart';
import '../../../core/speech/speech_recognizer.dart';
import '../logic/chat_notifier.dart';

class AddMessageUseCase {
  const AddMessageUseCase({
    required this.chatRepository,
    required this.chatNotifier,
    required this.speechRecognizer,
    required this.audioService,
    required this.gptService,
  });
  final ChatRepository chatRepository;
  final ChatNotifier chatNotifier;
  final SpeechRecognizer speechRecognizer;
  final AudioService audioService;
  final GptService gptService;

  Future<void> addMessage(String message) async {
    final lastGptResponseId = chatNotifier.state.messages
        .lastWhereOrNull((message) => !message.isMe)
        ?.gptResponseId;
    await chatRepository.addMessage(
      message: message,
      gptResponseId: null,
      chat: chatNotifier.state.chat,
    );
    final tutorAnswer = await gptService.getTutorAnswer(
      systemPrompt: chatNotifier.state.chat.chattyPrompt,
      text: message,
      previousMessageId: lastGptResponseId,
    );
    // TODO: Tutor answer logic
  }

  Future<void> toggleAudioMode() async {
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
    if (chatNotifier.state.isSpeechRecording) {
      await stopAudioRecording();
      return;
    } else {
      await startAudioRecording();
    }
  }

  Future<void> startAudioRecording() async {
    if (chatNotifier.state.isAudioRecordingMode) {
      return;
    }
    await audioService.startRecording();
    chatNotifier.setState(
      chatNotifier.state.copyWith(
        isAudioRecordingMode: true,
      ),
    );
  }

  Future<void> stopAudioRecording() async {
    if (!chatNotifier.state.isAudioRecordingMode) {
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
      final text = await gptService.sendAudio(result);
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          isMessageSending: false,
        ),
      );
      await addMessage(text);
    }
  }
}
