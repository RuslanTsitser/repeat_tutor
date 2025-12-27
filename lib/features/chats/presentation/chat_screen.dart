import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../../core/domain/models/message.dart';
import '../../../core/gpt/gpt_service.dart';
import '../../../core/localization/generated/l10n.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../logic/chat_notifier.dart';

@RoutePage()
class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chat = ref.watch(chatNotifierProvider).state.chat;
    final chatTitle =
        '${chat.chatLanguage.localizedName} ${chat.level.value}\n${chat.topic}';

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CupertinoPageScaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
          leading: CupertinoNavigationBarBackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          middle: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              chatTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0A0A0A),
                letterSpacing: 0.0703,
              ),
            ),
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              ref
                  .read(startRealtimeCallUseCaseProvider)
                  .start(
                    topic: chat.topic,
                    language: chat.chatLanguage,
                    level: chat.level,
                    teacherLanguage: chat.teacherLanguage,
                  );
            },
            child: const Icon(CupertinoIcons.phone),
          ),
        ),
        child: const _Body(),
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatNotifier = ref.watch(chatNotifierProvider);
    final MessagesState state = chatNotifier.state;
    final List<Message> messages = state.messages.reversed.toList();
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

    return Container(
      color: const Color(0xFFF9FAFB),
      child: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(child: Text(S.of(context).noMessages))
                : SafeArea(
                    top: true,
                    bottom: false,
                    child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: messages.length,
                      itemBuilder: (context, index) => _MessageBubble(
                        onMessageUpdated: () {
                          _scrollToBottom();
                        },
                        message: messages[index],
                        onDeletePressed: () {
                          ref
                              .read(deleteChatUseCaseProvider)
                              .deleteMessage(messages[index].id);
                        },
                      ),
                    ),
                  ),
          ),
          _MessageInput(scrollController: _scrollController),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatefulWidget {
  const _MessageBubble({
    required this.message,
    required this.onDeletePressed,
    required this.onMessageUpdated,
  });
  final Message message;
  final VoidCallback onDeletePressed;
  final VoidCallback onMessageUpdated;

  @override
  State<_MessageBubble> createState() => __MessageBubbleState();
}

class __MessageBubbleState extends State<_MessageBubble> {
  Message get message => widget.message;
  @override
  void didUpdateWidget(covariant _MessageBubble oldWidget) {
    if (oldWidget.message.text != message.text) {
      widget.onMessageUpdated();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    final tutorAnswer = message.tutorAnswer;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: CupertinoContextMenu.builder(
              actions: [
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onDeletePressed();
                  },
                  trailingIcon: CupertinoIcons.delete,
                  child: Text(S.of(context).delete),
                ),
              ],
              builder: (context, animation) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 17,
                    right: 17,
                    top: 1,
                    bottom: 1,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xFF155DFC) : Colors.white,
                    border: isMe
                        ? null
                        : const Border.fromBorderSide(
                            BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isMe ? 16 : 6),
                      topRight: Radius.circular(isMe ? 6 : 16),
                      bottomLeft: const Radius.circular(16),
                      bottomRight: const Radius.circular(16),
                    ),
                    boxShadow: isMe
                        ? null
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 2,
                              offset: const Offset(0, -1),
                            ),
                          ],
                  ),
                  child: (!isMe && tutorAnswer != null)
                      ? animation.value > 0
                            ? SizedBox(
                                height: 200,
                                child: SingleChildScrollView(
                                  child: _buildTutorMessageContent(tutorAnswer),
                                ),
                              )
                            : _buildTutorMessageContent(tutorAnswer)
                      : (message.text.isNotEmpty)
                      ? DefaultTextStyle(
                          style: TextStyle(
                            color: isMe
                                ? Colors.white
                                : const Color(0xFF101828),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            letterSpacing: -0.3125,
                            height: 24 / 16,
                          ),
                          child: MarkdownWidget(
                            padding: EdgeInsets.zero,
                            selectable: false,
                            shrinkWrap: true,
                            data: message.text,
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CupertinoActivityIndicator(
                            color: Color(0xFFFFFFFF),
                            radius: 10,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorMessageContent(TutorAnswer tutorAnswer) {
    final List<Widget> children = [];

    if (tutorAnswer.assistantMessage.isNotEmpty) {
      children.add(_buildMessageBlock(tutorAnswer.assistantMessage));
    }

    if (tutorAnswer.correction != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: 12));
      }
      children.add(_buildCorrectionBlock(tutorAnswer.correction!));
    }

    if (tutorAnswer.correction?.explanation != null &&
        tutorAnswer.correction!.explanation.isNotEmpty) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: 12));
      }
      children.add(_buildMessageBlock(tutorAnswer.correction!.explanation));
    }

    if (tutorAnswer.suggestedTranslation != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: 12));
      }
      children.add(_buildTranslationBlock(tutorAnswer.suggestedTranslation!));
    }

    if (tutorAnswer.userQuestionAnswer != null) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: 12));
      }
      children.add(_buildMessageBlock(tutorAnswer.userQuestionAnswer!.answer));
    }

    if (tutorAnswer.conversationContinue.isNotEmpty) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: 12));
      }
      children.add(_buildMessageBlock(tutorAnswer.conversationContinue));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildMessageBlock(String text) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Color(0xFF101828),
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: -0.3125,
        height: 24 / 16,
      ),
      child: MarkdownWidget(
        padding: EdgeInsets.zero,
        selectable: false,
        shrinkWrap: true,
        data: text,
      ),
    );
  }

  Widget _buildCorrectionBlock(Correction correction) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        border: Border.all(
          color: const Color(0xFFFEE685),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: const TextStyle(
              color: Color(0xFF6A7282),
              fontSize: 16,
              fontWeight: FontWeight.normal,
              letterSpacing: -0.3125,
              height: 24 / 16,
              decoration: TextDecoration.lineThrough,
              decorationColor: Color(0xFF6A7282),
            ),
            child: MarkdownWidget(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              data: correction.original,
            ),
          ),
          const SizedBox(height: 4),
          DefaultTextStyle(
            style: const TextStyle(
              color: Color(0xFF101828),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.3125,
              height: 24 / 16,
            ),
            child: MarkdownWidget(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              data: correction.correctedMarkdown,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationBlock(SuggestedTranslation translation) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        border: Border.all(
          color: const Color(0xFFBEDBFF),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Color(0xFF1C398E),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.3125,
          height: 24 / 16,
        ),
        child: MarkdownWidget(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          data: translation.translation,
        ),
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
  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;

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
    _recordingTimer?.cancel();
    messageController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _startRecordingTimer() {
    _recordingDuration = Duration.zero;
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _recordingDuration = Duration(seconds: timer.tick);
        });
      }
    });
  }

  void _stopRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    if (mounted) {
      setState(() {
        _recordingDuration = Duration.zero;
      });
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollController.hasClients) {
        widget.scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      ref.read(addMessageUseCaseProvider).addMessage(text);
      messageController.clear();
      // Клавиатура не скрывается при отправке сообщения
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final isSpeechRecording = ref
        .watch(chatNotifierProvider)
        .state
        .isSpeechRecording;

    // Управление таймером записи
    if (isSpeechRecording && _recordingTimer == null) {
      _startRecordingTimer();
    } else if (!isSpeechRecording && _recordingTimer != null) {
      _stopRecordingTimer();
    }

    // Скролл при изменении высоты клавиатуры
    if (bottomPadding != _previousKeyboardHeight && bottomPadding > 0) {
      _previousKeyboardHeight = bottomPadding;
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    } else if (bottomPadding == 0) {
      _previousKeyboardHeight = 0;
    }

    // Состояние записи аудио
    if (isSpeechRecording) {
      return Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 13,
          bottom: 13 + bottomPadding,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Container(
            height: 69,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 1,
              bottom: 0,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFFEF2F2),
              border: Border(
                top: BorderSide(
                  color: Color(0xFFFFC9C9),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFE7000B,
                          ).withValues(alpha: 0.709),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDuration(_recordingDuration),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF82181A),
                          letterSpacing: -0.3125,
                          height: 24 / 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Кнопка отмены записи (мусорка)
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: ref
                      .read(addMessageUseCaseProvider)
                      .cancelAudioRecording,
                  minimumSize: const Size(0, 0),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F4F6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.delete,
                      color: Color(0xFF101828),
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Кнопка закончить запись (отправить)
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: ref
                      .read(addMessageUseCaseProvider)
                      .stopAudioRecording,
                  minimumSize: const Size(0, 0),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE7000B),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Обычное состояние с полем ввода
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 13,
        bottom: 13 + bottomPadding,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16777200),
                  border: Border.all(
                    color: const Color(0xFFD1D5DC),
                    width: 1,
                  ),
                ),
                child: CupertinoTextField(
                  controller: messageController,
                  focusNode: focusNode,
                  placeholder: S.of(context).typeYourMessage,
                  placeholderStyle: const TextStyle(
                    color: Color(0xFF99A1AF),
                    fontSize: 16,
                    letterSpacing: -0.3125,
                  ),
                  minLines: 1,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: -0.3125,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Кнопка микрофона (всегда видна)
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: ref.read(addMessageUseCaseProvider).toggleRecording,
              minimumSize: const Size(0, 0),
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.mic,
                  color: Color(0xFF101828),
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Кнопка отправки
            ValueListenableBuilder(
              valueListenable: messageController,
              builder: (context, value, child) {
                final hasText = messageController.text.isNotEmpty;
                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: hasText ? _sendMessage : null,
                  minimumSize: const Size(0, 0),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: hasText
                          ? const Color(0xFF155DFC)
                          : const Color(0xFFD1D5DC).withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.arrow_up,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
