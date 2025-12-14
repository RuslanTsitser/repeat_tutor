import 'package:permission_handler/permission_handler.dart';

import '../plugins/app_permission.dart';

Future<bool> requestSpeechRecognition() async {
  return AppPermission.checkPermission(permission: Permission.speech);
}
