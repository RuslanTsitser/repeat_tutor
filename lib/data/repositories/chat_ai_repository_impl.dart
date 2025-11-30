import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

import '../../domain/models/chat_ai_response.dart';
import '../../domain/models/chat_configuration.dart';
import '../../domain/models/session_language.dart';
import '../../domain/repositories/chat_ai_repository.dart';

class ChatAiRepositoryImpl implements ChatAiRepository {
  ChatAiRepositoryImpl({
    required this.dio,
    required this.apiKey,
  });

  final Dio dio;
  final String apiKey;

  static const _responsesEndpoint = 'https://api.openai.com/v1/responses';
  static const _transcriptionEndpoint =
      'https://api.openai.com/v1/audio/transcriptions';

  @override
  Future<ChatAiResponse> generateWelcomeMessage(
    ChatConfiguration configuration,
  ) {
    final prompt =
        'Создай короткое приветственное сообщение и призыв к действию для ученика. '
        'Тема занятия: "${configuration.topic}". Напомни студенту, что он может '
        'написать сообщение или записать голосовое, чтобы начать практику.';

    return _sendPrompt(
      configuration: configuration,
      userPrompt: prompt,
      isWelcome: true,
    );
  }

  @override
  Future<ChatAiResponse> sendUserMessage({
    required ChatConfiguration configuration,
    required String userMessage,
  }) {
    return _sendPrompt(
      configuration: configuration,
      userPrompt: userMessage,
      isWelcome: false,
    );
  }

  @override
  Future<String> transcribeAudio({
    required String filePath,
    required SessionLanguage language,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        filePath,
        filename: p.basename(filePath),
      ),
      'model': 'gpt-4o-mini-transcribe',
      'response_format': 'text',
      'language': language.localeCode,
    });

    final response = await dio.post<String>(
      _transcriptionEndpoint,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
        },
      ),
    );

    return response.data?.trim() ?? '';
  }

  Future<ChatAiResponse> _sendPrompt({
    required ChatConfiguration configuration,
    required String userPrompt,
    required bool isWelcome,
  }) async {
    final instructions = _buildSystemPrompt(configuration, isWelcome);

    final payload = {
      'model': 'gpt-4o-mini-tts',
      'modalities': ['text', 'audio'],
      'audio': {
        'voice': _mapVoice(configuration.language),
        'format': 'wav',
      },
      'instructions': instructions,
      'input': [
        {
          'role': 'user',
          'content': [
            {
              'type': 'text',
              'text': userPrompt,
            },
          ],
        },
      ],
    };

    final response = await dio.post<Map<String, dynamic>>(
      _responsesEndpoint,
      data: payload,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      ),
    );

    final output = response.data?['output'] as List<dynamic>? ?? [];

    final buffer = StringBuffer();
    String? audioBase64;

    for (final item in output) {
      final content = item['content'] as List<dynamic>? ?? [];
      for (final chunk in content) {
        final type = chunk['type'];
        if (type == 'output_text') {
          final text = chunk['text'] as String? ?? '';
          buffer.write(text);
        } else if (type == 'output_audio') {
          final audio = chunk['audio'] as Map<String, dynamic>? ?? {};
          audioBase64 = audio['data'] as String?;
        }
      }
    }

    final cleaned = _extractCorrections(buffer.toString());

    return ChatAiResponse(
      text: cleaned.text,
      audioBase64: audioBase64,
      corrections: cleaned.corrections,
    );
  }

  String _buildSystemPrompt(
    ChatConfiguration configuration,
    bool isWelcome,
  ) {
    final intro = isWelcome
        ? 'Это первое сообщение ученику. Будь особенно дружелюбным.'
        : 'Продолжай диалог.';

    return '''
Ты — персональный репетитор по ${configuration.language.localizedName}.
Студент находится на уровне ${configuration.difficulty.name}. 
Основная тема диалога: "${configuration.topic}".
$intro

Отвечай только на ${configuration.language.localizedName}.
В ответе обязательно соблюдай формат:
1) Основной ответ.
2) Блок с исправленным вариантом сообщения ученика в теге [CORRECTIONS]...[/CORRECTIONS].
Если ошибок нет, внутри тегов напиши "Ошибок нет".

Всегда добавляй призыв к действию, который побуждает продолжить разговор.
''';
  }

  ({String text, String? corrections}) _extractCorrections(String source) {
    final correctionsRegExp = RegExp(
      r'\[CORRECTIONS\](.*?)\[/CORRECTIONS\]',
      dotAll: true,
    );
    final match = correctionsRegExp.firstMatch(source);

    String? corrections;
    if (match != null) {
      corrections = match.group(1)?.trim();
    }

    final cleanedText = source.replaceAll(correctionsRegExp, '').trim();

    return (text: cleanedText, corrections: corrections);
  }

  String _mapVoice(SessionLanguage language) {
    // Можно расширить список голосов при необходимости
    switch (language) {
      case SessionLanguage.japanese:
        return 'haru';
      case SessionLanguage.portugueseEuropean:
      case SessionLanguage.portugueseBrazilian:
        return 'cora';
      case SessionLanguage.spanish:
        return 'luna';
      case SessionLanguage.french:
        return 'marie';
      case SessionLanguage.italian:
        return 'bianca';
      case SessionLanguage.german:
        return 'fenrir';
      case SessionLanguage.russian:
        return 'alloy';
      case SessionLanguage.english:
        return 'alloy';
    }
  }
}
