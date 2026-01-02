import '../../../core/domain/models/chat.dart';
import '../../../core/domain/repositories/chat_repository.dart';
import '../../../core/router/common/full_screen_dialog.dart';
import '../../../core/router/router.dart';
import '../../profile/logic/profile_notifier.dart';
import '../logic/create_chat_notifier.dart';
import '../presentation/create_chat_bottom_sheet.dart';

class CreateChatUseCase {
  const CreateChatUseCase({
    required this.chatRepository,
    required this.router,
    required this.profileSettingsNotifier,
  });
  final ChatRepository chatRepository;
  final ProfileNotifier profileSettingsNotifier;
  final AppRouter router;

  Future<Chat?> execute() async {
    final state = await router.routeWrapper<CreateChatState>(
      builder: (context) => const CreateChatBottomSheet(),
    );
    if (state != null) {
      final chat = await chatRepository.createChat(
        language: state.language,
        level: state.level,
        topic: state.topic,
        teacherLanguage: state.teacherLanguage,
      );
      return chat;
    }
    return null;
  }
}
