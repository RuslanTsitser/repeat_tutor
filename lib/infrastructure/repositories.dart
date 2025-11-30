// Repository providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/chat_ai_repository_impl.dart';
import '../data/repositories/chat_repository_impl.dart';
import '../data/repositories/message_repository_impl.dart';
import '../data/repositories/realtime_session_repository_impl.dart';
import '../domain/repositories/chat_ai_repository.dart';
import '../domain/repositories/chat_repository.dart';
import '../domain/repositories/message_repository.dart';
import '../domain/repositories/realtime_session_repository.dart';
import 'core.dart';

/// Провайдер для ChatRepository
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ChatRepositoryImpl(database);
});

/// Провайдер для MessageRepository
final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return MessageRepositoryImpl(database);
});

/// Провайдер для ChatAiRepository
final chatAiRepositoryProvider = Provider<ChatAiRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final apiKey = ref.watch(openAIApiKeyProvider);
  return ChatAiRepositoryImpl(dio: dio, apiKey: apiKey);
});

/// Провайдер для RealtimeSessionRepository
final realtimeSessionRepositoryProvider = Provider<RealtimeSessionRepository>((
  ref,
) {
  final database = ref.watch(databaseProvider);
  final dio = ref.watch(dioProvider);
  final apiKey = ref.watch(openAIApiKeyProvider);
  return RealtimeSessionRepositoryImpl(
    database: database,
    dio: dio,
    apiKey: apiKey,
  );
});
