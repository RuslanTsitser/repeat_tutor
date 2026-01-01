import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/ab_test/enum/placement_type.dart';
import '../../../../../infrastructure/state_managers.dart';
import '../../../../paywall/presentation/paywall_screen.dart';
import 'ai_generated_pages/practice_screen.dart';
import 'ai_generated_pages/success_screen.dart';
import 'ai_generated_pages/welcome_screen.dart';

class Onboarding2 extends ConsumerStatefulWidget {
  const Onboarding2({super.key});

  @override
  ConsumerState<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends ConsumerState<Onboarding2> {
  final PageController _pageController = PageController();
  late final onboardingNotifier = ref.read(onboardingNotifierProvider);

  @override
  void initState() {
    ref
        .read(onboardingNotifierProvider)
        .setInitialState(
          totalSteps: 4,
          onboardingName: 'onboarding2',
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
                WelcomeScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                ),
                PracticeScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                  onPrevious: () {
                    ref.read(onboardingNotifierProvider).previousStep();
                  },
                ),
                SuccessScreen(
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
