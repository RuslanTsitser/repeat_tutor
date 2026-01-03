import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../gpt/gpt_service.dart';
import 'realtime_webrtc_manager.dart';

/// WebRTC менеджер для работы с OpenAI Realtime API
class RealtimeWebRTCManagerImpl implements RealtimeWebRTCConnection {
  RealtimeWebRTCManagerImpl(this._gptService);
  final GptService _gptService;
  RTCPeerConnection? _peerConnection;
  RTCDataChannel? _dataChannel;
  MediaStream? _localStream;
  bool _isConnected = false;

  @override
  bool get isConnected => _isConnected;

  @override
  void Function(Object error)? onError;

  @override
  void Function()? onConnect;

  @override
  void Function()? onDisconnect;

  @override
  void Function()? onMuted;

  @override
  void Function()? onUnMuted;

  @override
  void Function(String message)? onMessage;

  @override
  void Function(double decibels, bool isLocal)? onAudioLevelChanged;

  MediaStream? _remoteStream;
  Timer? _audioLevelTimer;
  String? _localTrackId;
  String? _remoteTrackId;

  @override
  Future<void> connect(String clientSecret) async {
    try {
      // Создаем конфигурацию peer connection
      final config = {
        'iceServers': [
          {'urls': 'stun:stun.l.google.com:19302'},
        ],
        'sdpSemantics': 'unified-plan',
      };

      // Создаем peer connection
      _peerConnection = await createPeerConnection(config);

      if (_peerConnection == null) {
        throw Exception('Не удалось создать peer connection');
      }

      // Добавляем аудио трек (микрофон)
      _localStream = await navigator.mediaDevices.getUserMedia({
        'audio': true,
      });

      if (_localStream != null) {
        final tracks = _localStream!.getAudioTracks();
        for (final track in tracks) {
          await _peerConnection!.addTrack(track, _localStream!);

          // Сохраняем ID трека для идентификации в статистике
          _localTrackId = track.id;

          track.onMute = () {
            onMuted?.call();
            // При муте уровень должен быть минимальным
            onAudioLevelChanged?.call(-100.0, true);
          };
          track.onUnMute = () {
            onUnMuted?.call();
          };
        }
      }

      // Создаем DataChannel для событий Realtime API
      final channelConfig = RTCDataChannelInit()..ordered = true;

      _dataChannel = await _peerConnection!.createDataChannel(
        'oai-events',
        channelConfig,
      );

      if (_dataChannel == null) {
        throw Exception('Не удалось создать data channel');
      }

      // Настраиваем обработчик получения сообщений через DataChannel
      _dataChannel!.onMessage = (RTCDataChannelMessage message) {
        final messageText = message.text;
        onMessage?.call(messageText);
      };

      // Настраиваем обработчик получения входящих треков (аудио от сервера)
      _peerConnection!.onTrack = (RTCTrackEvent event) {
        if (event.streams.isNotEmpty) {
          _remoteStream = event.streams[0];

          // Получаем аудио треки из входящего потока
          if (_remoteStream != null) {
            final audioTracks = _remoteStream!.getAudioTracks();
            for (final track in audioTracks) {
              // Сохраняем ID трека для идентификации в статистике
              _remoteTrackId = track.id;

              track.onMute = () {
                onAudioLevelChanged?.call(-100.0, false);
              };
              track.onUnMute = () {
                // Трек был размучен
              };
            }
          }
        }
      };

      // Настраиваем обработчики событий peer connection
      _peerConnection!.onIceConnectionState = (state) {
        if (state == RTCIceConnectionState.RTCIceConnectionStateConnected ||
            state == RTCIceConnectionState.RTCIceConnectionStateCompleted) {
          _isConnected = true;
          onConnect?.call();
        } else if (state ==
                RTCIceConnectionState.RTCIceConnectionStateDisconnected ||
            state == RTCIceConnectionState.RTCIceConnectionStateFailed ||
            state == RTCIceConnectionState.RTCIceConnectionStateClosed) {
          _isConnected = false;
          onDisconnect?.call();
        }
      };

      // Создаем SDP Offer
      final offer = await _peerConnection!.createOffer({
        'offerToReceiveAudio': true,
        'offerToReceiveVideo': false,
      });

      await _peerConnection!.setLocalDescription(offer);

      // Отправляем Offer в OpenAI API
      final answerSDP = await _gptService.sendOffer(offer.sdp!, clientSecret);

      // Устанавливаем remote description (Answer)
      final answer = RTCSessionDescription(answerSDP, 'answer');
      await _peerConnection!.setRemoteDescription(answer);

      // Запускаем мониторинг уровня аудио после установки соединения
      _startAudioLevelMonitoring();
    } catch (e) {
      onError?.call(e);
      rethrow;
    }
  }

  /// Запускает периодический мониторинг уровня аудио
  void _startAudioLevelMonitoring() {
    _audioLevelTimer?.cancel();
    _audioLevelTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => _updateAudioLevel(),
    );
  }

  /// Обновляет уровень аудио через WebRTC статистику
  Future<void> _updateAudioLevel() async {
    if (_peerConnection == null) {
      return;
    }

    try {
      final stats = await _peerConnection!.getStats();

      // Ищем записи с audioLevel в статистике
      // Из логов видно, что audioLevel есть в записях с kind: "audio"
      for (final stat in stats) {
        final values = stat.values;

        // Проверяем, что это аудио запись с audioLevel
        if (values['kind'] == 'audio' && values.containsKey('audioLevel')) {
          final audioLevel = values['audioLevel'];
          if (audioLevel is num) {
            final level = audioLevel.toDouble();

            // Определяем, это входящий или исходящий аудио
            // По trackIdentifier сравниваем с известными ID треков
            final trackId = values['trackIdentifier'] as String?;

            // Определяем, это локальный или удаленный трек
            // Сравниваем trackIdentifier с сохраненными ID
            bool isLocalTrack = false;
            if (trackId != null) {
              if (_localTrackId != null && trackId == _localTrackId) {
                isLocalTrack = true;
              } else if (_remoteTrackId != null && trackId == _remoteTrackId) {
                isLocalTrack = false;
              }
              // Если не совпадает ни с одним известным ID,
              // считаем локальным по умолчанию (исходящий аудио)
              else if (_localTrackId == null && _remoteTrackId == null) {
                isLocalTrack = true;
              }
            }

            // Конвертируем в децибелы
            // audioLevel уже нормализован от 0.0 до 1.0
            // dB = 20 * log10(level)
            final decibels = level > 0
                ? 20.0 * math.log(level) / math.ln10
                : -100.0;

            // Ограничиваем диапазон от -100 до 0 дБ
            final clampedDecibels = decibels.clamp(-100.0, 0.0);

            onAudioLevelChanged?.call(clampedDecibels, isLocalTrack);
          }
        }
      }
    } catch (e) {
      // Игнорируем ошибки при получении статистики
      // чтобы не прерывать работу приложения
    }
  }

  @override
  void disconnect() {
    // Останавливаем мониторинг уровня аудио
    _audioLevelTimer?.cancel();
    _audioLevelTimer = null;

    _dataChannel?.close();
    _dataChannel = null;
    _localStream?.getTracks().forEach((track) {
      track.stop();
    });
    _localStream?.dispose();
    _localStream = null;
    _localTrackId = null;

    // Останавливаем и освобождаем удаленные треки
    _remoteStream?.getTracks().forEach((track) {
      track.stop();
    });
    _remoteStream?.dispose();
    _remoteStream = null;
    _remoteTrackId = null;

    _peerConnection?.close();
    _peerConnection = null;

    if (_isConnected) {
      _isConnected = false;
      onDisconnect?.call();
    }
  }

  @override
  Future<void> setMicEnabled(bool enabled) async {
    if (_localStream == null) return;
    for (var track in _localStream!.getAudioTracks()) {
      await Helper.setMicrophoneMute(enabled, track);
    }
  }

  @override
  Future<void> setSpeakerEnabled(bool enabled) async {
    await Helper.setSpeakerphoneOn(enabled);
  }

  /// Отправляет сообщение через DataChannel
  @override
  Future<void> sendMessage(Map<String, dynamic> message) async {
    if (_dataChannel == null ||
        _dataChannel!.state != RTCDataChannelState.RTCDataChannelOpen) {
      return;
    }

    try {
      final jsonString = jsonEncode(message);
      _dataChannel!.send(RTCDataChannelMessage(jsonString));
    } catch (e) {
      onError?.call('Ошибка при отправке сообщения: $e');
    }
  }
}
