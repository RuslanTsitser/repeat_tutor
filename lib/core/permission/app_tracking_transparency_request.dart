import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../plugins/app_permission.dart';

Future<void> requestAppTrackingTransparency() async {
  if (Platform.isIOS) {
    await AppPermission.checkPermission(
      permission: Permission.appTrackingTransparency,
    );
  }
}
