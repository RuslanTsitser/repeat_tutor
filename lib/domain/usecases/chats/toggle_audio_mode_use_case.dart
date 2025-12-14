import 'package:flutter/services.dart';

import '../../../core/permission/microphone_permission_request.dart';
import '../../../core/permission/speech_recognition_request.dart';
import '../../../presentation/notifiers/message_notifier.dart';

class ToggleAudioModeUseCase {
  const ToggleAudioModeUseCase({
    required this.messageNotifier,
  });
  final MessageNotifier messageNotifier;

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
}
