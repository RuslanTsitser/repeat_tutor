import '../models/chat_configuration.dart';

/// Репозиторий для хранения настроек практических чатов
abstract interface class ChatConfigurationRepository {
  Future<ChatConfiguration?> getByChatId(String chatId);

  Future<List<ChatConfiguration>> getAll();

  Future<ChatConfiguration> upsert(ChatConfiguration configuration);

  Future<void> deleteByChatId(String chatId);
}
