import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_directory/app_directory.dart';
import 'core/localization/generated/l10n.dart';
import 'core/permission_service/app_tracking_transparency_request.dart';
import 'infrastructure/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDirectory.initialize();
  await requestAppTrackingTransparency();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return CupertinoApp.router(
      routerConfig: router.config(),
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
