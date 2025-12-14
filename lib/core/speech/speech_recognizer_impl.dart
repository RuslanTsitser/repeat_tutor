import 'package:speech_to_text/speech_recognition_error.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../logging/app_logger.dart';
import 'speech_recognizer.dart';

class SpeechRecognizerImpl implements SpeechRecognizer {
  SpeechRecognizerImpl();
  stt.SpeechToText speech = stt.SpeechToText();

  void statusListener(String status) {
    logInfo('SpeechRecognizerImpl: Status: $status');
  }

  void errorListener(stt.SpeechRecognitionError error) {
    logInfo('SpeechRecognizerImpl: Error: $error');
  }

  String? _result;

  void resultListener(stt.SpeechRecognitionResult result) {
    logInfo('SpeechRecognizerImpl: Result: $result');
    _result = result.recognizedWords;
  }

  @override
  Future<void> start() async {
    if (speech.isListening) {
      await speech.stop();
      _result = null;
    }
    bool available = await speech.initialize(
      onStatus: statusListener,
      onError: errorListener,
    );
    if (available) {
      speech.listen(onResult: resultListener);
    } else {
      logError('The user has denied the use of speech recognition.');
    }
  }

  @override
  Future<String?> stop() async {
    try {
      await speech.stop();
      return _result;
    } finally {
      _result = null;
    }
  }
}
