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
    final abTestService = ref.watch(abTestServiceProvider);
    final homeScreenNotifier = ref.watch(homeScreenNotifierProvider);
    final profileSettingsUseCase = ref.watch(profileSettingsUseCaseProvider);
    final localStorageService = ref.watch(localStorageServiceProvider);
    await localStorageService.init();
    await abTestService.init();
    await profileSettingsUseCase.loadSettings();
    await profileSettingsUseCase.loadIsPremium();
    await profileSettingsUseCase.refreshDurations();
    homeScreenNotifier.setState(
      homeScreenNotifier.state.copyWith(tab: HomeScreenTab.home),
    );
  }
}
