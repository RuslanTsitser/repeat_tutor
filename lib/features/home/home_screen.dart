import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../core/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      bottomNavigationBuilder: (context, tabsRouter) {
        return _BottomNavigation(tabsRouter: tabsRouter);
      },
      routes: const [
        ChatListRoute(),
        ProfileRoute(),
      ],
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.tabsRouter});
  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: ListenableBuilder(
          listenable: tabsRouter,
          builder: (context, child) {
            return Row(
              children: [
                Expanded(
                  child: _BottomNavItem(
                    onTap: () => tabsRouter.setActiveIndex(0),
                    icon: CupertinoIcons.chat_bubble,
                    label: 'Чаты',
                    isActive: true,
                  ),
                ),
                Expanded(
                  child: _BottomNavItem(
                    onTap: () => tabsRouter.setActiveIndex(1),
                    icon: CupertinoIcons.person,
                    label: 'Профиль',
                    isActive: false,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.onTap,
    required this.icon,
    required this.label,
    required this.isActive,
  });
  final VoidCallback onTap;
  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Container(
        height: 60,
        color: CupertinoColors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive
                  ? const Color(0xFF155DFC)
                  : const Color(0xFF6A7282),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? const Color(0xFF155DFC)
                    : const Color(0xFF6A7282),
                height: 16 / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
