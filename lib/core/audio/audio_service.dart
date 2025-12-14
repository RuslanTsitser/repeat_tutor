abstract interface class AudioService {
  Future<void> startRecording();
  Future<String?> stopRecording();
}
