import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/local_storage/storage_keys.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../logic/home_screen_notifier.dart';

class InitializeUseCase {
  const InitializeUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<void> execute() async {
    final abTestService = ref.read(abTestServiceProvider);
    final homeScreenNotifier = ref.read(homeScreenNotifierProvider);
    final profileSettingsUseCase = ref.read(profileSettingsUseCaseProvider);
    final localStorage = ref.read(localStorageProvider);
    await localStorage.init();
    await abTestService.init();
    await profileSettingsUseCase.loadSettings();
    await profileSettingsUseCase.loadIsPremium();
    await profileSettingsUseCase.refreshDurations();

    final isFirstOnboardingShown = await localStorage.getValue<bool>(
      StorageKeys.isFirstOnboardingShownKey,
    );
    if (isFirstOnboardingShown == true) {
      homeScreenNotifier.setState(
        homeScreenNotifier.state.copyWith(tab: HomeScreenTab.home),
      );
      return;
    }
    homeScreenNotifier.setState(
      homeScreenNotifier.state.copyWith(tab: HomeScreenTab.onboarding),
    );
  }
}
