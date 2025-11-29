import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_directory/app_directory.dart';
import 'core/localization/generated/l10n.dart';
import 'core/permission_service/app_tracking_transparency_request.dart';
import 'presentation/screens/initialize_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDirectory.initialize();
  await requestAppTrackingTransparency();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const InitializeScreen(),
    );
  }
}
