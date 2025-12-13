/// Доменный протокол для подключения к Realtime API через WebRTC
abstract interface class RealtimeWebRTCConnection {
  /// Флаг, указывающий на то, что соединение с Realtime API через WebRTC установлено
  bool get isConnected;

  /// Обработчик события ошибки при подключении к Realtime API через WebRTC
  void Function(Object error)? onError;

  /// Обработчик события подключения к Realtime API через WebRTC
  void Function()? onConnect;

  /// Обработчик события отключения от Realtime API через WebRTC
  void Function()? onDisconnect;

  /// Подключение к Realtime API через WebRTC
  Future<void> connect(String clientSecret);

  /// Отключение от Realtime API через WebRTC
  void disconnect();
}
