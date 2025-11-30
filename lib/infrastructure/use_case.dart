import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/usecases/get_chats_use_case.dart';
import '../presentation/notifiers/chat_notifier.dart';
import 'repositories.dart';

final getChatsUseCaseProvider = Provider((ref) {
  return GetChatsUseCase(
    chatRepository: ref.watch(chatRepositoryProvider),
    chatNotifier: ref.watch(chatNotifierProvider),
  );
});
