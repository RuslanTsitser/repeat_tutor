import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/message.dart';
import '../../infrastructure/state_managers.dart';
import '../../infrastructure/use_case.dart';
import '../notifiers/message_notifier.dart';

@RoutePage()
class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Чат'),
      ),
      child: _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageNotifier = ref.watch(messageProvider);
    final MessagesState state = messageNotifier.state;
    final List<Message> messages = state.messages;
    final bool isLoading = state.isLoading;
    final String? error = state.error;

    if (isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (error != null) {
      return Center(
        child: Text(error),
      );
    }

    return Column(
      children: [
        Expanded(
          child: messages.isEmpty
              ? const Center(child: Text('Нет сообщений'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) =>
                      _MessageBubble(message: messages[index]),
                ),
        ),
        const _MessageInput(),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
  });
  final Message message;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = message.isMe
        ? CupertinoColors.systemBlue
        : CupertinoColors.systemGrey5;
    final textColor = message.isMe
        ? CupertinoColors.white
        : CupertinoColors.black;

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
                message.text[0].toUpperCase(),
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
                color: bubbleColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.text.isNotEmpty)
                    Text(
                      message.text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      DateFormat('HH:mm').format(message.createdAt),
                      style: TextStyle(
                        color: message.isMe
                            ? CupertinoColors.white.withValues(alpha: 0.7)
                            : CupertinoColors.systemGrey,
                        fontSize: 12,
                      ),
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

class _MessageInput extends ConsumerStatefulWidget {
  const _MessageInput();

  @override
  ConsumerState<_MessageInput> createState() => __MessageInputState();
}

class __MessageInputState extends ConsumerState<_MessageInput> {
  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    messageController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      ref.read(addMessageUseCaseProvider).execute(text);
      messageController.clear();
      focusNode.unfocus();
    }
  }

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
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CupertinoTextField(
                controller: messageController,
                focusNode: focusNode,
                placeholder: 'Сообщение',
                minLines: 1,
                maxLines: 5,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: CupertinoColors.systemGrey4,
                    width: 1,
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 8),
            CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              onPressed: _sendMessage,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.arrow_up,
                  color: CupertinoColors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
