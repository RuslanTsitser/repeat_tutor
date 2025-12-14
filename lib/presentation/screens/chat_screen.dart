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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
          middle: Text('Чат'),
        ),
        child: _Body(),
      ),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body();

  @override
  ConsumerState<_Body> createState() => __BodyState();
}

class __BodyState extends ConsumerState<_Body> {
  final ScrollController _scrollController = ScrollController();
  int _previousMessageCount = 0;
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    // Скролл до конца после первой загрузки сообщений
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messageNotifier = ref.watch(messageProvider);
    final MessagesState state = messageNotifier.state;
    final List<Message> messages = state.messages;
    final bool isLoading = state.isLoading;
    final String? error = state.error;

    // Скролл до конца при первой загрузке сообщений
    if (!isLoading && _isInitialLoad && messages.isNotEmpty) {
      _isInitialLoad = false;
      _previousMessageCount = messages.length;
      _scrollToBottom();
    }

    // Автоматическая прокрутка при появлении новых сообщений
    if (messages.length != _previousMessageCount) {
      _previousMessageCount = messages.length;
      if (messages.isNotEmpty) {
        _scrollToBottom();
      }
    }

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
              : SafeArea(
                  top: true,
                  bottom: false,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) =>
                        _MessageBubble(message: messages[index]),
                  ),
                ),
        ),
        _MessageInput(scrollController: _scrollController),
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
  const _MessageInput({required this.scrollController});

  final ScrollController scrollController;

  @override
  ConsumerState<_MessageInput> createState() => __MessageInputState();
}

class __MessageInputState extends ConsumerState<_MessageInput> {
  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  double _previousKeyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    // Скролл до конца при фокусе на текстовое поле (с задержкой для появления клавиатуры)
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _scrollToBottom();
        });
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollController.hasClients) {
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      ref.read(addMessageUseCaseProvider).execute(text);
      messageController.clear();
      // Клавиатура не скрывается при отправке сообщения
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    // Скролл при изменении высоты клавиатуры
    if (bottomPadding != _previousKeyboardHeight && bottomPadding > 0) {
      _previousKeyboardHeight = bottomPadding;
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    } else if (bottomPadding == 0) {
      _previousKeyboardHeight = 0;
    }

    return Container(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: 8 + bottomPadding,
      ),
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
                textCapitalization: TextCapitalization.sentences,
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
            if (ref.watch(messageProvider).state.isAudioRecordingMode)
              CupertinoButton(
                onLongPress: ref.read(toggleAudioModeUseCaseProvider).execute,
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (ref.watch(messageProvider).state.isSpeechRecording) {
                    ref
                        .read(toggleAudioModeUseCaseProvider)
                        .stopAudioRecording();
                  } else {
                    ref
                        .read(toggleAudioModeUseCaseProvider)
                        .startAudioRecording();
                  }
                },
                minimumSize: const Size(0, 0),
                child: (ref.watch(messageProvider).state.isSpeechRecording)
                    ? Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: CupertinoColors.systemRed,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.stop,
                          color: CupertinoColors.white,
                          size: 18,
                        ),
                      )
                    : Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: CupertinoColors.systemBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.mic,
                          color: CupertinoColors.white,
                          size: 18,
                        ),
                      ),
              )
            else
              CupertinoButton(
                onLongPress: ref.read(toggleAudioModeUseCaseProvider).execute,
                padding: EdgeInsets.zero,
                onPressed: _sendMessage,
                minimumSize: const Size(0, 0),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
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
