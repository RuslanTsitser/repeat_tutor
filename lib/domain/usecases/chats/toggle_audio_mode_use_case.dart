import 'package:flutter/services.dart';

import '../../../core/audio/audio_service.dart';
import '../../../core/gpt/gpt_service.dart';
import '../../../core/permission/microphone_permission_request.dart';
import '../../../core/permission/speech_recognition_request.dart';
import '../../../core/speech/speech_recognizer.dart';
import '../../../presentation/notifiers/message_notifier.dart';
import 'add_message_use_case.dart';

class ToggleAudioModeUseCase {
  const ToggleAudioModeUseCase({
    required this.messageNotifier,
    required this.speechRecognizer,
    required this.audioService,
    required this.gptService,
    required this.addMessageUseCase,
  });
  final SpeechRecognizer speechRecognizer;
  final AudioService audioService;
  final GptService gptService;
  final MessageNotifier messageNotifier;
  final AddMessageUseCase addMessageUseCase;

  Future<void> execute() async {
    await HapticFeedback.heavyImpact();
    final microphoneGranted = await requestMicrophonePermission();
    if (!microphoneGranted) {
      return;
    }
    final speechGranted = await requestSpeechRecognition();
    if (!speechGranted) {
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
          isUploading: true,
        ),
      );
      final text = await gptService.sendAudio(result);
      messageNotifier.setState(
        messageNotifier.state.copyWith(
          isUploading: false,
        ),
      );
      await addMessageUseCase.execute(text);
    }
  }
}
