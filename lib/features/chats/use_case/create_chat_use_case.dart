import '../../../core/domain/repositories/chat_repository.dart';
import '../../../core/router/common/bottom_sheet.dart';
import '../../../core/router/router.dart';
import '../../profile/logic/profile_settings_notifier.dart';
import '../logic/create_chat_notifier.dart';
import '../presentation/create_chat_bottom_sheet.dart';

class CreateChatUseCase {
  const CreateChatUseCase({
    required this.chatRepository,
    required this.router,
    required this.profileSettingsNotifier,
  });
  final ChatRepository chatRepository;
  final ProfileSettingsNotifier profileSettingsNotifier;
  final AppRouter router;

  Future<void> execute() async {
    final state = await router.showAppBottomSheet<CreateChatState>(
      isScrollControlled: true,
      builder: (context) => const CreateChatBottomSheet(),
    );
    if (state != null) {
      await chatRepository.createChat(
        language: state.language,
        level: state.level,
        topic: state.topic,
        teacherLanguage: profileSettingsNotifier.state.defaultTeacherLanguage,
      );
    }
  }
}
