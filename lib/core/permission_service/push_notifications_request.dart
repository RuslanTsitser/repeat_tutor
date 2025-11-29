import 'package:permission_handler/permission_handler.dart';

import 'permission_state.dart';

Future<void> requestPushNotifications() async {
  if (PermissionState.isRequestingPermissions) {
    // Если уже идет запрос разрешений, ждем его завершения
    while (PermissionState.isRequestingPermissions) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    return;
  }

  PermissionState.setRequestingPermissions(true);
  try {
    await _checkPermissionPushNotifications();
  } finally {
    PermissionState.setRequestingPermissions(false);
  }
}

Future<bool> _checkPermissionPushNotifications() async {
  final status = await Permission.notification.status;
  if (status == PermissionStatus.granted ||
      status == PermissionStatus.limited) {
    return true;
  }
  final result = await Permission.notification.request();
  return result == PermissionStatus.granted ||
      result == PermissionStatus.limited;
}
