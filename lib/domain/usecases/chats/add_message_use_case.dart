import 'package:collection/collection.dart';

import '../../../presentation/notifiers/message_notifier.dart';
import '../../repositories/chat_repository.dart';

class AddMessageUseCase {
  const AddMessageUseCase({
    required this.chatRepository,
    required this.messageNotifier,
  });
  final ChatRepository chatRepository;
  final MessageNotifier messageNotifier;

  Future<void> execute(String message) async {
    final lastGptResponseId = messageNotifier.state.messages
        .lastWhereOrNull((message) => !message.isMe)
        ?.gptResponseId;
    await chatRepository.addMessage(
      message: message,
      gptResponseId: lastGptResponseId,
      chat: messageNotifier.state.chat,
      audioPath: null,
    );
  }
}
