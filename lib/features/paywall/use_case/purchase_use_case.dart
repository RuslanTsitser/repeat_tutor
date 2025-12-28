import 'package:ab_test_service/ab_test_service/model/user_premium_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ab_test/enum/placement_type.dart';
import '../../../core/ab_test/enum/product_type.dart';
import '../../../core/local_storage/storage_keys.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../../home/logic/home_screen_notifier.dart';

class PurchaseUseCase {
  const PurchaseUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<void> purchase({
    required PlacementType placement,
    required ProductType productType,
  }) async {
    final abTestService = ref.read(abTestServiceProvider);
    final paywallChangeNotifier = ref.read(
      paywallChangeNotifierProvider(placement),
    );
    final appRouter = ref.read(routerProvider);
    paywallChangeNotifier.setState(
      paywallChangeNotifier.state.copyWith(idPurchasing: true),
    );
    await abTestService.purchasePaywall(
      placement,
      productType: productType,
      config: abTestService.remoteConfig(
        placement,
      ),
    );
    paywallChangeNotifier.setState(
      paywallChangeNotifier.state.copyWith(idPurchasing: false),
    );
    if (abTestService.isPremium) {
      appRouter.pop();
    }
  }

  Future<void> close({required PlacementType placement}) async {
    final abTestService = ref.read(abTestServiceProvider);
    final appRouter = ref.read(routerProvider);
    await abTestService.logClosePaywall(
      placement,
    );
    appRouter.pop();
  }

  Future<void> setDebugPremium() async {
    final abTestService = ref.read(abTestServiceProvider);
    final profileSettingsUseCase = ref.read(profileSettingsUseCaseProvider);
    await abTestService.setPremium(UserPremiumSource.debug);
    await profileSettingsUseCase.loadIsPremium();
  }

  Future<void> purchaseOnboarding({
    required ProductType productType,
  }) async {
    final placement = PlacementType.placementOnboarding;
    final abTestService = ref.read(abTestServiceProvider);
    final paywallChangeNotifier = ref.read(
      paywallChangeNotifierProvider(placement),
    );
    final homeScreenNotifier = ref.read(homeScreenNotifierProvider);
    final localStorage = ref.read(localStorageProvider);

    paywallChangeNotifier.setState(
      paywallChangeNotifier.state.copyWith(idPurchasing: true),
    );
    await abTestService.purchasePaywall(
      placement,
      productType: productType,
      config: abTestService.remoteConfig(
        placement,
      ),
    );
    paywallChangeNotifier.setState(
      paywallChangeNotifier.state.copyWith(idPurchasing: false),
    );
    if (abTestService.isPremium) {
      await localStorage.setValue(
        StorageKeys.isFirstOnboardingShownKey,
        true,
      );
      homeScreenNotifier.setState(
        homeScreenNotifier.state.copyWith(tab: HomeScreenTab.home),
      );
    }
  }
}
