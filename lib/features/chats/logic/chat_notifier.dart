import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';
import '../../../core/domain/models/chat.dart';
import '../../../core/domain/models/message.dart';

/// Нотатор для управления состоянием сообщений
/// Хранит только состояние UI, не содержит бизнес-логику
class ChatNotifier extends ChangeNotifier {
  ChatNotifier();

  StreamSubscription<List<Message>>? _subscription;

  void subscribeToMessages(Stream<List<Message>> stream) {
    _subscription = stream.listen((messages) {
      setState(state.copyWith(messages: messages));
    });
  }

  void unsubscribeFromMessages() {
    _subscription?.cancel();
    _subscription = null;
  }

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
    return MessagesState(
      chat: Chat(
        chatId: 0,
        createdAt: DateTime.now(),
        chatLanguage: Language.english,
        level: DifficultyLevel.beginner,
        teacherLanguage: Language.english,
        topic: '',
      ),
      messages: [],
      isLoading: false,
      error: null,
      isAudioRecordingMode: false,
      isSpeechRecording: false,
      isMessageSending: false,
    );
  }
  const MessagesState({
    required this.chat,
    required this.messages,
    required this.isLoading,
    required this.error,
    required this.isAudioRecordingMode,
    required this.isSpeechRecording,
    required this.isMessageSending,
  });
  final Chat chat;
  final List<Message> messages;
  final bool isLoading;
  final String? error;
  final bool isAudioRecordingMode;
  final bool isSpeechRecording;
  final bool isMessageSending;

  MessagesState copyWith({
    Chat? chat,
    List<Message>? messages,
    bool? isLoading,
    String? error,
    bool? isAudioRecordingMode,
    bool? isSpeechRecording,
    bool? isMessageSending,
  }) {
    return MessagesState(
      chat: chat ?? this.chat,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isAudioRecordingMode: isAudioRecordingMode ?? this.isAudioRecordingMode,
      isSpeechRecording: isSpeechRecording ?? this.isSpeechRecording,
      isMessageSending: isMessageSending ?? this.isMessageSending,
    );
  }
}
