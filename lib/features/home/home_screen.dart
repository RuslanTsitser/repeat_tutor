import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/generated/l10n.dart';
import '../../core/router/router.dart';
import '../../core/theme/app_colors.dart';
import '../../infrastructure/state_managers.dart';
import '../chats/presentation/create_chat_button.dart';
import '../onboarding/presentation/onboarding_screen.dart';
import '../onboarding/presentation/onboarding_wrappers/onboarding_chat_list_wrapper.dart';
import 'logic/home_screen_notifier.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeScreenNotifierProvider).state;
    final tab = state.tab;

    switch (tab) {
      case HomeScreenTab.loading:
        return const CupertinoPageScaffold(
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      case HomeScreenTab.onboarding:
        return const OnboardingScreen();
      case HomeScreenTab.home:
        return OnboardingChatListWrapper(
          child: AutoTabsScaffold(
            floatingActionButton: const CreateChatButton(),
            extendBody: true,
            bottomNavigationBuilder: (context, tabsRouter) {
              return _BottomNavigation(tabsRouter: tabsRouter);
            },
            routes: const [
              ChatListRoute(),
              ProfileRoute(),
            ],
          ),
        );
    }
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.tabsRouter});
  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: AppColors.divider),
        ),
        child: ListenableBuilder(
          listenable: tabsRouter,
          builder: (context, child) {
            return Row(
              children: [
                Expanded(
                  child: _BottomNavItem(
                    onTap: () => tabsRouter.setActiveIndex(0),
                    icon: CupertinoIcons.chat_bubble,
                    label: S.of(context).chats,
                    isActive: tabsRouter.activeIndex == 0,
                  ),
                ),
                Expanded(
                  child: _BottomNavItem(
                    onTap: () => tabsRouter.setActiveIndex(1),
                    icon: CupertinoIcons.person,
                    label: S.of(context).profile,
                    isActive: tabsRouter.activeIndex == 1,
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
    return Semantics(
      button: true,
      label: label,
      selected: isActive,
      child: CupertinoButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        child: Container(
          height: 64,
          color: CupertinoColors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                  height: 16 / 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
