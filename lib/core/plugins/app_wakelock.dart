import 'package:wakelock_plus/wakelock_plus.dart';

abstract class AppWakelock {
  static Future<void> enable() async {
    await WakelockPlus.enable();
  }
}
