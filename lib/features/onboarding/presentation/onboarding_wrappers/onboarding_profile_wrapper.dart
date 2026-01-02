import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/local_storage/storage_keys.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../infrastructure/core.dart';

final _appLanguageKey = GlobalKey();
final _languageToLearnKey = GlobalKey();
final _tutorLanguageKey = GlobalKey();

const _scope = 'onboarding_profile_wrapper';

class OnboardingProfileWrapper extends ConsumerStatefulWidget {
  const OnboardingProfileWrapper({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  ConsumerState<OnboardingProfileWrapper> createState() =>
      _OnboardingProfileWrapperState();
}

class _OnboardingProfileWrapperState
    extends ConsumerState<OnboardingProfileWrapper> {
  @override
  void initState() {
    super.initState();
    final showcaseView = ShowcaseView.register(scope: _scope);
    final localStorage = ref.read(localStorageProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final isOnboarded = await localStorage.getValue<bool>(
        StorageKeys.isOnboardedProfileKey,
      );
      if (isOnboarded == true) {
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 300));
      showcaseView.startShowCase([_appLanguageKey]);
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

class AppLanguageWrapper extends ConsumerWidget {
  const AppLanguageWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      description: S.of(context).configureAppLanguage,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(16),
      targetPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      key: _appLanguageKey,
      onTargetClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_languageToLearnKey]);
      },
      onBarrierClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_languageToLearnKey]);
      },
      onToolTipClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_languageToLearnKey]);
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

class LanguageToLearnWrapper extends ConsumerWidget {
  const LanguageToLearnWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      description: S.of(context).configureLanguageToLearn,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(16),
      targetPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      key: _languageToLearnKey,
      onTargetClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_tutorLanguageKey]);
      },
      onBarrierClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_tutorLanguageKey]);
      },
      onToolTipClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_tutorLanguageKey]);
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

class TutorLanguageWrapper extends ConsumerWidget {
  const TutorLanguageWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      description: S.of(context).configureTutorLanguage,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(16),
      targetPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      key: _tutorLanguageKey,
      onTargetClick: () {
        ref
            .read(localStorageProvider)
            .setValue(StorageKeys.isOnboardedProfileKey, true);
      },
      onBarrierClick: () {
        ref
            .read(localStorageProvider)
            .setValue(StorageKeys.isOnboardedProfileKey, true);
      },
      onToolTipClick: () {
        ref
            .read(localStorageProvider)
            .setValue(StorageKeys.isOnboardedProfileKey, true);
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
