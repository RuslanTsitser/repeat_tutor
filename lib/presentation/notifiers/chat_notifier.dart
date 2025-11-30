import 'package:flutter/foundation.dart';

import '../../domain/models/chat.dart';
import '../../domain/usecases/create_chat_usecase.dart';
import '../../domain/usecases/delete_chat_usecase.dart';
import '../../domain/usecases/get_chats_usecase.dart';
import '../../domain/usecases/mark_chat_as_read_usecase.dart';
import '../../domain/usecases/update_chat_last_message_usecase.dart';

class ChatNotifier extends ChangeNotifier {
  ChatNotifier({
    required this.getChatsUseCase,
    required this.updateChatLastMessageUseCase,
    required this.markChatAsReadUseCase,
    required this.createChatUseCase,
    required this.deleteChatUseCase,
  });

  final GetChatsUseCase getChatsUseCase;
  final UpdateChatLastMessageUseCase updateChatLastMessageUseCase;
  final MarkChatAsReadUseCase markChatAsReadUseCase;
  final CreateChatUseCase createChatUseCase;
  final DeleteChatUseCase deleteChatUseCase;
  List<Chat> _chats = [];
  bool _isLoading = false;
  String? _error;

  List<Chat> get chats => _chats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Загрузить список чатов
  Future<void> loadChats() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _chats = await getChatsUseCase.execute();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Обновить последнее сообщение в чате
  Future<void> updateChatLastMessage(
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
      await loadChats(); // Перезагружаем список чатов
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Отметить чат как прочитанный
  Future<void> markAsRead(String chatId) async {
    try {
      await markChatAsReadUseCase.execute(chatId);
      await loadChats(); // Перезагружаем список чатов
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Создать новый чат
  Future<void> createChat(Chat chat) async {
    try {
      await createChatUseCase.execute(chat);
      await loadChats(); // Перезагружаем список чатов
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Удалить чат
  Future<void> deleteChat(String chatId) async {
    try {
      await deleteChatUseCase.execute(chatId);
      await loadChats(); // Перезагружаем список чатов
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
