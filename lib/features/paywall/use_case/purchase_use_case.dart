import 'package:ab_test_service/ab_test_service/model/user_premium_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';

class PurchaseUseCase {
  const PurchaseUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<void> purchase() async {
    final abTestService = ref.read(abTestServiceProvider);
    final paywallChangeNotifier = ref.read(paywallChangeNotifierProvider);
    final appRouter = ref.read(routerProvider);
    final selectedProductType = paywallChangeNotifier.state.selectedProductType;
    if (selectedProductType == null) {
      return;
    }
    await paywallChangeNotifier.purchase(selectedProductType);
    if (abTestService.isPremium) {
      appRouter.pop();
    }
  }

  Future<void> setDebugPremium() async {
    final abTestService = ref.read(abTestServiceProvider);
    final profileSettingsUseCase = ref.read(profileSettingsUseCaseProvider);
    await abTestService.setPremium(UserPremiumSource.debug);
    await profileSettingsUseCase.loadIsPremium();
  }
}
