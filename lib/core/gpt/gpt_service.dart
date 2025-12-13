abstract interface class GptService {
  /// Создает сессию в OpenAI API
  Future<CreateSessionResult> createSession(String prompt);

  /// Отправляет Offer в OpenAI API
  /// Возвращает Answer в формате SDP
  Future<String> sendOffer(String offer, String clientSecret);
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
