import 'package:flutter/services.dart';

import '../../../core/permission/microphone_permission_request.dart';
import '../../../core/permission/speech_recognition_request.dart';
import '../../../core/speech/speech_recognizer.dart';
import '../../../presentation/notifiers/message_notifier.dart';
import 'add_message_use_case.dart';

class ToggleAudioModeUseCase {
  const ToggleAudioModeUseCase({
    required this.messageNotifier,
    required this.speechRecognizer,
    required this.addMessageUseCase,
  });
  final SpeechRecognizer speechRecognizer;
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
    await speechRecognizer.start();
    messageNotifier.setState(
      messageNotifier.state.copyWith(
        isSpeechRecording: true,
      ),
    );
  }

  Future<void> stopAudioRecording() async {
    final result = await speechRecognizer.stop();
    messageNotifier.setState(
      messageNotifier.state.copyWith(
        isSpeechRecording: false,
      ),
    );
    if (result != null) {
      await addMessageUseCase.execute(result);
    }
  }
}
