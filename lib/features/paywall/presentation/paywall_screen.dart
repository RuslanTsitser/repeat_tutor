import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ab_test/ab_test_service.dart';
import '../../../core/ab_test/enum/placement_type.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/use_case.dart';
import '../../home/logic/home_screen_notifier.dart';
import 'ai_generated/paywall_1.dart';
import 'ai_generated/paywall_2.dart';
import 'ai_generated/paywall_3.dart';
import 'ai_generated/paywall_4.dart';

@RoutePage()
class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key, required this.placement});
  final PlacementType placement;

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  late final AbTestService abTestService;

  @override
  void initState() {
    super.initState();
    abTestService = ref.read(abTestServiceProvider);
    abTestService.logShowPaywall(widget.placement);
  }

  @override
  void dispose() {
    abTestService.logClosePaywall(widget.placement);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Paywall(
      placement: widget.placement,
      abTestService: abTestService,
      onPurchase: () => ref.read(purchaseUseCaseProvider).purchase(),
      onClose: () => ref.read(routerProvider).pop(),
    );
  }
}

class OnboardingPaywallView extends ConsumerStatefulWidget {
  const OnboardingPaywallView({super.key, required this.placement});
  final PlacementType placement;

  @override
  ConsumerState<OnboardingPaywallView> createState() =>
      _OnboardingPaywallViewState();
}

class _OnboardingPaywallViewState extends ConsumerState<OnboardingPaywallView> {
  late final AbTestService abTestService;

  @override
  void initState() {
    super.initState();
    abTestService = ref.read(abTestServiceProvider);
    abTestService.logShowPaywall(widget.placement);
  }

  @override
  void dispose() {
    abTestService.logClosePaywall(widget.placement);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Paywall(
      placement: widget.placement,
      abTestService: abTestService,
      onPurchase: () async {
        await ref.read(purchaseUseCaseProvider).purchase();
        final isPremium = ref.read(abTestServiceProvider).isPremium;
        if (isPremium) {
          ref.read(initializeUseCaseProvider).setTab(HomeScreenTab.home);
        }
      },
      onClose: () =>
          ref.read(initializeUseCaseProvider).setTab(HomeScreenTab.home),
    );
  }
}

class _Paywall extends StatelessWidget {
  const _Paywall({
    required this.placement,
    required this.abTestService,
    required this.onPurchase,
    required this.onClose,
  });
  final PlacementType placement;
  final AbTestService abTestService;
  final VoidCallback onPurchase;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final config = abTestService.remoteConfig(placement);
    final paywallName = config.paywall;
    switch (paywallName) {
      case 'paywall1':
        return Paywall1(
          onPurchase: onPurchase,
          onClose: onClose,
        );
      case 'paywall2':
        return Paywall2(
          onPurchase: onPurchase,
          onClose: onClose,
        );
      case 'paywall3':
        return Paywall3(
          onPurchase: onPurchase,
          onClose: onClose,
        );
      case 'paywall4':
        return Paywall4(
          onPurchase: onPurchase,
          onClose: onClose,
        );
      default:
        return Paywall1(
          onPurchase: onPurchase,
          onClose: onClose,
        );
    }
  }
}
