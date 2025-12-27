import '../../../core/ab_test/ab_test_service.dart';
import '../../../core/ab_test/enum/product_type.dart';
import '../../../core/router/router.dart';
import '../logic/paywall_change_notifier.dart';

class PurchaseUseCase {
  const PurchaseUseCase({
    required this.abTestService,
    required this.paywallChangeNotifier,
    required this.appRouter,
  });
  final AbTestService abTestService;
  final PaywallChangeNotifier paywallChangeNotifier;
  final AppRouter appRouter;

  Future<void> purchase({required ProductType productType}) async {
    await abTestService.purchasePaywall(
      paywallChangeNotifier.state.placementType,
      productType: productType,
      config: abTestService.remoteConfig(
        paywallChangeNotifier.state.placementType,
      ),
    );

    if (abTestService.isPremium) {
      appRouter.pop();
    }
  }

  Future<void> close() async {
    await abTestService.logClosePaywall(
      paywallChangeNotifier.state.placementType,
    );
    appRouter.pop();
  }
}
