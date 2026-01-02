import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/repositories.dart';

class DeleteChatUseCase {
  const DeleteChatUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<void> execute(int chatId) async {
    final chatRepository = ref.read(chatRepositoryProvider);
    await chatRepository.deleteChat(chatId);
  }

  Future<void> deleteMessage(int messageId) async {
    final chatRepository = ref.read(chatRepositoryProvider);
    await chatRepository.deleteMessage(messageId);
  }
}
