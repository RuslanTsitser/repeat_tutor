import '../../../core/permission_service/microphone_permission_request.dart';

/// Use Case для запроса разрешения на микрофон
class RequestMicrophonePermissionUseCase {
  const RequestMicrophonePermissionUseCase();

  Future<bool> execute() async {
    return await requestMicrophonePermission();
  }
}

