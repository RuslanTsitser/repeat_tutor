abstract interface class SpeechRecognizer {
  Future<void> start();
  Future<String?> stop();
}
