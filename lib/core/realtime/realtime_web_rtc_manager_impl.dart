import 'package:dio/dio.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'realtime_webrtc_manager.dart';

/// WebRTC менеджер для работы с OpenAI Realtime API
class RealtimeWebRTCManagerImpl implements RealtimeWebRTCConnection {
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

  String _clientSecret = '';

  @override
  Future<void> connect({
    required String clientSecret,
    required String sessionId,
  }) async {
    _clientSecret = clientSecret;

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
        _localStream!.getAudioTracks().forEach((track) {
          _peerConnection!.addTrack(track, _localStream!);
        });
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
      final answerSDP = await _sendOfferToOpenAI(offer.sdp!);

      // Устанавливаем remote description (Answer)
      final answer = RTCSessionDescription(answerSDP, 'answer');
      await _peerConnection!.setRemoteDescription(answer);
    } catch (e) {
      onError?.call(e);
      rethrow;
    }
  }

  Future<String> _sendOfferToOpenAI(String sdp) async {
    final dio = Dio();
    final url = 'https://api.openai.com/v1/realtime/calls';

    try {
      final response = await dio.post<String>(
        url,
        data: sdp,
        options: Options(
          headers: {
            'Content-Type': 'application/sdp',
            'Authorization': 'Bearer $_clientSecret',
            'OpenAI-Beta': 'realtime=v1',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        // Ответ может быть в формате JSON с полем "sdp" или просто SDP текст
        final contentType = response.headers.value('content-type') ?? '';

        if (contentType.contains('application/json')) {
          final json = response.data as Map<String, dynamic>;
          return json['sdp'] as String;
        } else {
          return response.data as String;
        }
      } else {
        throw Exception(
          'HTTP ошибка: ${response.statusCode} - ${response.data}',
        );
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data?.toString() ?? e.message;
        throw Exception('Ошибка API: $errorMessage');
      }
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
}
