import 'package:dio/dio.dart';

import 'gpt_service.dart';

class GptServiceImpl implements GptService {
  const GptServiceImpl(this._dio, this._apiKey);
  final Dio _dio;
  final String _apiKey;

  @override
  Future<CreateSessionResult> createSession(String prompt) async {
    final url = 'https://api.openai.com/v1/realtime/sessions';
    final requestBody = {
      'model': 'gpt-realtime',
      'instructions': prompt,
      'voice': 'cedar',
      'turn_detection': {'type': 'semantic_vad'},
    };

    final response = await _dio.post<Map<String, dynamic>>(
      url,
      data: requestBody,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
          'OpenAI-Beta': 'realtime=v1',
        },
      ),
    );

    final data = response.data as Map<String, dynamic>;
    final sessionId = data['id'] as String;
    final clientSecretData = data['client_secret'] as Map<String, dynamic>;
    final clientSecret = clientSecretData['value'] as String;
    final expiresAt = clientSecretData['expires_at'] as int;

    final expiresAtDate = DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000);

    return CreateSessionResult(
      sessionId: sessionId,
      clientSecret: clientSecret,
      clientSecretExpiresAt: expiresAtDate,
    );
  }

  @override
  Future<String> sendOffer(
    String offer,
    String clientSecret,
  ) async {
    final url = 'https://api.openai.com/v1/realtime/calls';

    try {
      final response = await _dio.post<String>(
        url,
        data: offer,
        options: Options(
          headers: {
            'Content-Type': 'application/sdp',
            'Authorization': 'Bearer $clientSecret',
            'OpenAI-Beta': 'realtime=v1',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        // Ответ может быть в формате JSON с полем "sdp" или просто SDP текст
        final contentType = response.headers.value('content-type') ?? '';

        if (contentType.contains('application/json')) {
          final json = response.data as Map<String, dynamic>;
          return json['sdp'] as String;
        } else {
          return response.data as String;
        }
      } else {
        throw Exception(
          'HTTP ошибка: ${response.statusCode} - ${response.data}',
        );
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data?.toString() ?? e.message;
        throw Exception('Ошибка API: $errorMessage');
      }
      rethrow;
    }
  }
}
