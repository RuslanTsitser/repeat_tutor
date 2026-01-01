import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ab_test/ab_test_service.dart';
import '../../../core/ab_test/enum/placement_type.dart';
import '../../../infrastructure/core.dart';
import 'ai_generated/paywall_1.dart';

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
    final config = abTestService.remoteConfig(widget.placement);
    final paywallName = config.paywall;
    if (paywallName == 'paywall1') {
      return const Paywall1();
    }
    return const Paywall1();
  }
}
