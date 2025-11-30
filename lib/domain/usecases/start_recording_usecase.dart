import '../../../core/realtime/realtime_audio_manager.dart';

/// Use Case для начала записи аудио
class StartRecordingUseCase {
  const StartRecordingUseCase({
    required this.audioManager,
  });

  final RealtimeAudioManager audioManager;

  Future<void> execute() async {
    await audioManager.startRecording();
  }
}

