import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../infrastructure/state_managers.dart';
import '../../../../infrastructure/use_case.dart';
import '../../../onboarding/presentation/onboarding_wrappers/onboarding_chat_wrapper.dart';

class MessageInput extends ConsumerStatefulWidget {
  const MessageInput({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  ConsumerState<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends ConsumerState<MessageInput> {
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: isSpeechRecording
          ? const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFEF2F2),
                  AppColors.surface,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border(
                top: BorderSide(
                  color: AppColors.divider,
                  width: 1,
                ),
              ),
            )
          : const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [
                  AppColors.surface,
                  AppColors.surface,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),

              border: Border(
                top: BorderSide(
                  color: AppColors.divider,
                  width: 1,
                ),
              ),
            ),
      child: SafeArea(
        minimum: const EdgeInsets.all(16),
        top: false,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 48,
          ),
          child: isSpeechRecording
              ? Row(
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
                            style: AppTextStyle.inter16w500.copyWith(
                              color: const Color(0xFF82181A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
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
                          color: AppColors.secondaryCtaBackground,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.delete,
                          color: AppColors.textPrimary,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: WriteTextMessageWrapper(
                        child: CupertinoTextField(
                          controller: messageController,
                          focusNode: focusNode,
                          placeholder: S.of(context).typeYourMessage,
                          placeholderStyle: AppTextStyle.inter16w400.copyWith(
                            color: AppColors.textMuted,
                          ),
                          minLines: 1,
                          maxLines: 5,
                          textCapitalization: TextCapitalization.sentences,
                          style: AppTextStyle.inter16w400,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppColors.divider,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Кнопка микрофона (всегда видна)
                    SendAudioMessageWrapper(
                      child: Semantics(
                        label: 'Отправить аудио сообщение',
                        button: true,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: ref
                              .read(addMessageUseCaseProvider)
                              .toggleRecording,
                          minimumSize: const Size(0, 0),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: AppColors.secondaryCtaBackground,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.mic,
                              color: AppColors.textPrimary,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Кнопка отправки
                    ValueListenableBuilder(
                      valueListenable: messageController,
                      builder: (context, value, child) {
                        final hasText = messageController.text.isNotEmpty;
                        return Semantics(
                          label: 'Отправить сообщение',
                          button: true,
                          enabled: hasText,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: hasText ? _sendMessage : null,
                            minimumSize: const Size(0, 0),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: hasText
                                    ? AppColors.primary
                                    : AppColors.divider.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                CupertinoIcons.arrow_up,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
