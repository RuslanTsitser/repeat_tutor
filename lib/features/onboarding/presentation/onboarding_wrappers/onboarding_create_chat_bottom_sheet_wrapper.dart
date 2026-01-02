import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/local_storage/storage_keys.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../infrastructure/core.dart';

final _topicInputKey = GlobalKey();
final _topicChipsKey = GlobalKey();
final _languageDropdownKey = GlobalKey();
final _levelDropdownKey = GlobalKey();

const _scope = 'onboarding_create_chat_bottom_sheet_wrapper';

class OnboardingCreateChatBottomSheetWrapper extends ConsumerStatefulWidget {
  const OnboardingCreateChatBottomSheetWrapper({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  ConsumerState<OnboardingCreateChatBottomSheetWrapper> createState() =>
      _OnboardingCreateChatBottomSheetWrapperState();
}

class _OnboardingCreateChatBottomSheetWrapperState
    extends ConsumerState<OnboardingCreateChatBottomSheetWrapper> {
  @override
  void initState() {
    super.initState();
    final showcaseView = ShowcaseView.register(scope: _scope);
    final localStorage = ref.read(localStorageProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final isOnboarded = await localStorage.getValue<bool>(
        StorageKeys.isOnboardedCreateChatFormKey,
      );
      if (isOnboarded == true) {
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 300));
      showcaseView.startShowCase([_topicInputKey]);
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

class TopicInputWrapper extends ConsumerWidget {
  const TopicInputWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      title: S.of(context).startHere,
      description: S.of(context).enterATopicForYourChat,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(16),
      key: _topicInputKey,
      onTargetClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_topicChipsKey]);
      },
      onBarrierClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_topicChipsKey]);
      },
      onToolTipClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_topicChipsKey]);
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

class TopicChipsWrapper extends ConsumerWidget {
  const TopicChipsWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      description: S.of(context).orChooseFromExamples,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(16),
      key: _topicChipsKey,
      onTargetClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_languageDropdownKey]);
      },
      onBarrierClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_languageDropdownKey]);
      },
      onToolTipClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_languageDropdownKey]);
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

class LanguageDropdownWrapper extends ConsumerWidget {
  const LanguageDropdownWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      description: S.of(context).selectLanguageToLearn,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(16),
      key: _languageDropdownKey,
      onTargetClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_levelDropdownKey]);
      },
      onBarrierClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_levelDropdownKey]);
      },
      onToolTipClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_levelDropdownKey]);
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

class LevelDropdownWrapper extends ConsumerWidget {
  const LevelDropdownWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      description: S.of(context).selectYourLevel,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(16),
      key: _levelDropdownKey,
      onTargetClick: () {
        ref
            .read(localStorageProvider)
            .setValue(StorageKeys.isOnboardedCreateChatFormKey, true);
      },
      onBarrierClick: () {
        ref
            .read(localStorageProvider)
            .setValue(StorageKeys.isOnboardedCreateChatFormKey, true);
      },
      onToolTipClick: () {
        ref
            .read(localStorageProvider)
            .setValue(StorageKeys.isOnboardedCreateChatFormKey, true);
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
