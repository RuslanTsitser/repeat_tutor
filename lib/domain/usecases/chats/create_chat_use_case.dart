import '../../../core/router/router.dart';
import '../../../presentation/screens/create_chat_screen.dart';
import '../../repositories/chat_repository.dart';

class CreateChatUseCase {
  const CreateChatUseCase({
    required this.chatRepository,
    required this.router,
  });
  final ChatRepository chatRepository;
  final AppRouter router;

  Future<void> execute() async {
    final result = await router.push(const CreateChatRoute());
    if (result is CreateChatEntity) {
      await chatRepository.createChat(
        language: result.language.value,
        level: result.level.value,
        topic: result.topic,
      );
    }
  }
}
