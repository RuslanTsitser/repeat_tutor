// Repository providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/chat_repository_impl.dart';
import '../data/repositories/realtime_session_repository_impl.dart';
import '../domain/repositories/chat_repository.dart';
import '../domain/repositories/realtime_session_repository.dart';
import 'core.dart';

/// Провайдер для ChatRepository
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ChatRepositoryImpl(database);
});

/// Провайдер для RealtimeSessionRepository
final realtimeSessionRepositoryProvider = Provider<RealtimeSessionRepository>((
  ref,
) {
  final database = ref.watch(databaseProvider);
  final gptService = ref.watch(gptServiceProvider);
  return RealtimeSessionRepositoryImpl(
    database: database,
    gptService: gptService,
  );
});
