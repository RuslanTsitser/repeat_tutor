import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import 'permission_state.dart';

Future<bool> _checkPermission({
  required Permission permission,
  ValueChanged<bool>? requestResult,
  VoidCallback? onGranted,
  VoidCallback? onPermanentlyDenied,
}) async {
  final status = await permission.status;
  if (status == PermissionStatus.granted ||
      status == PermissionStatus.limited) {
    onGranted?.call();
    return true;
  }
  if (status == PermissionStatus.permanentlyDenied) {
    onPermanentlyDenied?.call();
    return false;
  }

  // Проверяем, не идет ли уже запрос разрешений
  if (PermissionState.isRequestingPermissions) {
    // Ждем завершения текущего запроса
    while (PermissionState.isRequestingPermissions) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    // После ожидания проверяем статус снова
    final newStatus = await permission.status;
    if (newStatus == PermissionStatus.granted ||
        newStatus == PermissionStatus.limited) {
      onGranted?.call();
      return true;
    }
    if (newStatus == PermissionStatus.permanentlyDenied) {
      onPermanentlyDenied?.call();
      return false;
    }
  }

  PermissionState.setRequestingPermissions(true);
  try {
    final result = await permission.request();
    final granted =
        result == PermissionStatus.granted ||
        result == PermissionStatus.limited;
    requestResult?.call(granted);
    return granted;
  } finally {
    PermissionState.setRequestingPermissions(false);
  }
}

Future<bool> checkPermissionCamera({
  VoidCallback? onGranted,
  ValueChanged<bool>? requestResult,
  VoidCallback? onPermanentlyDenied,
}) => _checkPermission(
  permission: Permission.camera,
  requestResult: requestResult,
  onGranted: onGranted,
  onPermanentlyDenied: onPermanentlyDenied,
);

// Future<bool> checkPermissionPhotoGallery({
//   VoidCallback? onGranted,
//   ValueChanged<bool>? requestResult,
//   VoidCallback? onPermanentlyDenied,
// }) async {
//   if (defaultTargetPlatform == TargetPlatform.android) {
//     final androidInfo = await DeviceInfoPlugin().androidInfo;
//     return androidInfo.version.sdkInt <= 32
//         ? _checkPermission(
//             permission: Permission.storage,
//             requestResult: requestResult,
//             onGranted: onGranted,
//             onPermanentlyDenied: onPermanentlyDenied,
//           )
//         : _checkPermission(
//             permission: Permission.photos,
//             requestResult: requestResult,
//             onGranted: onGranted,
//             onPermanentlyDenied: onPermanentlyDenied,
//           );
//   }
//   return _checkPermission(
//     permission: Permission.photos,
//     requestResult: requestResult,
//     onGranted: onGranted,
//     onPermanentlyDenied: onPermanentlyDenied,
//   );
// }

Future<void> requestAppPermissionSettings() => openAppSettings();
