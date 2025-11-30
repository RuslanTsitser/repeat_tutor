import 'package:uuid/uuid.dart';

import '../../domain/models/chat.dart';
import '../../domain/models/chat_configuration.dart';
import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';
import '../../domain/usecases/create_chat_usecase.dart';
import '../../domain/usecases/delete_chat_usecase.dart';
import '../../domain/usecases/get_chats_usecase.dart';
import '../../domain/usecases/mark_chat_as_read_usecase.dart';
import '../../domain/usecases/update_chat_last_message_usecase.dart';
import '../../domain/usecases/upsert_chat_configuration_usecase.dart';
import '../../domain/usecases/generate_welcome_message_usecase.dart';
import '../notifiers/chat_notifier.dart';

/// Обработчик событий для ChatNotifier
class ChatEventHandler {
  ChatEventHandler({
    required this.notifier,
    required this.getChatsUseCase,
    required this.updateChatLastMessageUseCase,
    required this.markChatAsReadUseCase,
    required this.createChatUseCase,
    required this.deleteChatUseCase,
    required this.upsertChatConfigurationUseCase,
    required this.generateWelcomeMessageUseCase,
  });

  final ChatNotifier notifier;
  final GetChatsUseCase getChatsUseCase;
  final UpdateChatLastMessageUseCase updateChatLastMessageUseCase;
  final MarkChatAsReadUseCase markChatAsReadUseCase;
  final CreateChatUseCase createChatUseCase;
  final DeleteChatUseCase deleteChatUseCase;
  final UpsertChatConfigurationUseCase upsertChatConfigurationUseCase;
  final GenerateWelcomeMessageUseCase generateWelcomeMessageUseCase;

  /// Обработка события загрузки чатов
  Future<void> onLoadChatsPressed() async {
    notifier.setLoading(true);
    notifier.setError(null);

    try {
      final chats = await getChatsUseCase.execute();
      notifier.setChats(chats);
    } catch (e) {
      notifier.setError(e.toString());
    } finally {
      notifier.setLoading(false);
    }
  }

  /// Обработка события обновления последнего сообщения в чате
  Future<void> onUpdateChatLastMessagePressed(
    String chatId,
    String message,
    String time,
  ) async {
    try {
      await updateChatLastMessageUseCase.execute(
        chatId: chatId,
        message: message,
        time: time,
      );
      // Перезагружаем список чатов после обновления
      await onLoadChatsPressed();
    } catch (e) {
      notifier.setError(e.toString());
    }
  }

  /// Обработка события отметки чата как прочитанного
  Future<void> onMarkAsReadPressed(String chatId) async {
    try {
      await markChatAsReadUseCase.execute(chatId);
      // Перезагружаем список чатов после отметки
      await onLoadChatsPressed();
    } catch (e) {
      notifier.setError(e.toString());
    }
  }

  /// Обработка события создания чата
  Future<void> onCreateChatPressed({
    required String name,
    required SessionLanguage language,
    required SessionDifficultyLevel difficulty,
    required String topic,
  }) async {
    try {
      final chatId = const Uuid().v4();
      final now = DateTime.now();

      final chat = Chat(
        id: chatId,
        name: name,
        lastMessage: 'Чат создан',
        time: now.toIso8601String(),
        unreadCount: 0,
        avatarUrl: '',
      );
      await createChatUseCase.execute(chat);

      final configuration = ChatConfiguration(
        chatId: chatId,
        language: language,
        difficulty: difficulty,
        topic: topic,
        createdAt: now,
        updatedAt: now,
      );

      await upsertChatConfigurationUseCase.execute(configuration);

      final welcomeMessage =
          await generateWelcomeMessageUseCase.execute(configuration);

      await updateChatLastMessageUseCase.execute(
        chatId: chatId,
        message: welcomeMessage.text,
        time: welcomeMessage.time,
      );

      // Перезагружаем список чатов после создания
      await onLoadChatsPressed();
    } catch (e) {
      notifier.setError(e.toString());
    }
  }

  /// Обработка события удаления чата
  Future<void> onDeleteChatPressed(String chatId) async {
    try {
      await deleteChatUseCase.execute(chatId);
      // Перезагружаем список чатов после удаления
      await onLoadChatsPressed();
    } catch (e) {
      notifier.setError(e.toString());
    }
  }
}
