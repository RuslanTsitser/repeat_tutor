import '../models/chat.dart';
import '../repositories/chat_repository.dart';

/// Use Case для получения списка чатов
class GetChatsUseCase {
  const GetChatsUseCase({
    required this.repository,
  });

  final ChatRepository repository;

  Future<List<Chat>> execute() async {
    return await repository.getChats();
  }
}

