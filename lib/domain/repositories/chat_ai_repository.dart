import '../models/chat_ai_response.dart';
import '../models/chat_configuration.dart';
import '../models/session_language.dart';

abstract interface class ChatAiRepository {
  Future<ChatAiResponse> generateWelcomeMessage(
    ChatConfiguration configuration,
  );

  Future<ChatAiResponse> sendUserMessage({
    required ChatConfiguration configuration,
    required String userMessage,
  });

  Future<String> transcribeAudio({
    required String filePath,
    required SessionLanguage language,
  });
}
