import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/chat.dart';
import '../../../core/router/common/full_screen_dialog.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/repositories.dart';
import '../logic/create_chat_notifier.dart';
import '../presentation/create_chat_bottom_sheet.dart';

class CreateChatUseCase {
  const CreateChatUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<Chat?> execute() async {
    final router = ref.read(routerProvider);
    final chatRepository = ref.read(chatRepositoryProvider);
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
