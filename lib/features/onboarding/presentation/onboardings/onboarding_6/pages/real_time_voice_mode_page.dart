import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../../../../../gen/assets.gen.dart';
import 'onboarding_back_button_wrapper.dart';

class RealTimeVoiceModePage extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const RealTimeVoiceModePage({
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
            const Expanded(
              child: RealTimeVoiceModeIllustration(),
            ),
            const SizedBox(height: 32.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                width: double.infinity,
                child: RealTimeVoiceModeContent(),
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RealTimeVoiceModeButton(
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

class RealTimeVoiceModeIllustration extends StatelessWidget {
  const RealTimeVoiceModeIllustration({super.key});

  static const double _borderWidth = 1.0;
  static const double _borderRadius = 16.0;
  static const double _padding = 16.0;

  @override
  Widget build(BuildContext context) {
    final mockData = _createMockData(context);
    final width = MediaQuery.sizeOf(context).width;

    return Container(
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
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: _padding),
          color: AppColors.backgroundLight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: _padding),
              const _MockLanguageAvatar(),
              const SizedBox(height: 16.0),
              _MockCallTitle(
                topic: mockData.topic,
                language: mockData.language,
                level: mockData.level,
              ),
              const SizedBox(height: 16.0),
              _MockCallTimer(duration: mockData.duration),
              const SizedBox(height: 16.0),
              _MockTutorMessage(message: mockData.tutorMessage),
              const SizedBox(height: 8.0),
              _MockTutorNotesMarkdown(
                correctionMarkdown: mockData.correctionMarkdown,
                explanation: mockData.explanation,
              ),
              const SizedBox(height: 16.0),
              const _MockControlButtons(),
              const SizedBox(height: _padding),
            ],
          ),
        ),
      ),
    ).animate(delay: 200.ms).fadeIn(duration: 600.ms);
  }
}

class _MockData {
  _MockData({
    required this.topic,
    required this.language,
    required this.level,
    required this.duration,
    required this.tutorMessage,
    required this.correctionMarkdown,
    required this.explanation,
  });

  final String topic;
  final String language;
  final String level;
  final Duration duration;
  final String tutorMessage;
  final String correctionMarkdown;
  final String explanation;
}

_MockData _createMockData(BuildContext context) {
  final s = S.of(context);
  return _MockData(
    topic: s.exampleTopicFreeTime,
    language: s.onboarding6RealTimeVoiceMockLanguage,
    level: s.onboarding6RealTimeVoiceMockLevel,
    duration: const Duration(minutes: 2, seconds: 34),
    tutorMessage: s.onboarding6RealTimeVoiceMockTutorMessage,
    correctionMarkdown: s.onboarding6RealTimeVoiceMockCorrectionMarkdown,
    explanation: s.onboarding6RealTimeVoiceMockExplanation,
  );
}

class _MockLanguageAvatar extends StatelessWidget {
  const _MockLanguageAvatar();

  static const double _size = 64.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            spreadRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Assets.appIcon.image(
        width: _size,
        height: _size,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _MockCallTitle extends StatelessWidget {
  const _MockCallTitle({
    required this.topic,
    required this.language,
    required this.level,
  });

  final String topic;
  final String language;
  final String level;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          topic,
          style: AppTextStyle.inter16w500.copyWith(
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '$language $level',
          style: AppTextStyle.inter12w400.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _MockCallTimer extends StatelessWidget {
  const _MockCallTimer({required this.duration});

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return Text(
      '$minutes:$seconds',
      style: AppTextStyle.inter20w500,
    );
  }
}

class _MockTutorMessage extends StatelessWidget {
  const _MockTutorMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        message,
        style: AppTextStyle.inter12w400,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _MockTutorNotesMarkdown extends StatelessWidget {
  const _MockTutorNotesMarkdown({
    required this.correctionMarkdown,
    required this.explanation,
  });

  final String correctionMarkdown;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (correctionMarkdown.isNotEmpty) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              border: Border.all(
                color: const Color(0xFFFEE685),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: DefaultTextStyle(
              style: AppTextStyle.inter12w400.copyWith(
                color: AppColors.textPrimary,
              ),
              child: MarkdownWidget(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                data: correctionMarkdown,
              ),
            ),
          ),
        ),
      );
    }

    if (explanation.isNotEmpty) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DefaultTextStyle(
              style: AppTextStyle.inter12w400.copyWith(
                color: AppColors.textPrimary,
              ),
              child: MarkdownWidget(
                padding: EdgeInsets.zero,
                selectable: false,
                shrinkWrap: true,
                data: explanation,
              ),
            ),
          ),
        ),
      );
    }

    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class _MockControlButtons extends StatelessWidget {
  const _MockControlButtons();

  static const double _size = 32.0;
  static const double _spacing = 16.0;
  static const Color _redColor = Color(0xFFE7000B);
  static const List<BoxShadow> _shadows = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 8.0,
      offset: Offset(0, 2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.divider, width: 0.5),
            boxShadow: _shadows,
          ),
          child: const Icon(
            CupertinoIcons.mic,
            color: AppColors.textPrimary,
            size: 16.0,
          ),
        ),
        const SizedBox(width: _spacing),
        Container(
          width: _size,
          height: _size,
          decoration: const BoxDecoration(
            color: _redColor,
            shape: BoxShape.circle,
            boxShadow: _shadows,
          ),
          child: const Icon(
            CupertinoIcons.phone_down,
            color: AppColors.surface,
            size: 16.0,
          ),
        ),
      ],
    );
  }
}

class RealTimeVoiceModeContent extends StatelessWidget {
  const RealTimeVoiceModeContent({super.key});

  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Semantics(
                label: s.onboarding6RealTimeVoiceTitle,
                child: Text(
                  s.onboarding6RealTimeVoiceTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.inter24w700.scaled(context),
                ),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label: s.onboarding6RealTimeVoiceSubtitle,
              child: Text(
                s.onboarding6RealTimeVoiceSubtitle,
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

class RealTimeVoiceModeButton extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const RealTimeVoiceModeButton({
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
