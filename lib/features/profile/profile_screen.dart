import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../core/localization/generated/l10n.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text(S.of(context).profile),
      ),
    );
  }
}
