import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ab_test/enum/placement_type.dart';
import '../../../infrastructure/core.dart';
import 'onboardings/onboarding_1/onboarding1.dart';
import 'onboardings/onboarding_2/onboarding2.dart';
import 'onboardings/onboarding_3/onboarding3.dart';
import 'onboardings/onboarding_4/onboarding4.dart';
import 'onboardings/onboarding_5/onboarding5.dart';
import 'onboardings/onboarding_6/onboarding6.dart';

@RoutePage()
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final abTestService = ref.read(abTestServiceProvider);
    final config = abTestService.remoteConfig(
      PlacementType.placementOnboarding,
    );
    final onboardingName = config.onboarding;
    switch (onboardingName) {
      case 'onboarding1':
        return const Onboarding1();
      case 'onboarding2':
        return const Onboarding2();
      case 'onboarding3':
        return const Onboarding3();
      case 'onboarding4':
        return const Onboarding4();
      case 'onboarding5':
        return const Onboarding5();
      case 'onboarding6':
        return const Onboarding6();

      default:
        return const Onboarding1();
    }
  }
}
