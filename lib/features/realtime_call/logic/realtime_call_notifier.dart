import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';
import '../../../core/domain/models/chat.dart';
import '../../../core/domain/models/realtime_session.dart';
import '../../../core/logging/app_logger.dart';
import '../../../core/realtime/realtime_webrtc_manager.dart';
import '../models/realtime_event.dart';

/// Нотифаер для управления состоянием звонка Realtime API.
class RealtimeCallNotifier extends ChangeNotifier {
  RealtimeCallNotifier({
    required this.realtimeWebRTCConnection,
  }) {
    _registerCallbacks();
  }
  final RealtimeWebRTCConnection realtimeWebRTCConnection;

  bool _callbacksRegistered = false;

  void _registerCallbacks() {
    if (_callbacksRegistered) return;
    _callbacksRegistered = true;

    realtimeWebRTCConnection.onError = (error) {
      setState(
        state.copyWith(
          error: error.toString(),
          status: RealtimeCallStatus.error,
        ),
      );
    };

    realtimeWebRTCConnection.onConnect = () {
      setState(
        state.copyWith(
          status: RealtimeCallStatus.connected,
        ),
      );
    };

    realtimeWebRTCConnection.onDisconnect = () {
      setState(
        state.copyWith(
          status: RealtimeCallStatus.disconnected,
        ),
      );
    };

    realtimeWebRTCConnection.onMuted = () {
      setState(
        state.copyWith(
          isMuted: true,
        ),
      );
    };

    realtimeWebRTCConnection.onUnMuted = () {
      setState(
        state.copyWith(
          isMuted: false,
        ),
      );
    };

    realtimeWebRTCConnection.onMessage = _onMessage;

    realtimeWebRTCConnection.onAudioLevelChanged = (decibels, isLocal) {
      _onAudioLevelChanged(decibels, isLocal);
    };
  }

  void _onAudioLevelChanged(double decibels, bool isLocal) {
    if (isLocal) {
      setState(
        state.copyWith(myAudioLevel: decibels),
      );
    } else {
      setState(
        state.copyWith(tutorAudioLevel: decibels),
      );
    }
  }

  void _onMessage(String message) {
    try {
      final json = jsonDecode(message);
      final event = RealtimeEvent.fromJson(json as Map<String, dynamic>);
      switch (event.type) {
        case EventType.responseContentPartAdded:
          setState(
            // ignore: avoid_dynamic_calls
            state.copyWithTutorMessage(json['part']['transcript'] as String),
          );
          break;
        case EventType.responseAudioTranscriptDelta:
          final message = state.tutorMessage ?? '';
          final delta = json['delta'] as String;
          setState(
            state.copyWithTutorMessage(message + delta),
          );
          break;
        case EventType.responseAudioTranscriptDone:
          final transcript = json['transcript'] as String;
          setState(
            state.copyWithTutorMessage(transcript),
          );
          break;
        case EventType.responseDone:
          _handleResponseDone(json);
          break;
        case EventType.sessionCreated || EventType.rateLimitsUpdated:
          logInfo(json);
          break;
        case EventType.responseTextDone:
          _handleResponseTextDone(json);
          break;
        default:
          break;
      }
    } catch (e) {
      logError(e);
    }
  }

  /// Обрабатывает событие response.text.done
  /// TODO: вынести обработчик в отдельный класс
  void _handleResponseTextDone(Map<String, dynamic> json) {
    logInfo(json);
    try {
      final output = json['text'] as String?;
      if (output != null) {
        final value = jsonDecode(output) as Map<String, dynamic>;
        final type = value['type'] as String?;
        switch (type) {
          case 'correct_answer':
            setState(
              state.copyWith(
                originalMessage: '',
                correctedMessage: '',
                explanation: '',
                suggestedTranslation: '',
                questionAnswer: '',
              ),
            );
            break;
          case 'corrected_answer':
            setState(
              state.copyWith(
                originalMessage: value['original'] as String?,
                correctedMessage: value['corrected'] as String?,
                explanation: value['explanation'] as String?,
                suggestedTranslation: '',
                questionAnswer: '',
              ),
            );
            break;
          case 'native_language_answer':
            setState(
              state.copyWith(
                originalMessage: value['original'] as String?,
                correctedMessage: '',
                explanation: '',
                suggestedTranslation: value['suggested_translation'] as String?,
                questionAnswer: '',
              ),
            );
            break;
          case 'off_topic_answer':
            setState(
              state.copyWith(
                originalMessage: '',
                correctedMessage: '',
                explanation: '',
                suggestedTranslation: '',
                questionAnswer: '',
              ),
            );
            break;
          case 'no_answer':
            setState(
              state.copyWith(
                originalMessage: '',
                correctedMessage: '',
                explanation: '',
                suggestedTranslation: '',
                questionAnswer: '',
              ),
            );
            break;
          case 'user_question':
            setState(
              state.copyWith(
                originalMessage: '',
                correctedMessage: '',
                explanation: '',
                suggestedTranslation: '',
                questionAnswer: '',
              ),
            );
            break;
          case 'mixed_case':
            setState(
              state.copyWith(
                originalMessage: value['original'] as String?,
                correctedMessage: value['corrected'] as String?,
                explanation: value['explanation'] as String?,
                suggestedTranslation: '',
                questionAnswer: '',
              ),
            );
            break;
        }
      }
    } catch (e) {
      logError(e);
    }
  }

  String _instructionEvaluatePronunciation({
    required String teacherLanguageName,
    required String languageName,
  }) =>
      '''
- Вызови функцию evaluate_pronunciation
- Ты должен найти ошибки в произнесенной фразе пользователя
- Ожидается, что юзер будет отвечать на языке {languageName}, но он может отвечать на любом языке
- Юзер может задавать вопросы или делать комментарии вместо перевода
- Верни тип: 
  - 'correct_answer' - если фраза пользователя правильная
  - 'corrected_answer' - если фраза пользователя содержит ошибки и правильные слова
  - 'native_language_answer' - если фраза пользователя не на языке {languageName}
  - 'off_topic_answer' - если фраза пользователя не относится к теме разговора
  - 'no_answer' - если фраза пользователя не содержит ответа
  - 'user_question' - если фраза пользователя является вопросом
  - 'mixed_case' - если фраза пользователя содержит частично ответ на языке {languageName} и частично на другом языке
- В поле 'original' верни исходную фразу пользователя как есть
- В поле 'corrected' верни исправленную фразу с помощью markdown: ~~неправильное~~ **правильное**
- В поле 'explanation' верни краткое объяснение ошибки на языке {teacherLanguageName}, если есть ошибки
- В поле 'suggested_translation' верни фразу пользователя, как она должна быть сказана на языке {languageName}, если фраза не на языке {languageName}
- В поле 'question_answer' верни вопрос и ответ пользователя на языке {teacherLanguageName}, если есть вопрос
'''
          .replaceAll('{teacherLanguageName}', teacherLanguageName)
          .replaceAll('{languageName}', languageName);

  /// Обрабатывает событие response.done
  /// TODO: вынести обработчик в отдельный класс
  Future<void> _handleResponseDone(Map<String, dynamic> json) async {
    logInfo(json);
    // Извлекаем metadata из response, так как он находится внутри response
    final response = json['response'] as Map<String, dynamic>?;
    final metadata = response?['metadata'] as Map<String, dynamic>?;

    if (metadata != null && metadata['purpose'] == 'grade') {
      return;
    }
    final request = {
      'type': 'response.create',
      'response': {
        'metadata': {'purpose': 'grade'},
        'instructions': _instructionEvaluatePronunciation(
          teacherLanguageName: state.chat.teacherLanguage.localizedName,
          languageName: state.chat.chatLanguage.localizedName,
        ),
        'tools': [
          {
            'type': 'function',
            'name': 'evaluate_pronunciation',
            'parameters': {
              'type': 'object',
              'additionalProperties': false,
              'properties': {
                'type': {'type': 'string'},
                'original': {'type': 'string'},
                'corrected': {'type': 'string'},
                'explanation': {'type': 'string'},
                'suggested_translation': {'type': 'string'},
                'question_answer': {'type': 'string'},
              },
              'required': [
                'type',
                'original',
                'corrected',
                'explanation',
                'suggested_translation',
                'question_answer',
              ],
            },
          },
        ],
        'tool_choice': {'type': 'function', 'name': 'evaluate_pronunciation'},
      },
    };

    await realtimeWebRTCConnection.sendMessage(request);
  }

  RealtimeCallState _state = RealtimeCallState.initial(
    Chat(
      chatId: 0,
      createdAt: DateTime.now(),
      chatLanguage: Language.english,
      level: DifficultyLevel.beginner,
      teacherLanguage: Language.english,
      topic: '',
    ),
  );
  RealtimeCallState get state => _state;

  void setState(RealtimeCallState value) {
    _state = value;
    notifyListeners();
  }
}

enum RealtimeCallStatus {
  initial,
  connected,
  disconnected,
  error,
}

class RealtimeCallState {
  const RealtimeCallState({
    required this.sessionId,
    required this.session,
    required this.status,
    required this.isMuted,
    required this.error,
    required this.tutorMessage,
    required this.callDuration,
    required this.myAudioLevel,
    required this.tutorAudioLevel,
    required this.originalMessage,
    required this.correctedMessage,
    required this.explanation,
    required this.suggestedTranslation,
    required this.questionAnswer,
    required this.chat,
  });

  factory RealtimeCallState.initial(Chat chat) {
    return RealtimeCallState(
      sessionId: null,
      session: null,
      status: RealtimeCallStatus.initial,
      isMuted: false,
      error: null,
      tutorMessage: null,
      callDuration: Duration.zero,
      myAudioLevel: null,
      tutorAudioLevel: null,
      originalMessage: null,
      correctedMessage: null,
      explanation: null,
      suggestedTranslation: null,
      questionAnswer: null,
      chat: chat,
    );
  }

  final int? sessionId;
  final RealtimeSession? session;
  final RealtimeCallStatus status;
  final bool isMuted;
  final String? error;
  final String? tutorMessage;
  final Duration callDuration;
  final double? myAudioLevel;
  final double? tutorAudioLevel;
  final String? originalMessage;
  final String? correctedMessage;
  final String? explanation;
  final String? suggestedTranslation;
  final String? questionAnswer;
  final Chat chat;

  RealtimeCallState copyWith({
    int? sessionId,
    RealtimeSession? session,
    RealtimeCallStatus? status,
    bool? isMuted,
    String? error,
    String? tutorMessage,
    Duration? callDuration,
    double? myAudioLevel,
    double? tutorAudioLevel,
    String? originalMessage,
    String? correctedMessage,
    String? explanation,
    String? suggestedTranslation,
    String? questionAnswer,
    Chat? chat,
  }) {
    return RealtimeCallState(
      sessionId: sessionId ?? this.sessionId,
      session: session ?? this.session,
      status: status ?? this.status,
      isMuted: isMuted ?? this.isMuted,
      error: error ?? this.error,
      tutorMessage: tutorMessage ?? this.tutorMessage,
      callDuration: callDuration ?? this.callDuration,
      myAudioLevel: myAudioLevel ?? this.myAudioLevel,
      tutorAudioLevel: tutorAudioLevel ?? this.tutorAudioLevel,
      originalMessage: originalMessage ?? this.originalMessage,
      correctedMessage: correctedMessage ?? this.correctedMessage,
      explanation: explanation ?? this.explanation,
      suggestedTranslation: suggestedTranslation ?? this.suggestedTranslation,
      questionAnswer: questionAnswer ?? this.questionAnswer,
      chat: chat ?? this.chat,
    );
  }

  RealtimeCallState copyWithTutorMessage(String value) {
    return copyWith(tutorMessage: value);
  }

  bool get showCorrectionMarkdown =>
      correctedMessage != null ||
      explanation != null ||
      suggestedTranslation != null ||
      questionAnswer != null ||
      originalMessage != null;
}
