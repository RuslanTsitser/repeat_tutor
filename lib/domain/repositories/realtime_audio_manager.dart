/// Доменный протокол для управления аудио
abstract interface class RealtimeAudioManager {
  void Function(String base64)? onAudioDataBase64;
  void Function(double level)? onAudioLevel;

  Future<void> startRecording();
  void stopRecording();
  void stopPlaying();
}
