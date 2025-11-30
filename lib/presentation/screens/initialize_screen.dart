import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/router/router.dart';
import '../../infrastructure/core.dart';

@RoutePage()
class InitializeScreen extends ConsumerWidget {
  const InitializeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializeServiceProvider, (previous, next) {
      if (next.hasValue) {
        ref.read(routerProvider).replace(const ChatListRoute());
      }
    });

    return const CupertinoPageScaffold(
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
