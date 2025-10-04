import 'package:equatable/equatable.dart';

class Message extends Equatable {

  const Message({
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
    required this.chatId,
  });
  final String id;
  final String text;
  final bool isMe;
  final String time;
  final String chatId;

  @override
  List<Object?> get props => [id, text, isMe, time, chatId];

  Message copyWith({
    String? id,
    String? text,
    bool? isMe,
    String? time,
    String? chatId,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      isMe: isMe ?? this.isMe,
      time: time ?? this.time,
      chatId: chatId ?? this.chatId,
    );
  }
}
