abstract interface class GptService {
  /// Создает сессию в OpenAI API
  Future<CreateSessionResult> createSession(String prompt);

  /// Отправляет Offer в OpenAI API
  /// Возвращает Answer в формате SDP
  Future<String> sendOffer(String offer, String clientSecret);

  /// Отправляет сообщение в OpenAI API
  Future<ConversationMessage> sendMessage({
    required String systemPrompt,
    String? previousMessageId,
    String? text,
    String? audioBase64,
  });

  /// Отправляет аудио в OpenAI API
  Future<String> sendAudio(String filePath);
}

class CreateSessionResult {
  const CreateSessionResult({
    required this.sessionId,
    required this.clientSecret,
    required this.clientSecretExpiresAt,
  });
  final String sessionId;
  final String clientSecret;
  final DateTime clientSecretExpiresAt;
}

class ConversationMessage {
  const ConversationMessage({
    required this.text,
    required this.id,
  });
  final String text;
  final String id;
}
