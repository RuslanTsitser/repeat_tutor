class Message {
  const Message({
    required this.id,
    required this.gptResponseId,
    required this.text,
    required this.chatId,
    this.audioPath,
    required this.createdAt,
  });

  final int id;
  final String? gptResponseId;
  final String text;
  final int chatId;
  final String? audioPath;
  final DateTime createdAt;

  bool get isMe => gptResponseId == null;
}
