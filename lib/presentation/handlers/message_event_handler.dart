import '../../domain/models/message.dart';
import '../../domain/usecases/clear_messages_usecase.dart';
import '../../domain/usecases/delete_message_usecase.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/get_chat_configuration_usecase.dart';
import '../../domain/usecases/send_chat_turn_usecase.dart';
import '../../domain/usecases/update_message_usecase.dart';
import '../notifiers/message_notifier.dart';

/// Обработчик событий для MessageNotifier
class MessageEventHandler {
  MessageEventHandler({
    required this.notifier,
    required this.getMessagesUseCase,
    required this.deleteMessageUseCase,
    required this.updateMessageUseCase,
    required this.clearMessagesUseCase,
    required this.getChatConfigurationUseCase,
    required this.sendChatTurnUseCase,
  });

  final MessageNotifier notifier;
  final GetMessagesUseCase getMessagesUseCase;
  final DeleteMessageUseCase deleteMessageUseCase;
  final UpdateMessageUseCase updateMessageUseCase;
  final ClearMessagesUseCase clearMessagesUseCase;
  final GetChatConfigurationUseCase getChatConfigurationUseCase;
  final SendChatTurnUseCase sendChatTurnUseCase;

  /// Обработка события загрузки сообщений
  Future<void> onLoadMessagesPressed() async {
    notifier.setLoading(true);
    notifier.setError(null);

    try {
      final messages = await getMessagesUseCase.execute(notifier.chatId);
      notifier.setMessages(messages);
    } catch (e) {
      notifier.setError(e.toString());
    } finally {
      notifier.setLoading(false);
    }
  }

  /// Обработка события отправки текстового сообщения
  Future<void> onAddMessagePressed(String text) async {
    await _sendTurn(text: text);
  }

  /// Обработка события отправки голосового сообщения
  Future<void> onAddVoiceMessagePressed(String filePath) async {
    await _sendTurn(voiceFilePath: filePath);
  }

  /// Обработка события очистки сообщений
  Future<void> onClearMessagesPressed() async {
    try {
      await clearMessagesUseCase.execute(notifier.chatId);
      // Перезагружаем сообщения после очистки
      await onLoadMessagesPressed();
    } catch (e) {
      notifier.setError(e.toString());
    }
  }

  /// Обработка события удаления сообщения
  Future<void> onDeleteMessagePressed(String messageId) async {
    try {
      await deleteMessageUseCase.execute(messageId);
      // Перезагружаем сообщения после удаления
      await onLoadMessagesPressed();
    } catch (e) {
      notifier.setError(e.toString());
    }
  }

  /// Обработка события обновления сообщения
  Future<void> onUpdateMessagePressed(Message message) async {
    try {
      await updateMessageUseCase.execute(message);
      // Перезагружаем сообщения после обновления
      await onLoadMessagesPressed();
    } catch (e) {
      notifier.setError(e.toString());
    }
  }

  Future<void> _sendTurn({
    String? text,
    String? voiceFilePath,
  }) async {
    try {
      final configuration =
          await getChatConfigurationUseCase.execute(notifier.chatId);
      if (configuration == null) {
        throw StateError('Настройки чата не найдены');
      }

      await sendChatTurnUseCase.execute(
        configuration: configuration,
        text: text,
        voiceFilePath: voiceFilePath,
      );

      final messages = await getMessagesUseCase.execute(notifier.chatId);
      notifier.setMessages(messages);
    } catch (e) {
      notifier.setError(e.toString());
    }
  }
}

