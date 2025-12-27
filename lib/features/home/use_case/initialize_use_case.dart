import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../logic/home_screen_notifier.dart';

class InitializeUseCase {
  const InitializeUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<void> execute() async {
    final abTestService = ref.watch(abTestServiceProvider);
    final homeScreenNotifier = ref.watch(homeScreenNotifierProvider);
    await abTestService.init();
    homeScreenNotifier.setState(
      homeScreenNotifier.state.copyWith(tab: HomeScreenTab.home),
    );
  }
}
