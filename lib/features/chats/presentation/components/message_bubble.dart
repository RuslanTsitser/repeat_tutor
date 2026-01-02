import 'package:flutter/cupertino.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../../../core/domain/models/message.dart';
import '../../../../core/gpt/gpt_service.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

/// Декларативный подход с отдельными виджетами
/// Каждый тип контента - отдельный виджет, более читаемый код
class MessageBubble extends StatefulWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.onDeletePressed,
    required this.onMessageUpdated,
  });

  final Message message;
  final VoidCallback onDeletePressed;
  final VoidCallback onMessageUpdated;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  void didUpdateWidget(covariant MessageBubble oldWidget) {
    if (oldWidget.message.text != widget.message.text) {
      widget.onMessageUpdated();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final isMe = widget.message.isMe;
    final tutorAnswer = widget.message.tutorAnswer;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth * 0.75,
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
                      return _MessageBubbleContainer(
                        isMe: isMe,
                        child: _MessageContent(
                          isMe: isMe,
                          message: widget.message,
                          tutorAnswer: tutorAnswer,
                          animationValue: animation.value,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubbleContainer extends StatelessWidget {
  const _MessageBubbleContainer({
    required this.isMe,
    required this.child,
  });

  final bool isMe;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isMe ? AppColors.primary : AppColors.surface,
        border: isMe
            ? null
            : const Border.fromBorderSide(
                BorderSide(
                  color: AppColors.divider,
                  width: 1,
                ),
              ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 16 : 8),
          topRight: Radius.circular(isMe ? 8 : 16),
          bottomLeft: const Radius.circular(16),
          bottomRight: const Radius.circular(16),
        ),
      ),
      child: child,
    );
  }
}

class _MessageContent extends StatelessWidget {
  const _MessageContent({
    required this.isMe,
    required this.message,
    required this.tutorAnswer,
    required this.animationValue,
  });

  final bool isMe;
  final Message message;
  final TutorAnswer? tutorAnswer;
  final double animationValue;

  @override
  Widget build(BuildContext context) {
    if (!isMe && tutorAnswer != null) {
      final content = _TutorAnswerContent(tutorAnswer: tutorAnswer!);
      return animationValue > 0
          ? SizedBox(
              height: 192,
              child: SingleChildScrollView(child: content),
            )
          : content;
    }

    if (message.text.isNotEmpty) {
      return _SimpleMessageText(text: message.text, isMe: isMe);
    }

    return _LoadingIndicator(isMe: isMe);
  }
}

class _SimpleMessageText extends StatelessWidget {
  const _SimpleMessageText({
    required this.text,
    required this.isMe,
  });

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: AppTextStyle.inter16w400.copyWith(
        color: isMe ? AppColors.surface : AppColors.textPrimary,
      ),
      child: MarkdownWidget(
        padding: EdgeInsets.zero,
        selectable: false,
        shrinkWrap: true,
        data: text,
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({required this.isMe});

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoActivityIndicator(
        color: !isMe ? AppColors.primary : AppColors.surface,
        radius: 10,
      ),
    );
  }
}

class _TutorAnswerContent extends StatelessWidget {
  const _TutorAnswerContent({required this.tutorAnswer});

  final TutorAnswer tutorAnswer;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (tutorAnswer.assistantMessage.isNotEmpty) {
      children.add(_MessageBlock(text: tutorAnswer.assistantMessage));
    }

    if (tutorAnswer.correction != null) {
      children.add(_CorrectionBlock(correction: tutorAnswer.correction!));
    }

    if (tutorAnswer.correction?.explanation != null &&
        tutorAnswer.correction!.explanation.isNotEmpty) {
      children.add(_MessageBlock(text: tutorAnswer.correction!.explanation));
    }

    if (tutorAnswer.suggestedTranslation != null) {
      children.add(
        _TranslationBlock(translation: tutorAnswer.suggestedTranslation!),
      );
    }

    if (tutorAnswer.userQuestionAnswer != null) {
      children.add(_MessageBlock(text: tutorAnswer.userQuestionAnswer!.answer));
    }

    if (tutorAnswer.conversationContinue.isNotEmpty) {
      children.add(_MessageBlock(text: tutorAnswer.conversationContinue));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class _MessageBlock extends StatelessWidget {
  const _MessageBlock({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: AppTextStyle.inter16w400.copyWith(
        color: AppColors.textPrimary,
      ),
      child: MarkdownWidget(
        padding: EdgeInsets.zero,
        selectable: false,
        shrinkWrap: true,
        data: text,
      ),
    );
  }
}

class _CorrectionBlock extends StatelessWidget {
  const _CorrectionBlock({required this.correction});

  final Correction correction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        border: Border.all(
          color: const Color(0xFFFEE685),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: AppTextStyle.inter16w400.copyWith(
              color: AppColors.textSecondary,
              decoration: TextDecoration.lineThrough,
              decorationColor: AppColors.textSecondary,
            ),
            child: MarkdownWidget(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              data: correction.original,
            ),
          ),
          const SizedBox(height: 8),
          DefaultTextStyle(
            style: AppTextStyle.inter16w500.copyWith(
              color: AppColors.textPrimary,
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
}

class _TranslationBlock extends StatelessWidget {
  const _TranslationBlock({required this.translation});

  final SuggestedTranslation translation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        border: Border.all(
          color: const Color(0xFFBEDBFF),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DefaultTextStyle(
        style: AppTextStyle.inter16w500.copyWith(
          color: AppColors.accentBlue,
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
