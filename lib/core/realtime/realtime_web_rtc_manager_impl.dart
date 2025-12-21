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
          track.onMute = () {
            onMuted?.call();
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
    } catch (e) {
      onError?.call(e);
      rethrow;
    }
  }

  @override
  void disconnect() {
    _dataChannel?.close();
    _dataChannel = null;
    _localStream?.getTracks().forEach((track) {
      track.stop();
    });
    _localStream?.dispose();
    _localStream = null;
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
}
