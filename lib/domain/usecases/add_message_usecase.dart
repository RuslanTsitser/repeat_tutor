import '../models/message.dart';
import '../repositories/message_repository.dart';

/// Use Case для добавления сообщения
class AddMessageUseCase {
  const AddMessageUseCase({
    required this.repository,
  });

  final MessageRepository repository;

  Future<Message> execute({
    required String chatId,
    required String text,
  }) async {
    if (text.trim().isEmpty) {
      throw ArgumentError('Текст сообщения не может быть пустым');
    }

    final now = DateTime.now();
    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      isMe: true,
      time: time,
      chatId: chatId,
    );

    return await repository.addMessage(message);
  }
}

