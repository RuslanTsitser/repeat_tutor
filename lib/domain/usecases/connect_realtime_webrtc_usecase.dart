import '../../infrastructure/realtime/realtime_webrtc_manager.dart';

/// Use Case для подключения к WebRTC сессии Realtime API
class ConnectRealtimeWebRTCUseCase {
  const ConnectRealtimeWebRTCUseCase({required this.connection});
  final RealtimeWebRTCConnection connection;

  Future<void> execute({
    required String sessionId,
    required String clientSecret,
  }) async {
    await connection.connect(
      clientSecret: clientSecret,
      sessionId: sessionId,
    );
  }
}
