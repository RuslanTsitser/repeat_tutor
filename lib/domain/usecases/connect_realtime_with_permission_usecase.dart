import '../models/realtime_session.dart';
import 'connect_realtime_webrtc_usecase.dart';
import 'replace_expired_session_usecase.dart';
import 'request_microphone_permission_usecase.dart';

/// Use Case для подключения к Realtime с проверкой разрешений и заменой сессии
class ConnectRealtimeWithPermissionUseCase {
  const ConnectRealtimeWithPermissionUseCase({
    required this.requestPermissionUseCase,
    required this.replaceExpiredSessionUseCase,
    required this.connectUseCase,
  });

  final RequestMicrophonePermissionUseCase requestPermissionUseCase;
  final ReplaceExpiredSessionUseCase replaceExpiredSessionUseCase;
  final ConnectRealtimeWebRTCUseCase connectUseCase;

  Future<RealtimeSession?> execute(RealtimeSession session) async {
    // Запрашиваем разрешение на микрофон
    final granted = await requestPermissionUseCase.execute();

    if (!granted) {
      throw Exception('Разрешение на микрофон было отклонено');
    }

    // Проверяем, не истекла ли сессия
    if (session.clientSecret == null || !session.isClientSecretValid) {
      // Если секрет истек, создаем новую сессию
      final newSession = await replaceExpiredSessionUseCase.execute(session);

      if (newSession.clientSecret == null || !newSession.isClientSecretValid) {
        throw Exception('Не удалось получить client secret');
      }

      // Подключаемся с новой сессией
      await connectUseCase.execute(
        sessionId: newSession.id,
        clientSecret: newSession.clientSecret!,
      );

      return newSession;
    }

    // Подключаемся с текущей сессией
    await connectUseCase.execute(
      sessionId: session.id,
      clientSecret: session.clientSecret!,
    );

    return null; // Сессия не была заменена
  }
}

