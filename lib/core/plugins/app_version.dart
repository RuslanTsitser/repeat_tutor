import 'package:package_info_plus/package_info_plus.dart';

abstract class AppVersion {
  static String version = '';
  static Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version = '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
