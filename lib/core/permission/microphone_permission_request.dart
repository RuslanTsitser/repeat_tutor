import 'package:permission_handler/permission_handler.dart';

import 'permission_state.dart';

Future<bool> requestMicrophonePermission() async {
  if (PermissionState.isRequestingPermissions) {
    // Если уже идет запрос разрешений, ждем его завершения
    while (PermissionState.isRequestingPermissions) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    return false;
  }

  PermissionState.setRequestingPermissions(true);
  try {
    return await _checkPermissionMicrophone();
  } finally {
    PermissionState.setRequestingPermissions(false);
  }
}

Future<bool> _checkPermissionMicrophone() async {
  final status = await Permission.microphone.status;
  if (status == PermissionStatus.granted ||
      status == PermissionStatus.limited) {
    return true;
  }
  final result = await Permission.microphone.request();
  return result == PermissionStatus.granted ||
      result == PermissionStatus.limited;
}
