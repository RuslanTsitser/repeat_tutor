import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/ab_test/enum/placement_type.dart';
import '../../../../../infrastructure/state_managers.dart';
import '../../../../paywall/presentation/paywall_screen.dart';
import 'ai_generated_pages/comfort_screen.dart';
import 'ai_generated_pages/flow_screen.dart';
import 'ai_generated_pages/achievement_screen.dart';

class Onboarding3 extends ConsumerStatefulWidget {
  const Onboarding3({super.key});

  @override
  ConsumerState<Onboarding3> createState() => _Onboarding3State();
}

class _Onboarding3State extends ConsumerState<Onboarding3> {
  final PageController _pageController = PageController();
  late final onboardingNotifier = ref.read(onboardingNotifierProvider);

  @override
  void initState() {
    ref
        .read(onboardingNotifierProvider)
        .setInitialState(
          totalSteps: 4,
          onboardingName: 'onboarding3',
        );
    onboardingNotifier.addListener(listener);
    super.initState();
  }

  void listener() {
    _pageController.animateToPage(
      onboardingNotifier.state.currentStep,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    onboardingNotifier.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                ComfortScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                ),
                FlowScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                  onPrevious: () {
                    ref.read(onboardingNotifierProvider).previousStep();
                  },
                ),
                AchievementScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                  onPrevious: () {
                    ref.read(onboardingNotifierProvider).previousStep();
                  },
                ),
                const OnboardingPaywallView(
                  placement: PlacementType.placementOnboarding,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

