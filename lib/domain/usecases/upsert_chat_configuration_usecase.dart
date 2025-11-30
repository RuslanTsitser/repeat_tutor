import '../models/chat_configuration.dart';
import '../repositories/chat_configuration_repository.dart';

class UpsertChatConfigurationUseCase {
  const UpsertChatConfigurationUseCase({
    required this.repository,
  });

  final ChatConfigurationRepository repository;

  Future<ChatConfiguration> execute(ChatConfiguration configuration) {
    return repository.upsert(configuration);
  }
}
