import '../models/chat_configuration.dart';
import '../repositories/chat_configuration_repository.dart';

class GetChatConfigurationUseCase {
  const GetChatConfigurationUseCase({
    required this.repository,
  });

  final ChatConfigurationRepository repository;

  Future<ChatConfiguration?> execute(String chatId) {
    return repository.getByChatId(chatId);
  }
}
