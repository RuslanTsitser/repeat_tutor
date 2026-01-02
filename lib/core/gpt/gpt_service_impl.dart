import 'dart:convert';

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
      'input_audio_noise_reduction': {'type': 'far_field'},
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

  @override
  Future<ConversationMessage> sendMessage({
    required String systemPrompt,
    String? previousMessageId,
    String? text,
    String? audioBase64,
  }) async {
    const url = 'https://api.openai.com/v1/responses';

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        url,
        data: {
          'model': 'gpt-4.1',
          'instructions': systemPrompt,
          if (previousMessageId != null)
            'previous_response_id': previousMessageId,
          'input': [
            {
              'role': 'user',
              'content': [
                if (text != null) {'type': 'input_text', 'text': text},
                if (audioBase64 != null)
                  {
                    'type': 'input_file',
                    'file_data': audioBase64,
                  },
              ],
            },
          ],
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_apiKey',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return ConversationMessage(
          // ignore: avoid_dynamic_calls
          text: response.data?['output'][0]['content'][0]['text'] as String,
          id: response.data?['id'] as String,
        );
      }
      throw Exception(
        'HTTP ошибка: ${response.statusCode} - ${response.data}',
      );
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data?.toString() ?? e.message;
        throw Exception('Ошибка API: $errorMessage');
      }
      rethrow;
    }
  }

  @override
  Future<String> sendAudio(String filePath) async {
    const url = 'https://api.openai.com/v1/audio/transcriptions';
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        url,
        data: FormData.fromMap({
          'model': 'gpt-4o-transcribe',
          'file': await MultipartFile.fromFile(filePath),
          'prompt': '''Фразу нельзя переводить, 
нужно вернуть текст как есть, даже если в ней есть несколько языков. 
Русский и другие, которые на кириллице, должны быть кириллицей, другие языки латиницей.''',
        }),
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $_apiKey',
          },
        ),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return response.data?['text'] as String;
      }
      throw Exception(
        'HTTP ошибка: ${response.statusCode} - ${response.data}',
      );
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data?.toString() ?? e.message;
        throw Exception('Ошибка API: $errorMessage');
      }
      rethrow;
    }
  }

  @override
  Future<(TutorAnswer, String)> getTutorAnswer({
    required String systemPrompt,
    required String text,
    String? previousMessageId,
  }) async {
    const url = 'https://api.openai.com/v1/responses';
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        url,
        data: {
          if (previousMessageId != null)
            'previous_response_id': previousMessageId,
          'model': 'gpt-4.1',
          'input': text,
          'instructions': systemPrompt,
          'text': _tutorAnswerFormat,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_apiKey',
          },
        ),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final text =
            // ignore: avoid_dynamic_calls
            response.data?['output'][0]['content'][0]['text'] as String;
        final id = response.data?['id'] as String;
        return (
          TutorAnswer.fromJson(jsonDecode(text) as Map<String, dynamic>),
          id,
        );
      }
      throw Exception(
        'HTTP ошибка: ${response.statusCode} - ${response.data}',
      );
    } on Exception catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data?.toString() ?? e.message;
        throw Exception('Ошибка API: $errorMessage');
      }
      rethrow;
    }
  }
}

const _tutorAnswerFormat = {
  'format': {
    'type': 'json_schema',
    'name': 'tutor_answer',
    'strict': true,
    'schema': {
      'type': 'object',
      'additionalProperties': false,
      'properties': {
        'case_type': {
          'type': 'string',
          'enum': [
            'correct_answer',
            'corrected_answer',
            'native_language_answer',
            'off_topic_answer',
            'no_answer',
            'user_question',
            'mixed_case',
          ],
          'description': 'Тип ситуации в текущем ходе диалога',
        },
        'assistant_message': {
          'type': 'string',
          'description':
              'Основной текст ответа пользователю (на teacherLanguageName)',
        },
        'correction': {
          'type': ['object', 'null'],
          'additionalProperties': false,
          'properties': {
            'original': {
              'type': 'string',
              'description': 'Исходный ответ пользователя',
            },
            'corrected_markdown': {
              'type': 'string',
              'description':
                  'Исправленный вариант с markdown (~~ошибка~~ **правильно**)',
            },
            'explanation': {
              'type': 'string',
              'description':
                  'Короткое объяснение ошибки на teacherLanguageName',
            },
          },
          'required': ['original', 'corrected_markdown', 'explanation'],
        },
        'suggested_translation': {
          'type': ['object', 'null'],
          'additionalProperties': false,
          'properties': {
            'user_meaning': {
              'type': 'string',
              'description': 'Что пользователь хотел сказать',
            },
            'translation': {
              'type': 'string',
              'description': 'Как это сказать на languageName',
            },
          },
          'required': ['user_meaning', 'translation'],
        },
        'user_question_answer': {
          'type': ['object', 'null'],
          'additionalProperties': false,
          'properties': {
            'question': {
              'type': 'string',
              'description': 'Вопрос пользователя',
            },
            'answer': {
              'type': 'string',
              'description': 'Ответ на вопрос (на teacherLanguageName)',
            },
          },
          'required': ['question', 'answer'],
        },
        'conversation_continue': {
          'type': 'string',
          'description': 'Фраза или вопрос для продолжения разговора',
        },
      },
      'required': [
        'case_type',
        'assistant_message',
        'correction',
        'suggested_translation',
        'user_question_answer',
        'conversation_continue',
      ],
    },
  },
};
