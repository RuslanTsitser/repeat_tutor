import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/local_storage/storage_keys.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../infrastructure/core.dart';
import '../../../../infrastructure/use_case.dart';

final _addButtonKey = GlobalKey();

const _scope = 'onboarding_chat_list_wrapper';

class OnboardingChatListWrapper extends ConsumerStatefulWidget {
  const OnboardingChatListWrapper({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<OnboardingChatListWrapper> createState() =>
      _OnboardingChatListWrapperState();
}

class _OnboardingChatListWrapperState
    extends ConsumerState<OnboardingChatListWrapper> {
  @override
  void initState() {
    super.initState();
    final showcaseView = ShowcaseView.register(scope: _scope);
    final localStorage = ref.read(localStorageProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final isOnboarded = await localStorage.getValue<bool>(
        StorageKeys.isOnboardedCreateChatKey,
      );
      if (isOnboarded == true) {
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        showcaseView.startShowCase([_addButtonKey]);
        localStorage.setValue(StorageKeys.isOnboardedCreateChatKey, true);
      }
    });
  }

  @override
  void dispose() {
    ShowcaseView.getNamed(_scope).unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class AddButtonWrapper extends ConsumerWidget {
  const AddButtonWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      title: S.of(context).startHere,
      description: S.of(context).tapToCreateANewChat,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(32),
      key: _addButtonKey,
      onTargetClick: () async {
        final chat = await ref.read(createChatUseCaseProvider).execute();
        final showcaseView = ShowcaseView.getNamed(_scope);
        if (chat != null) {
          ref
              .read(localStorageProvider)
              .setValue(StorageKeys.isOnboardedCreateChatKey, true);
          ref.read(openScreenUseCaseProvider).openChat(chat);
        } else {
          showcaseView.startShowCase([_addButtonKey]);
        }
      },
      disposeOnTap: true,
      tooltipActionConfig: const TooltipActionConfig(
        alignment: MainAxisAlignment.spaceBetween,
        actionGap: 16,
        position: TooltipActionPosition.outside,
        gapBetweenContentAndAction: 16,
      ),

      child: child,
    );
  }
}
