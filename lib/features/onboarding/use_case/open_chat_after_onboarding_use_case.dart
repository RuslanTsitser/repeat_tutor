import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ab_test/enum/placement_type.dart';
import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';
import '../../../core/local_storage/storage_keys.dart';
import '../../../core/router/router.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/repositories.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../../home/logic/home_screen_notifier.dart';

class OpenChatAfterOnboardingUseCase {
  const OpenChatAfterOnboardingUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<void> openChatAfterOnboarding() async {
    final appRouter = ref.read(routerProvider);
    final abTestService = ref.read(abTestServiceProvider);
    final homeScreenNotifier = ref.read(homeScreenNotifierProvider);
    final localStorage = ref.read(localStorageProvider);
    final profileState = ref.read(profileProvider).state;
    final onboarding6State = ref.read(onboarding6NotifierProvider).state;

    final chatRepository = ref.read(chatRepositoryProvider);

    final chat = await chatRepository.createChat(
      language: profileState.defaultLanguageToLearn ?? Language.english,
      level: onboarding6State.currentLevel ?? DifficultyLevel.beginner,
      topic: onboarding6State.selectedTopic ?? '',
      teacherLanguage: profileState.defaultTeacherLanguage ?? Language.english,
    );
    localStorage.setValue(StorageKeys.isFirstOnboardingShownKey, true);

    if (!abTestService.userPremiumSource.isPremium) {
      await appRouter.push(
        PaywallRoute(placement: PlacementType.placementOnboarding),
      );
    }

    await ref.read(openScreenUseCaseProvider).openChat(chat);
    homeScreenNotifier.setState(
      homeScreenNotifier.state.copyWith(tab: HomeScreenTab.home),
    );
  }
}
