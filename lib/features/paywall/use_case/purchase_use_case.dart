import 'package:ab_test_service/ab_test_service/model/user_premium_source.dart';

import '../../../core/ab_test/ab_test_service.dart';
import '../../../core/ab_test/enum/product_type.dart';
import '../../../core/router/router.dart';
import '../../profile/logic/profile_settings_notifier.dart';
import '../logic/paywall_change_notifier.dart';

class PurchaseUseCase {
  const PurchaseUseCase({
    required this.abTestService,
    required this.paywallChangeNotifier,
    required this.appRouter,
    required this.profileSettingsNotifier,
  });
  final AbTestService abTestService;
  final PaywallChangeNotifier paywallChangeNotifier;
  final AppRouter appRouter;
  final ProfileSettingsNotifier profileSettingsNotifier;

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

  Future<void> setDebugPremium() async {
    await abTestService.setPremium(UserPremiumSource.debug);
    await profileSettingsNotifier.loadIsPremium();
  }
}
