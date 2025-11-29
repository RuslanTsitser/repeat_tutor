import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/di.dart';
import 'chat_list_screen.dart';

class InitializeScreen extends ConsumerWidget {
  const InitializeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(initializeServiceProvider);
    if (initialize.isLoading) {
      return const CupertinoPageScaffold(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    if (initialize.hasError) {
      return const CupertinoPageScaffold(
        child: Center(
          child: Text('Error'),
        ),
      );
    }
    return const ChatListScreen();
  }
}
