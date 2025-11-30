import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_webrtc/flutter_webrtc.dart';

/// Доменный протокол для управления аудио
abstract interface class RealtimeAudioManager {
  void Function(String base64)? onAudioDataBase64;
  void Function(double level)? onAudioLevel;

  Future<void> startRecording();
  void stopRecording();
  void stopPlaying();
}

/// Менеджер для записи и воспроизведения аудио
class RealtimeAudioManagerImpl implements RealtimeAudioManager {
  MediaStream? _localStream;
  MediaStreamTrack? _audioTrack;
  bool _isRecording = false;
  bool _isPlaying = false;

  @override
  void Function(String base64)? onAudioDataBase64;

  @override
  void Function(double level)? onAudioLevel;

  Timer? _audioLevelTimer;

  @override
  Future<void> startRecording() async {
    if (_isRecording) return;

    try {
      // Получаем доступ к микрофону
      _localStream = await navigator.mediaDevices.getUserMedia({
        'audio': {
          'sampleRate': 24000,
          'channelCount': 1,
          'echoCancellation': true,
          'noiseSuppression': true,
        },
      });

      _audioTrack = _localStream?.getAudioTracks().first;

      if (_audioTrack == null) {
        throw Exception('Не удалось получить аудио трек');
      }

      // Начинаем обработку аудио данных
      // В Flutter WebRTC аудио данные обрабатываются автоматически через MediaStream
      // Для получения raw данных нужно использовать платформо-специфичные методы
      // Здесь мы используем упрощенный подход

      _isRecording = true;
      // TODO: Implement real audio processing
      // Запускаем таймер для симуляции уровня звука
      _audioLevelTimer = Timer.periodic(const Duration(milliseconds: 100), (
        timer,
      ) {
        // В реальной реализации здесь нужно получать реальный уровень звука
        // Для демонстрации используем случайное значение
        final level = math.Random().nextDouble() * 0.5;
        onAudioLevel?.call(level);
      });
    } catch (e) {
      _isRecording = false;
      rethrow;
    }
  }

  @override
  void stopRecording() {
    if (!_isRecording) return;

    _audioLevelTimer?.cancel();
    _audioLevelTimer = null;

    _audioTrack?.stop();
    _audioTrack = null;
    _localStream?.getTracks().forEach((track) {
      track.stop();
    });
    _localStream?.dispose();
    _localStream = null;

    _isRecording = false;
    onAudioLevel?.call(0.0);
  }

  @override
  void stopPlaying() {
    if (!_isPlaying) return;

    // Останавливаем воспроизведение
    // В Flutter WebRTC это делается через отключение трека
    _isPlaying = false;
  }
}
