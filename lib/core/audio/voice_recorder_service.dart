import 'package:path/path.dart' as p;
import 'package:record/record.dart';

import '../app_directory/app_directory.dart';

/// Обертка над [AudioRecorder], инкапсулирующая только работу с файлами
class VoiceRecorderService {
  VoiceRecorderService();

  final AudioRecorder _recorder = AudioRecorder();

  bool _isRecording = false;
  String? _lastPath;

  bool get isRecording => _isRecording;

  Future<void> startRecording(String chatId) async {
    if (_isRecording) {
      return;
    }

    final cacheDir = AppDirectory.appCacheDirectory;
    final fileName =
        'voice_${chatId}_${DateTime.now().microsecondsSinceEpoch}.m4a';
    final path = p.join(cacheDir.path, fileName);

    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: path,
    );

    _lastPath = path;
    _isRecording = true;
  }

  Future<String?> stopRecording() async {
    if (!_isRecording) {
      return null;
    }
    final path = await _recorder.stop();
    _isRecording = false;
    final resolvedPath = path ?? _lastPath;
    _lastPath = null;
    return resolvedPath;
  }

  Future<void> dispose() async {
    if (_isRecording) {
      await _recorder.stop();
      _isRecording = false;
      _lastPath = null;
    }
    await _recorder.dispose();
  }
}
