import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/ab_test/enum/placement_type.dart';
import '../../../../../infrastructure/state_managers.dart';
import '../../../../paywall/presentation/paywall_screen.dart';
import 'ai_generated_pages/empathy_screen.dart';
import 'ai_generated_pages/method_screen.dart';
import 'ai_generated_pages/result_screen.dart';

class Onboarding1 extends ConsumerStatefulWidget {
  const Onboarding1({super.key});

  @override
  ConsumerState<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends ConsumerState<Onboarding1> {
  final PageController _pageController = PageController();
  late final onboardingNotifier = ref.read(onboardingNotifierProvider);

  @override
  void initState() {
    ref
        .read(onboardingNotifierProvider)
        .setInitialState(
          totalSteps: 4,
          onboardingName: 'onboarding1',
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
                EmpathyScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                ),
                MethodScreen(
                  onNext: () {
                    ref.read(onboardingNotifierProvider).nextStep();
                  },
                  onPrevious: () {
                    ref.read(onboardingNotifierProvider).previousStep();
                  },
                ),
                ResultScreen(
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
          // const _Button(),
        ],
      ),
    );
  }
}
