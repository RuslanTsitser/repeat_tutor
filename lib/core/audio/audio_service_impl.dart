import 'package:path/path.dart' as p;
import 'package:record/record.dart';

import '../plugins/app_directory.dart';
import 'audio_service.dart';

class AudioServiceImpl implements AudioService {
  AudioServiceImpl();

  final record = AudioRecorder();
  bool _isRecording = false;

  @override
  Future<void> startRecording() async {
    final hasPermission = await record.hasPermission();
    if (!hasPermission) {
      return;
    }
    if (_isRecording) {
      await record.stop();
      _isRecording = false;
    }
    final dir = AppDirectory.appCacheDirectory;
    final path = p.join(
      dir.path,
      'audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );
    await record.start(const RecordConfig(), path: path);
    _isRecording = true;
  }

  @override
  Future<String?> stopRecording() async {
    if (!_isRecording) {
      return null;
    }
    final path = await record.stop();
    _isRecording = false;
    return path;
  }
}
