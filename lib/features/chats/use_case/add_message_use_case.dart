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
    required this.messageNotifier,
    required this.speechRecognizer,
    required this.audioService,
    required this.gptService,
  });
  final ChatRepository chatRepository;
  final ChatNotifier messageNotifier;
  final SpeechRecognizer speechRecognizer;
  final AudioService audioService;
  final GptService gptService;

  Future<void> addMessage(String message) async {
    final lastGptResponseId = messageNotifier.state.messages
        .lastWhereOrNull((message) => !message.isMe)
        ?.gptResponseId;
    await chatRepository.addMessage(
      message: message,
      gptResponseId: lastGptResponseId,
      chat: messageNotifier.state.chat,
    );
  }

  Future<void> toggleAudioMode() async {
    await HapticFeedback.heavyImpact();
    final microphoneGranted = await requestMicrophonePermission();
    if (!microphoneGranted) {
      return;
    }

    messageNotifier.setState(
      messageNotifier.state.copyWith(
        isAudioRecordingMode: !messageNotifier.state.isAudioRecordingMode,
      ),
    );
  }

  Future<void> startAudioRecording() async {
    await audioService.startRecording();
    messageNotifier.setState(
      messageNotifier.state.copyWith(
        isSpeechRecording: true,
      ),
    );
  }

  Future<void> stopAudioRecording() async {
    final result = await audioService.stopRecording();

    messageNotifier.setState(
      messageNotifier.state.copyWith(
        isSpeechRecording: false,
      ),
    );
    if (result != null) {
      messageNotifier.setState(
        messageNotifier.state.copyWith(
          isMessageSending: true,
        ),
      );
      final text = await gptService.sendAudio(result);
      messageNotifier.setState(
        messageNotifier.state.copyWith(
          isMessageSending: false,
        ),
      );
      await addMessage(text);
    }
  }
}
