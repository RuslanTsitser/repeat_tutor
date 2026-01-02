import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/domain/models/chat.dart';
import '../../../core/domain/models/message.dart';
import '../../../core/domain/repositories/chat_repository.dart';

/// Нотатор для управления состоянием чатов
/// Хранит только состояние UI, не содержит бизнес-логику
class ChatListNotifier extends ChangeNotifier {
  ChatListNotifier({
    required this.chatRepository,
  }) {
    _subscribeToChats();
    _subscribeToMessages();
    getChats();
  }
  final ChatRepository chatRepository;

  StreamSubscription<List<Chat>>? _subscription;
  StreamSubscription<Message?>? _lastMessageSubscription;

  void _subscribeToChats() {
    _subscription = chatRepository.getChatsStream().listen((chats) {
      setState(state.copyWith(chats: chats));
    });
  }

  void _subscribeToMessages() {
    _lastMessageSubscription = chatRepository.getLastMessageStream().listen((
      message,
    ) {
      if (message != null) {
        final lastMessage = LastMessage(
          text: message.isMe
              ? message.text
              : message.tutorAnswer?.assistantMessage ?? message.text,
          id: message.id.toString(),
        );
        setState(
          state.copyWith(
            chats: state.chats
                .map(
                  (chat) => chat.chatId == message.chatId
                      ? chat.copyWithLastMessage(lastMessage: lastMessage)
                      : chat,
                )
                .toList(),
          ),
        );
      }
    });
  }

  Future<void> getChats() async {
    final chats = await chatRepository.getChats();
    setState(state.copyWith(chats: chats, isLoading: false));
  }

  ChatsState _state = ChatsState.initial();
  ChatsState get state => _state;

  void setState(ChatsState value) {
    _state = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _lastMessageSubscription?.cancel();
    _lastMessageSubscription = null;
    super.dispose();
  }
}

class ChatsState {
  factory ChatsState.initial() {
    return const ChatsState(chats: [], isLoading: true, error: null);
  }
  const ChatsState({
    required this.chats,
    required this.isLoading,
    required this.error,
  });
  final List<Chat> chats;
  final bool isLoading;
  final String? error;

  ChatsState copyWith({
    List<Chat>? chats,
    bool? isLoading,
    String? error,
  }) {
    return ChatsState(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
