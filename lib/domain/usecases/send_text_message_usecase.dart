import '../../../core/realtime/realtime_webrtc_manager.dart';

/// Use Case для отправки текстового сообщения
class SendTextMessageUseCase {
  const SendTextMessageUseCase({
    required this.connection,
  });

  final RealtimeWebRTCConnection connection;

  void execute(String message) {
    connection.sendText(message);
  }
}

