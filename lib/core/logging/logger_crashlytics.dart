// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> recordCrashlyticsError(
  Object? error,
  StackTrace? stackTrace, {
  String? reason,
}) async {
  // await FirebaseCrashlytics.instance.recordError(error, stackTrace, reason: reason);
}

Future<void> recordCrashlyticsLog(String? message) async {
  if (message == null) return;
  // await FirebaseCrashlytics.instance.log(message);
}

Future<void> setCrashlyticsUserId(String userId) async {
  // await FirebaseCrashlytics.instance.setUserIdentifier(userId);
}

Future<bool> didCrashOnPreviousExecution() async {
  // return FirebaseCrashlytics.instance.didCrashOnPreviousExecution();
  return false;
}

void crash() {
  // FirebaseCrashlytics.instance.crash();
}
