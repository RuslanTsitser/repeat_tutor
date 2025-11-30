/// Тип контента сообщения
enum MessageContentType {
  text('text'),
  voice('voice');

  const MessageContentType(this.value);
  final String value;

  static MessageContentType fromValue(String value) {
    return MessageContentType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => MessageContentType.text,
    );
  }
}

