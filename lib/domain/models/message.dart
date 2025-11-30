import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.text,
    required this.isMe,
    required this.chatId,
    this.audioPath,
    required this.createdAt,
  });

  final int id;
  final String text;
  final bool isMe;
  final int chatId;
  final String? audioPath;
  final DateTime createdAt;

  bool get hasAudio => audioPath != null && audioPath!.isNotEmpty;

  @override
  List<Object?> get props => [
    id,
    text,
    isMe,
    chatId,
    audioPath,
    createdAt,
  ];

  Message copyWith({
    int? id,
    String? text,
    bool? isMe,
    int? chatId,
    String? audioPath,
    DateTime? createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      isMe: isMe ?? this.isMe,
      chatId: chatId ?? this.chatId,
      audioPath: audioPath ?? this.audioPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
