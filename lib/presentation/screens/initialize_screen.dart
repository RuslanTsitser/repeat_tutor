import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/core.dart';
import 'chat_list_screen.dart';
import 'realtime_session_list_screen.dart';

@RoutePage()
class InitializeScreen extends ConsumerStatefulWidget {
  const InitializeScreen({super.key});

  @override
  ConsumerState<InitializeScreen> createState() => _InitializeScreenState();
}

class _InitializeScreenState extends ConsumerState<InitializeScreen> {
  late final CupertinoTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CupertinoTabController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(initializeServiceProvider);
    if (provider.isLoading) {
      return const CupertinoPageScaffold(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return CupertinoTabScaffold(
      controller: _controller,
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            label: 'Чаты',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.phone),
            label: 'Сессии',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        if (index == 0) {
          return CupertinoTabView(
            builder: (context) => const ChatListScreen(),
          );
        }

        if (index == 1) {
          return CupertinoTabView(
            builder: (context) => const RealtimeSessionListScreen(),
          );
        }

        return CupertinoTabView(
          builder: (context) => const SizedBox.shrink(),
        );
      },
    );
  }
}
