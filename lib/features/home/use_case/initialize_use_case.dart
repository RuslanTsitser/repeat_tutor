import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final onboardingNotifier = ref.read(onboardingNotifierProvider);
    await localStorage.init();
    await abTestService.init();
    await profileSettingsUseCase.loadSettings();
    await profileSettingsUseCase.loadIsPremium();
    await profileSettingsUseCase.refreshDurations();

    onboardingNotifier.setInitialState(
      totalSteps: 3,
      onboardingName: 'default',
    );

    /// TODO: add logic for onboarding or home
    homeScreenNotifier.setState(
      homeScreenNotifier.state.copyWith(tab: HomeScreenTab.onboarding),
    );
  }
}
