import '../../core/audio/chat_audio_cache_service.dart';
import '../models/chat_configuration.dart';
import '../models/message.dart';
import '../models/message_content_type.dart';
import '../repositories/chat_ai_repository.dart';
import '../repositories/message_repository.dart';
import 'update_chat_last_message_usecase.dart';

class SendChatTurnUseCase {
  const SendChatTurnUseCase({
    required this.chatAiRepository,
    required this.messageRepository,
    required this.audioCacheService,
    required this.updateChatLastMessageUseCase,
  });

  final ChatAiRepository chatAiRepository;
  final MessageRepository messageRepository;
  final ChatAudioCacheService audioCacheService;
  final UpdateChatLastMessageUseCase updateChatLastMessageUseCase;

  Future<void> execute({
    required ChatConfiguration configuration,
    String? text,
    String? voiceFilePath,
  }) async {
    if ((text == null || text.trim().isEmpty) && voiceFilePath == null) {
      throw ArgumentError('Сообщение пустое');
    }

    var preparedText = text?.trim() ?? '';

    if (voiceFilePath != null) {
      preparedText = await chatAiRepository.transcribeAudio(
        filePath: voiceFilePath,
        language: configuration.language,
      );

      if (preparedText.isEmpty) {
        throw StateError('Не удалось распознать голосовое сообщение');
      }
    }

    final now = DateTime.now();
    final userMessageId = now.microsecondsSinceEpoch.toString();

    String? storedVoicePath;
    if (voiceFilePath != null) {
      storedVoicePath = await audioCacheService.copyLocalFile(
        chatId: configuration.chatId,
        messageId: userMessageId,
        sourcePath: voiceFilePath,
      );
    }

    final userMessage = Message(
      id: userMessageId,
      text: preparedText,
      isMe: true,
      time: _formatTime(now),
      chatId: configuration.chatId,
      contentType:
          voiceFilePath != null ? MessageContentType.voice : MessageContentType.text,
      audioPath: storedVoicePath,
      transcription: voiceFilePath != null ? preparedText : null,
      language: configuration.language,
      createdAt: now,
    );
    await messageRepository.addMessage(userMessage);

    final aiResponse = await chatAiRepository.sendUserMessage(
      configuration: configuration,
      userMessage: preparedText,
    );

    final aiTimestamp = DateTime.now();
    final aiMessageId = aiTimestamp.microsecondsSinceEpoch.toString();

    String? audioPath;
    if (aiResponse.audioBase64 != null && aiResponse.audioBase64!.isNotEmpty) {
      audioPath = await audioCacheService.saveBase64Audio(
        chatId: configuration.chatId,
        messageId: aiMessageId,
        base64Data: aiResponse.audioBase64!,
      );
    }

    final aiMessage = Message(
      id: aiMessageId,
      text: aiResponse.text,
      isMe: false,
      time: _formatTime(aiTimestamp),
      chatId: configuration.chatId,
      contentType:
          audioPath != null ? MessageContentType.voice : MessageContentType.text,
      audioPath: audioPath,
      transcription: aiResponse.text,
      corrections: aiResponse.corrections,
      language: configuration.language,
      createdAt: aiTimestamp,
    );

    await messageRepository.addMessage(aiMessage);
    await updateChatLastMessageUseCase.execute(
      chatId: configuration.chatId,
      message: aiResponse.text,
      time: aiMessage.time,
    );
  }

  String _formatTime(DateTime value) {
    final hours = value.hour.toString().padLeft(2, '0');
    final minutes = value.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}

