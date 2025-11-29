/// Доменный протокол для подключения к Realtime API через WebRTC
abstract interface class RealtimeWebRTCConnection {
  bool get isConnected;

  void Function(String)? onMessage;
  void Function(Object error)? onError;
  void Function()? onConnect;
  void Function()? onDisconnect;
  void Function()? onAudioTrackReady;
  void Function()? onDataChannelReady;

  Future<void> connect({
    required String clientSecret,
    required String sessionId,
  });

  void disconnect();

  void sendText(String text);

  void sendAudioChunk(String base64);

  void commitAudio();
}
