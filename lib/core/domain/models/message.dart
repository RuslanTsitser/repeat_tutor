class Message {
  const Message({
    required this.id,
    required this.gptResponseId,
    required this.text,
    required this.chatId,
    required this.createdAt,
  });

  final int id;
  final String? gptResponseId;
  final String text;
  final int chatId;
  final DateTime createdAt;

  bool get isMe => gptResponseId == null;
}
