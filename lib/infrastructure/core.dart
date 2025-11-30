import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/ab_test/ab_test_prod.dart';
import '../core/audio/chat_audio_cache_service.dart';
import '../core/database/app_database.dart';
import '../core/logging/app_logger.dart';
import '../core/realtime/realtime_audio_manager.dart';
import '../core/realtime/realtime_webrtc_manager.dart';
import '../core/router/router.dart';

final routerProvider = ChangeNotifierProvider<AppRouter>((ref) {
  return AppRouter();
});

// Database provider
/// Провайдер для базы данных
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// Провайдер для Dio
final dioProvider = Provider<Dio>((ref) {
  return Dio()
    ..interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: false,
        logPrint: logInfo,
      ),
    );
});

/// API ключ OpenAI (должен быть установлен через переменные окружения)
final openAIApiKeyProvider = Provider<String>((ref) {
  const apiKey = String.fromEnvironment('OPENAI_API_KEY', defaultValue: '');
  if (apiKey.isEmpty) {
    throw StateError(
      'OPENAI_API_KEY не установлен. Установите переменную окружения OPENAI_API_KEY.',
    );
  }
  return apiKey;
});

/// Провайдер для RealtimeWebRTCConnection
final realtimeWebRTCConnectionProvider = Provider<RealtimeWebRTCConnection>((
  ref,
) {
  return RealtimeWebRTCManagerImpl();
});

/// Провайдер для RealtimeAudioManager
final realtimeAudioManagerProvider = Provider<RealtimeAudioManager>((
  ref,
) {
  return RealtimeAudioManagerImpl();
});

final chatAudioCacheServiceProvider = Provider<ChatAudioCacheService>((ref) {
  return ChatAudioCacheService();
});

final abTestServiceProvider = Provider<AbTestService>((ref) {
  const appKey = String.fromEnvironment('APPHUD_APP_KEY', defaultValue: '');
  if (appKey.isEmpty) {
    throw StateError(
      'APPHUD_APP_KEY не установлен. Установите переменную окружения APPHUD_APP_KEY.',
    );
  }
  return AbTestService(appKey);
});

final initializeServiceProvider = FutureProvider<void>((ref) async {
  final abTestService = ref.watch(abTestServiceProvider);
  await abTestService.init();
});
