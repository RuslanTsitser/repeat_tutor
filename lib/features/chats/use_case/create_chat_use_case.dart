import '../../../core/domain/repositories/chat_repository.dart';
import '../../../core/router/router.dart';

class CreateChatUseCase {
  const CreateChatUseCase({
    required this.chatRepository,
    required this.router,
  });
  final ChatRepository chatRepository;
  final AppRouter router;

  Future<void> execute() async {
    // TODO: Implement create chat use case
  }
}
