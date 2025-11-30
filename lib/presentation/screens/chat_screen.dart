import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/chat.dart';
import '../../infrastructure/di.dart';
import '../handlers/chat_event_handler.dart';
import '../handlers/message_event_handler.dart';
import '../notifiers/message_notifier.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
    required this.chat,
  });
  final Chat chat;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Загружаем сообщения и отмечаем чат как прочитанный при открытии
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final messageEventHandler = ref.read<MessageEventHandler>(
        messageEventHandlerProvider(widget.chat.id),
      );
      messageEventHandler.onLoadMessagesPressed();
      final chatEventHandler = ref.read<ChatEventHandler>(
        chatEventHandlerProvider,
      );
      chatEventHandler.onMarkAsReadPressed(widget.chat.id);
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final messageText = _messageController.text.trim();
    _messageController.clear();

    // Добавляем сообщение через обработчик событий
    final messageEventHandler = ref.read<MessageEventHandler>(
      messageEventHandlerProvider(widget.chat.id),
    );
    messageEventHandler.onAddMessagePressed(messageText);

    // Обновляем последнее сообщение в списке чатов
    final now = DateTime.now();
    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final chatEventHandler = ref.read<ChatEventHandler>(
      chatEventHandlerProvider,
    );
    chatEventHandler.onUpdateChatLastMessagePressed(
      widget.chat.id,
      messageText,
      time,
    );
  }

  @override
  Widget build(BuildContext context) {
    final messageNotifier = ref.watch<MessageNotifier>(
      messageProvider(widget.chat.id),
    );

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.chat.name),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.phone),
          onPressed: () {
            // Действие для звонка
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: messageNotifier.isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : messageNotifier.error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.exclamationmark_triangle,
                            size: 48,
                            color: CupertinoColors.systemRed,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Ошибка загрузки сообщений',
                            style: CupertinoTheme.of(
                              context,
                            ).textTheme.navTitleTextStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            messageNotifier.error!,
                            style: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          CupertinoButton.filled(
                            onPressed: () {
                              final messageEventHandler = ref
                                  .read<MessageEventHandler>(
                                    messageEventHandlerProvider(widget.chat.id),
                                  );
                              messageEventHandler.onLoadMessagesPressed();
                            },
                            child: const Text('Повторить'),
                          ),
                        ],
                      ),
                    )
                  : messageNotifier.messages.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble,
                            size: 48,
                            color: CupertinoColors.systemGrey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Нет сообщений',
                            style: TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: messageNotifier.messages.length,
                      itemBuilder: (context, index) {
                        final message = messageNotifier.messages[index];
                        return MessageBubble(
                          message: message,
                          chatName: widget.chat.name,
                        );
                      },
                    ),
            ),
            MessageInput(
              controller: _messageController,
              onSendMessage: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
