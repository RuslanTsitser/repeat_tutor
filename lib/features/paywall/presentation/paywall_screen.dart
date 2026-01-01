import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ab_test/ab_test_service.dart';
import '../../../core/ab_test/enum/placement_type.dart';
import '../../../core/ab_test/enum/product_type.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../../home/logic/home_screen_notifier.dart';
import 'ai_generated/subscription_screen.dart';

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

  ProductType _productType = ProductType.product1;

  @override
  Widget build(BuildContext context) {
    return SubscriptionScreen(
      selectedProductType: _productType,
      onSubscribe: () async {
        final homeScreenNotifier = ref.read(homeScreenNotifierProvider);
        ref
            .read(purchaseUseCaseProvider)
            .purchase(
              placement: widget.placement,
              productType: _productType,
            );

        ref
            .read(homeScreenNotifierProvider)
            .setState(
              homeScreenNotifier.state.copyWith(tab: HomeScreenTab.home),
            );
      },
      onSelectProductType: (productType) {
        _productType = productType;
        setState(() {});
      },
      bestProduct: ProductType.product2, // Годовая подписка
      product: ProductType.product1, // Месячная подписка
      abTestService: abTestService,
      placement: widget.placement,
    );
  }
}
