import 'package:permission_handler/permission_handler.dart';

import '../plugins/app_permission.dart';

Future<bool> requestMicrophonePermission() async {
  return AppPermission.checkPermission(permission: Permission.microphone);
}
