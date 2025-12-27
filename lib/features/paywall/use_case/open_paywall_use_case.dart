import '../../../core/ab_test/ab_test_service.dart';
import '../../../core/ab_test/enum/placement_type.dart';
import '../../../core/router/router.dart';
import '../../profile/logic/profile_notifier.dart';
import '../logic/paywall_change_notifier.dart';

class OpenPaywallUseCase {
  const OpenPaywallUseCase({
    required this.paywallChangeNotifier,
    required this.abTestService,
    required this.appRouter,
    required this.profileSettingsNotifier,
  });
  final PaywallChangeNotifier paywallChangeNotifier;
  final AbTestService abTestService;
  final AppRouter appRouter;
  final ProfileNotifier profileSettingsNotifier;

  /// Возвращает true, если пользователь уже премиум, иначе открывает paywall и
  /// возвращает true, если пользователь стал премиум, иначе false.
  Future<bool> openPaywall({
    required PlacementType placementType,
  }) async {
    final isPremium = profileSettingsNotifier.state.isPremium;
    if (isPremium) {
      return true;
    } else {
      paywallChangeNotifier.setState(
        paywallChangeNotifier.state.copyWith(
          placementType: placementType,
        ),
      );
      await abTestService.logShowPaywall(placementType);
      await appRouter.push(const PaywallRoute());
      await profileSettingsNotifier.loadIsPremium();
      if (profileSettingsNotifier.state.isPremium) {
        return true;
      }
      return false;
    }
  }
}
