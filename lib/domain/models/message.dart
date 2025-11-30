import 'package:equatable/equatable.dart';

import 'message_content_type.dart';
import 'session_language.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
    required this.chatId,
    required this.contentType,
    this.audioPath,
    this.transcription,
    this.corrections,
    this.language,
    required this.createdAt,
  });

  final String id;
  final String text;
  final bool isMe;
  final String time;
  final String chatId;
  final MessageContentType contentType;
  final String? audioPath;
  final String? transcription;
  final String? corrections;
  final SessionLanguage? language;
  final DateTime createdAt;

  bool get hasAudio => audioPath != null && audioPath!.isNotEmpty;
  bool get hasCorrections =>
      corrections != null && corrections!.trim().isNotEmpty;

  @override
  List<Object?> get props => [
    id,
    text,
    isMe,
    time,
    chatId,
    contentType,
    audioPath,
    transcription,
    corrections,
    language,
    createdAt,
  ];

  Message copyWith({
    String? id,
    String? text,
    bool? isMe,
    String? time,
    String? chatId,
    MessageContentType? contentType,
    String? audioPath,
    String? transcription,
    String? corrections,
    SessionLanguage? language,
    DateTime? createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      isMe: isMe ?? this.isMe,
      time: time ?? this.time,
      chatId: chatId ?? this.chatId,
      contentType: contentType ?? this.contentType,
      audioPath: audioPath ?? this.audioPath,
      transcription: transcription ?? this.transcription,
      corrections: corrections ?? this.corrections,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
