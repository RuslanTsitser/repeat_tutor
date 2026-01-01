import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/ab_test/enum/placement_type.dart';
import '../../../../../infrastructure/state_managers.dart';
import '../../../../paywall/presentation/paywall_screen.dart';
import 'ai_generated_pages/growth_screen.dart';
import 'ai_generated_pages/process_screen.dart';
import 'ai_generated_pages/milestone_screen.dart';

class Onboarding4 extends ConsumerStatefulWidget {
  const Onboarding4({super.key});

  @override
  ConsumerState<Onboarding4> createState() => _Onboarding4State();
}

class _Onboarding4State extends ConsumerState<Onboarding4> {
  final PageController _pageController = PageController();
  late final onboardingNotifier = ref.read(onboardingNotifierProvider);

  @override
  void initState() {
    ref
        .read(onboardingNotifierProvider)
        .setInitialState(
          totalSteps: 4,
          onboardingName: 'onboarding4',
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
                GrowthScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                ),
                ProcessScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                  onPrevious: () {
                    ref.read(onboardingNotifierProvider).previousStep();
                  },
                ),
                MilestoneScreen(
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

