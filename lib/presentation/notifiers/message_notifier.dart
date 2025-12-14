import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/models/chat.dart';
import '../../domain/models/message.dart';
import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';

/// Нотатор для управления состоянием сообщений
/// Хранит только состояние UI, не содержит бизнес-логику
class MessageNotifier extends ChangeNotifier {
  MessageNotifier();

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
        language: SessionLanguage.english,
        level: SessionDifficultyLevel.beginner,
        teacherLanguage: SessionLanguage.english,
        topic: '',
      ),
      messages: [],
      isLoading: false,
      error: null,
      isAudioRecordingMode: false,
      isSpeechRecording: false,
    );
  }
  const MessagesState({
    required this.chat,
    required this.messages,
    required this.isLoading,
    required this.error,
    required this.isAudioRecordingMode,
    required this.isSpeechRecording,
  });
  final Chat chat;
  final List<Message> messages;
  final bool isLoading;
  final String? error;
  final bool isAudioRecordingMode;
  final bool isSpeechRecording;

  MessagesState copyWith({
    Chat? chat,
    List<Message>? messages,
    bool? isLoading,
    String? error,
    bool? isAudioRecordingMode,
    bool? isSpeechRecording,
  }) {
    return MessagesState(
      chat: chat ?? this.chat,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isAudioRecordingMode: isAudioRecordingMode ?? this.isAudioRecordingMode,
      isSpeechRecording: isSpeechRecording ?? this.isSpeechRecording,
    );
  }
}
