import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../../../../../core/domain/models/message.dart';
import '../../../../../../core/gpt/gpt_service.dart';
import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';
import 'onboarding_back_button_wrapper.dart';

class MistakesOkPage extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const MistakesOkPage({
    super.key,
    required this.onNext,
    this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingBackButtonWrapper(
      onPrevious: onPrevious,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32.0),
            const Expanded(
              child: MistakesOkIllustration(),
            ),
            const SizedBox(height: 32.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                width: double.infinity,
                child: MistakesOkContent(),
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MistakesOkButton(
                onNext: onNext,
                onPrevious: onPrevious,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MistakesOkIllustration extends StatelessWidget {
  const MistakesOkIllustration({super.key});

  static const double _maxWidth = 320.0;
  static const double _borderWidth = 1.0;
  static const double _borderRadius = 16.0;
  static const double _padding = 16.0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final mockData = _createMockData(s);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
            color: AppColors.divider,
            width: _borderWidth,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.textMuted.withValues(alpha: 0.1),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Container(
            width: _maxWidth,
            padding: const EdgeInsets.symmetric(horizontal: _padding),
            color: AppColors.backgroundLight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: _padding),
                  _MockMessageBubble(
                    message: mockData.userMessage,
                    isMe: true,
                  ),
                  const SizedBox(height: 8.0),
                  _MockMessageBubble(
                    message: mockData.tutorMessage,
                    isMe: false,
                    tutorAnswer: mockData.tutorAnswer,
                  ),
                  const SizedBox(height: _padding),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate(delay: 200.ms).fadeIn(duration: 600.ms);
  }
}

class _MockData {
  const _MockData({
    required this.userMessage,
    required this.tutorMessage,
    required this.tutorAnswer,
  });

  final Message userMessage;
  final Message tutorMessage;
  final TutorAnswer tutorAnswer;
}

_MockData _createMockData(S s) {
  // Пользователь всегда говорит на английском (изучает английский)
  const userText = 'I goed to the store yesterday';

  final tutorAnswer = TutorAnswer(
    caseType: CaseType.correctedAnswer,
    assistantMessage: s.onboarding6MistakesOkExampleTutorMessage,
    correction: Correction(
      original: userText,
      correctedMarkdown: 'I ~~goed~~ **went** to the store yesterday',
      explanation: s.onboarding6MistakesOkExampleExplanation,
    ),
    suggestedTranslation: null,
    userQuestionAnswer: null,
    conversationContinue: s.onboarding6MistakesOkExampleContinue,
  );

  final userMessage = Message(
    id: 1,
    gptResponseId: null,
    text: userText,
    chatId: 1,
    createdAt: DateTime(2024, 1, 1),
  );

  final tutorMessage = Message(
    id: 2,
    gptResponseId: 'gpt-123',
    text: '',
    chatId: 1,
    createdAt: DateTime(2024, 1, 1),
    tutorAnswer: tutorAnswer,
  );

  return _MockData(
    userMessage: userMessage,
    tutorMessage: tutorMessage,
    tutorAnswer: tutorAnswer,
  );
}

class _MockMessageBubble extends StatelessWidget {
  const _MockMessageBubble({
    required this.message,
    required this.isMe,
    this.tutorAnswer,
  });

  final Message message;
  final bool isMe;
  final TutorAnswer? tutorAnswer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 240.0,
            ),
            child: _MessageBubbleContainer(
              isMe: isMe,
              child: _MessageContent(
                isMe: isMe,
                message: message,
                tutorAnswer: tutorAnswer,
              ),
            ),
          ),
        ),
      ],
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
        horizontal: 16.0,
        vertical: 8.0,
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
          topLeft: Radius.circular(isMe ? 16.0 : 8.0),
          topRight: Radius.circular(isMe ? 8.0 : 16.0),
          bottomLeft: const Radius.circular(16.0),
          bottomRight: const Radius.circular(16.0),
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
    this.tutorAnswer,
  });

  final bool isMe;
  final Message message;
  final TutorAnswer? tutorAnswer;

  @override
  Widget build(BuildContext context) {
    if (!isMe && tutorAnswer != null) {
      return _TutorAnswerContent(tutorAnswer: tutorAnswer!);
    }

    if (message.text.isNotEmpty) {
      return _SimpleMessageText(text: message.text, isMe: isMe);
    }

    return const SizedBox.shrink();
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: DefaultTextStyle(
        style: AppTextStyle.inter16w400.copyWith(
          color: AppColors.textPrimary,
        ),
        child: MarkdownWidget(
          padding: EdgeInsets.zero,
          selectable: false,
          shrinkWrap: true,
          data: text,
        ),
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
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        border: Border.all(
          color: const Color(0xFFFEE685),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

class MistakesOkContent extends StatelessWidget {
  const MistakesOkContent({super.key});

  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Semantics(
                label: s.onboarding6MistakesOkTitle,
                child: Text(
                  s.onboarding6MistakesOkTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.inter24w700.scaled(context),
                ),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label: s.onboarding6MistakesOkSubtitle,
              child: Text(
                s.onboarding6MistakesOkSubtitle,
                textAlign: TextAlign.center,
                style: AppTextStyle.inter16w400
                    .copyWith(
                      color: AppColors.textMuted,
                    )
                    .scaled(context),
              ),
            ),
          ],
        )
        .animate(delay: 600.ms)
        .moveY(begin: 16, end: 0, curve: Curves.easeOut)
        .fadeIn();
  }
}

class MistakesOkButton extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const MistakesOkButton({
    super.key,
    required this.onNext,
    this.onPrevious,
  });

  static const double _verticalPadding = 16.0;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Semantics(
      button: true,
      label: s.continueButton,
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          onPressed: onNext,
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          minimumSize: const Size(0, 44.0),
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Text(
            s.continueButton,
            style: AppTextStyle.inter16w600
                .copyWith(
                  color: AppColors.surface,
                )
                .scaled(context),
          ),
        ),
      ),
    ).animate(delay: 1000.ms).moveY(begin: 16, end: 0).fadeIn();
  }
}
