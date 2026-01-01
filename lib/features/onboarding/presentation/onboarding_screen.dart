import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ab_test/enum/placement_type.dart';
import '../../../infrastructure/core.dart';
import 'onboardings/onboarding_1/onboarding1.dart';

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

      default:
        return const Onboarding1();
    }
  }
}
