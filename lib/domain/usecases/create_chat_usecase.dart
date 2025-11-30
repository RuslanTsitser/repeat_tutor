import '../models/chat.dart';
import '../repositories/chat_repository.dart';

/// Use Case для создания нового чата
class CreateChatUseCase {
  const CreateChatUseCase({
    required this.repository,
  });

  final ChatRepository repository;

  Future<Chat> execute(Chat chat) async {
    return await repository.createChat(chat);
  }
}

