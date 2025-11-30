import '../../core/audio/chat_audio_cache_service.dart';
import '../models/chat_configuration.dart';
import '../models/message.dart';
import '../models/message_content_type.dart';
import '../repositories/chat_ai_repository.dart';
import '../repositories/message_repository.dart';

class GenerateWelcomeMessageUseCase {
  const GenerateWelcomeMessageUseCase({
    required this.chatAiRepository,
    required this.messageRepository,
    required this.audioCacheService,
  });

  final ChatAiRepository chatAiRepository;
  final MessageRepository messageRepository;
  final ChatAudioCacheService audioCacheService;

  Future<Message> execute(ChatConfiguration configuration) async {
    final response =
        await chatAiRepository.generateWelcomeMessage(configuration);
    final now = DateTime.now();
    final messageId = now.microsecondsSinceEpoch.toString();

    String? audioPath;
    if (response.audioBase64 != null && response.audioBase64!.isNotEmpty) {
      audioPath = await audioCacheService.saveBase64Audio(
        chatId: configuration.chatId,
        messageId: messageId,
        base64Data: response.audioBase64!,
      );
    }

    final message = Message(
      id: messageId,
      text: response.text,
      isMe: false,
      time: _formatTime(now),
      chatId: configuration.chatId,
      contentType:
          audioPath != null ? MessageContentType.voice : MessageContentType.text,
      audioPath: audioPath,
      transcription: response.text,
      corrections: response.corrections,
      language: configuration.language,
      createdAt: now,
    );

    await messageRepository.addMessage(message);
    return message;
  }

  String _formatTime(DateTime value) {
    final hours = value.hour.toString().padLeft(2, '0');
    final minutes = value.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}

