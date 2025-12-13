import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../logging/app_logger.dart' as logger;

Future<void> requestAppTrackingTransparency() async {
  if (Platform.isIOS) {
    final status = await Permission.appTrackingTransparency.status;
    if (status.isGranted) {
      logger.logInfo('App Tracking Transparency permission already granted');
      return;
    }
    final result = await Permission.appTrackingTransparency.request();
    if (result.isGranted) {
      logger.logInfo('App Tracking Transparency permission granted');
      return;
    }
    logger.logError('App Tracking Transparency permission denied');
  }
}
