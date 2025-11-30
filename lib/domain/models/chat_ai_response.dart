import 'package:equatable/equatable.dart';

/// Ответ ассистента (текст + аудио + правки)
class ChatAiResponse extends Equatable {
  const ChatAiResponse({
    required this.text,
    required this.audioBase64,
    this.corrections,
  });

  final String text;
  final String? audioBase64;
  final String? corrections;

  @override
  List<Object?> get props => [text, audioBase64, corrections];
}
