// ignore_for_file: dangling_library_doc_comments

enum EventType {
  sessionCreated,
  inputAudioBufferSpeechStarted,
  inputAudioBufferSpeechStopped,
  inputAudioBufferCommitted,
  conversationItemCreated,
  responseCreated,
  responseOutputItemAdded,
  responseContentPartAdded,
  responseAudioTranscriptDelta,
  responseAudioDone,
  responseAudioTranscriptDone,
  responseContentPartDone,
  responseOutputItemDone,
  responseDone,
  rateLimitsUpdated,
  outputAudioBufferStopped,
  responseTextDelta,
  responseTextDone,
  unknown;

  String get key => switch (this) {
    sessionCreated => 'session.created',
    inputAudioBufferSpeechStarted => 'input_audio_buffer.speech_started',
    inputAudioBufferSpeechStopped => 'input_audio_buffer.speech_stopped',
    inputAudioBufferCommitted => 'input_audio_buffer.committed',
    conversationItemCreated => 'conversation.item.created',
    responseCreated => 'response.created',
    responseOutputItemAdded => 'response.output_item.added',
    responseContentPartAdded => 'response.content_part.added',
    responseAudioTranscriptDelta => 'response.audio_transcript.delta',
    responseAudioDone => 'response.audio.done',
    responseAudioTranscriptDone => 'response.audio_transcript.done',
    responseContentPartDone => 'response.content_part.done',
    responseOutputItemDone => 'response.output_item.done',
    responseDone => 'response.done',
    rateLimitsUpdated => 'rate_limits.updated',
    outputAudioBufferStopped => 'output_audio_buffer.stopped',
    responseTextDelta => 'response.text.delta',
    responseTextDone => 'response.text.done',
    unknown => 'unknown',
  };

  static EventType fromString(String type) {
    return EventType.values.firstWhere(
      (e) => e.key == type,
      orElse: () => EventType.unknown,
    );
  }
}

class RealtimeEvent {
  final EventType type;
  final String eventId;

  RealtimeEvent({
    required this.type,
    required this.eventId,
  });

  factory RealtimeEvent.fromJson(Map<String, dynamic> json) {
    final type = EventType.fromString(json['type'] as String);
    final eventId = json['event_id'] as String;
    return RealtimeEvent(
      type: type,
      eventId: eventId,
    );
  }
}

/**
 * {
        "type": "session.created",
        "event_id": "event_CtcSeEObnmtqHnoisFL15",
        "session": {
          "object": "realtime.session",
          "id": "sess_CtcScQt5bsY8u5HDq4ZOD",
          "model": "gpt-realtime",
          "modalities": [
            "audio",
            "text"
          ],
          "instructions": "Ты учитель языка. Твой родной язык - English, и ты обучаешь пользователя говорить на языке Português (Brasil) на уровне Elementary A2.\n\nТема: Hobbies\nТвоя задача:\n1. Сказать естественную фразу на языке English (1-3 предложения, подходящие для уровня Elementary A2)\n2. Пользователь должен перевести и сказать эту фразу на языке Português (Brasil)\n3. Подожди ответа пользователя - не предполагай, что тишина означает, что пользователь закончил. Пользователь может думать, искать слова, или вздохнуть.\n4. Когда пользователь закончил говорить, оцени его перевод:\n - Если перевод правильный или хороший, похвали его минимальной похвалой (например: \"Хорошо!\" или \"Правильно!\") на языке English\n - Если есть ошибки, предоставь краткое и ясное обратное связь на языке English, указывая на то, что было неправильно\n - Затем спроси, хочет ли он повторить эту фразу или перейти к следующей\n5. Хороший/правильный означает, что пользователь перевел фразу точно. Небольшие ошибки в произношении или грамматике приемлемы - главное, чтобы смысл был правильным.\n6. Пользователь может задавать вопросы или делать комментарии вместо перевода. Если пользователь задает вопрос или делает комментарий, ответьте на него кратко и ясно на языке English, используя простые слова. Затем повторите целевую фразу еще раз на языке English.\n7. Если пользователь не знает, как сказать, то предложи ему вариант на языке Português (Brasil).\n8. Если юзер ответил правильно, то предлагай следующую фразу на языке English.\n\nВсегда общайтесь с пользователем на языке English. Пользователь может говорить на любом языке, но вы должны отвечать только на языке English.\n",
          "voice": "cedar",
          "output_audio_format": "pcm16",
          "tools": [],
          "tool_choice": "auto",
          "temperature": 0.8,
          "max_response_output_tokens": "inf",
          "turn_detection": {
            "type": "semantic_vad",
            "eagerness": "auto",
            "create_response": true,
            "interrupt_response": true
          },
          "speed": 1.0,
          "tracing": null,
          "truncation": "auto",
          "prompt": null,
          "expires_at": 1767375520,
          "input_audio_noise_reduction": null,
          "input_audio_format": "pcm16",
          "input_audio_transcription": null,
          "client_secret": null,
          "include": null
        }
      }


      {
        "type": "input_audio_buffer.speech_started",
        "event_id": "event_CtcSgffxwgdyYIo9VW5D2",
        "audio_start_ms": 940,
        "item_id": "item_CtcSgQpeUlitPVIsx1lxr"
      }

      {
        "type": "input_audio_buffer.speech_stopped",
        "event_id": "event_CtcSi7C120a0TVf460HFu",
        "audio_end_ms": 2816,
        "item_id": "item_CtcSgQpeUlitPVIsx1lxr"
      }

      {
        "type": "input_audio_buffer.committed",
        "event_id": "event_CtcSi6YVGEmYDYQHmUapL",
        "previous_item_id": null,
        "item_id": "item_CtcSgQpeUlitPVIsx1lxr"
      }

      {
        "type": "conversation.item.created",
        "event_id": "event_CtcSiiuU6jygvOHGUZM73",
        "previous_item_id": null,
        "item": {
          "id": "item_CtcSgQpeUlitPVIsx1lxr",
          "object": "realtime.item",
          "type": "message",
          "status": "completed",
          "role": "user",
          "content": [
            {
              "type": "input_audio",
              "transcript": null
            }
          ]
        }
      }

      {
        "type": "response.created",
        "event_id": "event_CtcSi2EE71SxoF8n0Y3q1",
        "response": {
          "object": "realtime.response",
          "id": "resp_CtcSie6XsD9cPaELIeCRx",
          "status": "in_progress",
          "status_details": null,
          "output": [],
          "conversation_id": "conv_CtcSeOD1qXRec1WgfQSYW",
          "modalities": [
            "text",
            "audio"
          ],
          "voice": "cedar",
          "output_audio_format": "pcm16",
          "temperature": 0.8,
          "max_output_tokens": "inf",
          "usage": null,
          "metadata": null
        }
      }

      {
        "type": "response.output_item.added",
        "event_id": "event_CtcSj4Km49j1jAS0BKcrg",
        "response_id": "resp_CtcSie6XsD9cPaELIeCRx",
        "output_index": 0,
        "item": {
          "id": "item_CtcSiXeUfBSr27FWYb13U",
          "object": "realtime.item",
          "type": "message",
          "status": "in_progress",
          "role": "assistant",
          "content": []
        }
      }

      {
        "type": "conversation.item.created",
        "event_id": "event_CtcSjUNtpwaZorIRQIJih",
        "previous_item_id": "item_CtcSgQpeUlitPVIsx1lxr",
        "item": {
          "id": "item_CtcSiXeUfBSr27FWYb13U",
          "object": "realtime.item",
          "type": "message",
          "status": "in_progress",
          "role": "assistant",
          "content": []
        }
      }

      {
        "type": "response.content_part.added",
        "event_id": "event_CtcSjDIlaicoIMvKDSSW4",
        "response_id": "resp_CtcSie6XsD9cPaELIeCRx",
        "item_id": "item_CtcSiXeUfBSr27FWYb13U",
        "output_index": 0,
        "content_index": 0,
        "part": {
          "type": "audio",
          "transcript": ""
        }
      }

      {
        "type": "response.audio_transcript.delta",
        "event_id": "event_CtcSjEKOdzN6AJiNIeM54",
        "response_id": "resp_CtcSie6XsD9cPaELIeCRx",
        "item_id": "item_CtcSiXeUfBSr27FWYb13U",
        "output_index": 0,
        "content_index": 0,
        "delta": "Hello",
        "obfuscation": "OnD7m1ulCN1"
      }

      {
        "type": "response.audio.done",
        "event_id": "event_CtcSlltP80ge9PrQoCh3j",
        "response_id": "resp_CtcSie6XsD9cPaELIeCRx",
        "item_id": "item_CtcSiXeUfBSr27FWYb13U",
        "output_index": 0,
        "content_index": 0
      }

      {
        "type": "response.audio_transcript.done",
        "event_id": "event_CtcSlVXLOb9nXIqhslXmW",
        "response_id": "resp_CtcSie6XsD9cPaELIeCRx",
        "item_id": "item_CtcSiXeUfBSr27FWYb13U",
        "output_index": 0,
        "content_index": 0,
        "transcript": "Hello! Good morning! Let’s get started. Here is our first sentence: “I like to read books in my free time.”"
      }

      {
        "type": "response.content_part.done",
        "event_id": "event_CtcSl0xXwp8z2N6gFKn6V",
        "response_id": "resp_CtcSie6XsD9cPaELIeCRx",
        "item_id": "item_CtcSiXeUfBSr27FWYb13U",
        "output_index": 0,
        "content_index": 0,
        "part": {
          "type": "audio",
          "transcript": "Hello! Good morning! Let’s get started. Here is our first sentence: “I like to read books in my free time.”"
        }
      }

      {
        "type": "response.output_item.done",
        "event_id": "event_CtcSlvy7ndaAJ2jfvZcMi",
        "response_id": "resp_CtcSie6XsD9cPaELIeCRx",
        "output_index": 0,
        "item": {
          "id": "item_CtcSiXeUfBSr27FWYb13U",
          "object": "realtime.item",
          "type": "message",
          "status": "completed",
          "role": "assistant",
          "content": [
            {
              "type": "audio",
              "transcript": "Hello! Good morning! Let’s get started. Here is our first sentence: “I like to read books in my free time.”"
            }
          ]
        }
      }

      {
        "type": "response.done",
        "event_id": "event_CtcSlNzn4F4Bg6DouNRoN",
        "response": {
          "object": "realtime.response",
          "id": "resp_CtcSie6XsD9cPaELIeCRx",
          "status": "completed",
          "status_details": null,
          "output": [
            {
              "id": "item_CtcSiXeUfBSr27FWYb13U",
              "object": "realtime.item",
              "type": "message",
              "status": "completed",
              "role": "assistant",
              "content": [
                {
                  "type": "audio",
                  "transcript": "Hello! Good morning! Let’s get started. Here is our first sentence: “I like to read books in my free time.”"
                }
              ]
            }
          ],
          "conversation_id": "conv_CtcSeOD1qXRec1WgfQSYW",
          "modalities": [
            "text",
            "audio"
          ],
          "voice": "cedar",
          "output_audio_format": "pcm16",
          "temperature": 0.8,
          "max_output_tokens": "inf",
          "usage": {
            "total_tokens": 605,
            "input_tokens": 416,
            "output_tokens": 189,
            "input_token_details": {
              "text_tokens": 398,
              "audio_tokens": 18,
              "image_tokens": 0,
              "cached_tokens": 0,
              "cached_tokens_details": {
                "text_tokens": 0,
                "audio_tokens": 0,
                "image_tokens": 0
              }
            },
            "output_token_details": {
              "text_tokens": 43,
              "audio_tokens": 146
            }
          },
          "metadata": null
        }
      }

      {
        "type": "rate_limits.updated",
        "event_id": "event_CtcSljGbEzqYmn5kiJSK2",
        "rate_limits": [
          {
            "name": "tokens",
            "limit": 40000,
            "remaining": 39353,
            "reset_seconds": 0.97
          }
        ]
      }

      {
        "type": "output_audio_buffer.stopped",
        "event_id": "event_bd3604dde48944ef",
        "response_id": "resp_CtcSie6XsD9cPaELIeCRx"
      }

      {
        "type": "response.text.delta",
        "event_id": "event_CtgWvHj1VIHwQ4gUoNqFc",
        "response_id": "resp_CtgWv7bnGjmWpjhG3NPBH",
        "item_id": "item_CtgWv3PHM27qdk7UgCeEZ",
        "output_index": 0,
        "content_index": 0,
        "delta": "{",
        "obfuscation": "Lrrym0eAH8eonP5"
      }

      {
        "type": "response.text.done",
        "event_id": "event_CtgWwzeaDp0xvZloe0XU7",
        "response_id": "resp_CtgWv7bnGjmWpjhG3NPBH",
        "item_id": "item_CtgWv3PHM27qdk7UgCeEZ",
        "output_index": 0,
        "content_index": 0,
        "text": "{  \n  \"score\": 0.92 \n}  \n"
      }

      {
        "type": "response.content_part.done",
        "event_id": "event_CtgWwexUsB0xcH8whmhna",
        "response_id": "resp_CtgWv7bnGjmWpjhG3NPBH",
        "item_id": "item_CtgWv3PHM27qdk7UgCeEZ",
        "output_index": 0,
        "content_index": 0,
        "part": {
          "type": "text",
          "text": "{  \n  \"score\": 0.92 \n}  \n"
        }
      }

{
        "type": "response.output_item.done",
        "event_id": "event_CtgWwze8eJicrL9cHoMz0",
        "response_id": "resp_CtgWv7bnGjmWpjhG3NPBH",
        "output_index": 0,
        "item": {
          "id": "item_CtgWv3PHM27qdk7UgCeEZ",
          "object": "realtime.item",
          "type": "message",
          "status": "completed",
          "role": "assistant",
          "content": [
            {
              "type": "text",
              "text": "{  \n  \"score\": 0.92 \n}  \n"
            }
          ]
        }
      }
 */
