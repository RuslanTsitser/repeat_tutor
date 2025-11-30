import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/usecases/get_chats_use_case.dart';
import 'repositories.dart';
import 'state_managers.dart';

final getChatsUseCaseProvider = Provider((ref) {
  return GetChatsUseCase(
    chatRepository: ref.watch(chatRepositoryProvider),
    chatNotifier: ref.watch(chatProvider),
  );
});
