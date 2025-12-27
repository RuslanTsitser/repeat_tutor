import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/localization/generated/l10n.dart';
import 'core/logging/app_logger.dart';
import 'core/permission/app_tracking_transparency_request.dart';
import 'core/plugins/app_directory.dart';
import 'core/plugins/app_version.dart';
import 'core/plugins/app_wakelock.dart';
import 'infrastructure/core.dart';
import 'infrastructure/state_managers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDirectory.init();
  manageLogFiles();
  await AppVersion.init();
  await requestAppTrackingTransparency();
  await AppWakelock.enable();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final profile = ref.watch(profileProvider);
    final defaultLanguage = profile.state.defaultLanguage;
    final locale = defaultLanguage.toLocale();

    return CupertinoApp.router(
      routerConfig: router.config(),
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
