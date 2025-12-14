import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/models/chat.dart';

/// Нотатор для управления состоянием чатов
/// Хранит только состояние UI, не содержит бизнес-логику
class ChatNotifier extends ChangeNotifier {
  ChatNotifier();

  StreamSubscription<List<Chat>>? _subscription;

  void subscribeToChats(Stream<List<Chat>> stream) {
    _subscription = stream.listen((chats) {
      setState(state.copyWith(chats: chats));
    });
  }

  void unsubscribeFromChats() {
    _subscription?.cancel();
    _subscription = null;
  }

  ChatsState _state = ChatsState.initial();
  ChatsState get state => _state;

  void setState(ChatsState value) {
    _state = value;
    notifyListeners();
  }
}

class ChatsState {
  factory ChatsState.initial() {
    return const ChatsState(chats: [], isLoading: false, error: null);
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
