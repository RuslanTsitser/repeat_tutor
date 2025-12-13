import 'package:permission_handler/permission_handler.dart';

import '../plugins/app_permission.dart';

Future<void> requestPushNotifications() async {
  await AppPermission.checkPermission(permission: Permission.notification);
}
