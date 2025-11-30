import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/chat.dart';
import '../../domain/models/message.dart';
import '../../infrastructure/core.dart';
import '../../infrastructure/handlers.dart';
import '../../infrastructure/state_managers.dart';
import '../notifiers/message_notifier.dart';

@RoutePage()
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
      final messageEventHandler = ref.read(
        messageEventHandlerProvider(widget.chat.id),
      );
      messageEventHandler.onLoadMessagesPressed();
      final chatEventHandler = ref.read(chatEventHandlerProvider);
      chatEventHandler.onMarkAsReadPressed(widget.chat.id);
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final messageText = _messageController.text.trim();
    _messageController.clear();

    // Добавляем сообщение через обработчик событий
    final messageEventHandler = ref.read(
      messageEventHandlerProvider(widget.chat.id),
    );
    messageEventHandler.onAddMessagePressed(messageText);

    // Обновляем последнее сообщение в списке чатов
    final now = DateTime.now();
    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final chatEventHandler = ref.read(chatEventHandlerProvider);
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
          onPressed: () => ref.read(routerProvider).pop(),
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
                              final messageEventHandler = ref.read(
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
                        return _MessageBubble(
                          message: message,
                          chatName: widget.chat.name,
                        );
                      },
                    ),
            ),
            _MessageInput(
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

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.chatName,
  });
  final Message message;
  final String chatName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: CupertinoColors.systemGrey4,
              child: Text(
                chatName[0].toUpperCase(),
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: message.isMe
                    ? CupertinoColors.systemBlue
                    : CupertinoColors.systemGrey5,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isMe
                          ? CupertinoColors.white
                          : CupertinoColors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.time,
                    style: TextStyle(
                      color: message.isMe
                          ? CupertinoColors.white.withValues(alpha: 0.7)
                          : CupertinoColors.systemGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isMe) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 16,
              backgroundColor: CupertinoColors.systemBlue,
              child: Icon(
                CupertinoIcons.person_fill,
                color: CupertinoColors.white,
                size: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({
    required this.onSendMessage,
    required this.controller,
  });
  final VoidCallback onSendMessage;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: CupertinoColors.systemGrey6,
        border: Border(
          top: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: 'Сообщение',
              decoration: const BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              onSubmitted: (_) => onSendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          CupertinoButton(
            padding: const EdgeInsets.all(8),
            onPressed: onSendMessage,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: CupertinoColors.systemBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.paperplane_fill,
                color: CupertinoColors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
