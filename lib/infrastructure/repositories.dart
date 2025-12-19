// Repository providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/data/repositories/chat_repository_impl.dart';
import '../core/domain/repositories/chat_repository.dart';
import 'core.dart';

/// Провайдер для ChatRepository
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final database = ref.watch(databaseProvider);
  final gptService = ref.watch(gptServiceProvider);
  return ChatRepositoryImpl(database, gptService);
});
