import 'package:flutter/material.dart';

import '../../domain/models/message.dart';

/// Нотатор для управления состоянием сообщений
/// Хранит только состояние UI, не содержит бизнес-логику
class MessageNotifier extends ChangeNotifier {
  MessageNotifier();

  MessagesState _state = MessagesState.initial();
  MessagesState get state => _state;

  void setState(MessagesState value) {
    _state = value;
    notifyListeners();
  }

  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}

class MessagesState {
  factory MessagesState.initial() {
    return const MessagesState(
      chatId: 0,
      messages: [],
      isLoading: false,
      error: null,
    );
  }
  const MessagesState({
    required this.chatId,
    required this.messages,
    required this.isLoading,
    required this.error,
  });
  final int chatId;
  final List<Message> messages;
  final bool isLoading;
  final String? error;

  MessagesState copyWith({
    int? chatId,
    List<Message>? messages,
    bool? isLoading,
    String? error,
  }) {
    return MessagesState(
      chatId: chatId ?? this.chatId,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
