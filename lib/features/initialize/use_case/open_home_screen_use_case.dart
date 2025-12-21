import '../../../core/database/daos/settings_dao.dart';
import '../../../core/router/router.dart';
import '../../profile/logic/profile_settings_notifier.dart';

class OpenHomeScreenUseCase {
  const OpenHomeScreenUseCase({
    required this.appRouter,
    required this.profileSettingsNotifier,
    required this.settingsDao,
  });
  final AppRouter appRouter;
  final SettingsDao settingsDao;
  final ProfileSettingsNotifier profileSettingsNotifier;

  static const String isLaunchOnboardingShownKey = 'launch_onboarding_shown';

  Future<void> execute() async {
    final isPremium = profileSettingsNotifier.state.isPremium;
    final isLaunchOnboardingShown = await settingsDao.getBoolValue(
      isLaunchOnboardingShownKey,
    );
    if (!isLaunchOnboardingShown) {
      await appRouter.push(const OnboardingRoute());
      await settingsDao.setBoolValue(isLaunchOnboardingShownKey, true);
    }
    if (!isPremium) {
      await appRouter.push(const PaywallRoute());
    }
    await appRouter.replaceAll([const HomeRoute()]);
  }
}
