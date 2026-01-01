import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/ab_test/enum/placement_type.dart';
import '../../../../../infrastructure/state_managers.dart';
import '../../../../paywall/presentation/paywall_screen.dart';
import 'ai_generated_pages/cycle_screen.dart';
import 'ai_generated_pages/journey_screen.dart';
import 'ai_generated_pages/victory_screen.dart';

class Onboarding5 extends ConsumerStatefulWidget {
  const Onboarding5({super.key});

  @override
  ConsumerState<Onboarding5> createState() => _Onboarding5State();
}

class _Onboarding5State extends ConsumerState<Onboarding5> {
  final PageController _pageController = PageController();
  late final onboardingNotifier = ref.read(onboardingNotifierProvider);

  @override
  void initState() {
    ref
        .read(onboardingNotifierProvider)
        .setInitialState(
          totalSteps: 4,
          onboardingName: 'onboarding5',
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
                JourneyScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                ),
                CycleScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                  onPrevious: () {
                    ref.read(onboardingNotifierProvider).previousStep();
                  },
                ),
                VictoryScreen(
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
