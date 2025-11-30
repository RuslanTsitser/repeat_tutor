import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/repositories.dart';
import '../../presentation/notifiers/chat_notifier.dart';
import '../repositories/chat_repository.dart';

final getChatsUseCaseProvider = Provider((ref) {
  return GetChatsUseCase(
    chatRepository: ref.watch(chatRepositoryProvider),
    chatNotifier: ref.watch(chatNotifierProvider),
  );
});

class GetChatsUseCase {
  const GetChatsUseCase({
    required this.chatRepository,
    required this.chatNotifier,
  });
  final ChatRepository chatRepository;
  final ChatNotifier chatNotifier;

  Future<void> execute() async {
    if (chatNotifier.state.isLoading) return;
    try {
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          isLoading: true,
          error: null,
        ),
      );
      final chats = await chatRepository.getChats();
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          chats: chats,
          error: null,
        ),
      );
    } on Exception catch (e) {
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          error: e.toString(),
        ),
      );
    } finally {
      chatNotifier.setState(
        chatNotifier.state.copyWith(
          isLoading: false,
        ),
      );
    }
  }
}
