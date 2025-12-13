import 'package:permission_handler/permission_handler.dart';

import '../logging/app_logger.dart';

abstract class AppPermission {
  static bool _isRequestingPermissions = false;

  static bool get isRequestingPermissions => _isRequestingPermissions;

  static void setRequestingPermissions(bool value) {
    _isRequestingPermissions = value;
  }

  static Future<void> requestAppPermissionSettings() => openAppSettings();

  static Future<bool> checkPermission({
    required Permission permission,
    void Function(bool)? requestResult,
    void Function()? onGranted,
    void Function()? onPermanentlyDenied,
  }) async {
    final status = await permission.status;
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      logInfo('PERMISSION: $permission already granted');
      onGranted?.call();
      return true;
    }
    if (status == PermissionStatus.permanentlyDenied) {
      logError('PERMISSION: $permission permanently denied');
      onPermanentlyDenied?.call();
      return false;
    }

    // Проверяем, не идет ли уже запрос разрешений
    if (isRequestingPermissions) {
      // Ждем завершения текущего запроса
      while (isRequestingPermissions) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
      }
      // После ожидания проверяем статус снова
      final newStatus = await permission.status;
      if (newStatus == PermissionStatus.granted ||
          newStatus == PermissionStatus.limited) {
        logInfo('PERMISSION: $permission requested and granted');
        onGranted?.call();
        return true;
      }
      if (newStatus == PermissionStatus.permanentlyDenied) {
        logError('PERMISSION: $permission requested and permanently denied');
        onPermanentlyDenied?.call();
        return false;
      }
    }

    setRequestingPermissions(true);
    try {
      final result = await permission.request();
      final granted =
          result == PermissionStatus.granted ||
          result == PermissionStatus.limited;
      requestResult?.call(granted);
      return granted;
    } finally {
      setRequestingPermissions(false);
    }
  }
}
