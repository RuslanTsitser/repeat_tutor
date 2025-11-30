import '../../domain/models/message.dart';
import '../../domain/usecases/add_message_usecase.dart';
import '../../domain/usecases/clear_messages_usecase.dart';
import '../../domain/usecases/delete_message_usecase.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/update_message_usecase.dart';
import '../notifiers/message_notifier.dart';

/// Обработчик событий для MessageNotifier
class MessageEventHandler {
  MessageEventHandler({
    required this.notifier,
    required this.getMessagesUseCase,
    required this.addMessageUseCase,
    required this.deleteMessageUseCase,
    required this.updateMessageUseCase,
    required this.clearMessagesUseCase,
  });

  final MessageNotifier notifier;
  final GetMessagesUseCase getMessagesUseCase;
  final AddMessageUseCase addMessageUseCase;
  final DeleteMessageUseCase deleteMessageUseCase;
  final UpdateMessageUseCase updateMessageUseCase;
  final ClearMessagesUseCase clearMessagesUseCase;

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

  /// Обработка события добавления сообщения
  Future<void> onAddMessagePressed(String text) async {
    try {
      await addMessageUseCase.execute(chatId: notifier.chatId, text: text);
      // Перезагружаем сообщения после добавления
      await onLoadMessagesPressed();
    } catch (e) {
      notifier.setError(e.toString());
    }
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
}

