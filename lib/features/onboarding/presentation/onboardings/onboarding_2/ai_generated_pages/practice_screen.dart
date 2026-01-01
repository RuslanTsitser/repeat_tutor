import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';

class PracticeScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const PracticeScreen({
    super.key,
    required this.onNext,
    this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (onPrevious != null) ...[
          SafeArea(
            bottom: false,
            child: PracticeBackButton(onPrevious: onPrevious!),
          ),
          const SizedBox(height: 16.0),
        ],
        Expanded(
          child: SafeArea(
            child: Column(
              children: [
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: PracticeIllustration(),
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: PracticeContent(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PracticeButton(onNext: onNext),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PracticeIllustration extends StatelessWidget {
  const PracticeIllustration({super.key});

  static const double _illustrationSize = 256.0;
  static const double _cardSize = 120.0;
  static const double _iconSize = 32.0;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Card 1 - Listen
          Positioned(
            top: 32.0,
            left: 32.0,
            child: _buildCard(
              context,
              LucideIcons.ear,
              S.of(context).listen,
              delay: 200.ms,
            ),
          ),
          // Card 2 - Speak
          Positioned(
            top: 32.0,
            right: 32.0,
            child: _buildCard(
              context,
              LucideIcons.mic,
              S.of(context).speak,
              delay: 400.ms,
            ),
          ),
          // Card 3 - Learn
          Positioned(
            bottom: 32.0,
            left: 32.0,
            child: _buildCard(
              context,
              LucideIcons.brain,
              S.of(context).learn,
              delay: 600.ms,
            ),
          ),
          // Card 4 - Repeat
          Positioned(
            bottom: 32.0,
            right: 32.0,
            child: _buildCard(
              context,
              LucideIcons.refreshCw,
              S.of(context).repeat,
              delay: 800.ms,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    IconData icon,
    String label, {
    Duration delay = Duration.zero,
  }) {
    return Container(
          width: _cardSize,
          height: _cardSize,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(_borderRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.textMuted.withValues(alpha: 0.1),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: _iconSize,
              ),
              const SizedBox(height: 8.0),
              Text(
                label,
                style: AppTextStyle.inter12w600
                    .copyWith(
                      color: AppColors.textMuted,
                    )
                    .scaled(context),
              ),
            ],
          ),
        )
        .animate(delay: delay)
        .scale(duration: 500.ms, curve: Curves.elasticOut)
        .fadeIn();
  }
}

class PracticeContent extends StatelessWidget {
  const PracticeContent({super.key});

  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            Center(
              child: Semantics(
                label: S.of(context).theRepetitionLoop,
                child: Text(
                  S.of(context).theRepetitionLoop,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.inter24w700.scaled(context),
                ),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label: S
                  .of(context)
                  .listenSpeakGetGentleAiFeedbackAndRepeatItsThe,
              child: Text(
                S.of(context).listenSpeakGetGentleAiFeedbackAndRepeatItsThe,
                textAlign: TextAlign.start,
                style: AppTextStyle.inter16w400
                    .copyWith(
                      color: AppColors.textMuted,
                    )
                    .scaled(context),
              ),
            ),
          ],
        )
        .animate(delay: 400.ms)
        .moveY(begin: 16, end: 0, curve: Curves.easeOut)
        .fadeIn();
  }
}

class PracticeBackButton extends StatelessWidget {
  final VoidCallback onPrevious;

  const PracticeBackButton({
    super.key,
    required this.onPrevious,
  });

  static const double _iconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: S.of(context).back,
      child: Align(
        alignment: Alignment.centerLeft,
        child: CupertinoButton(
          onPressed: onPrevious,
          padding: EdgeInsets.zero,
          minimumSize: const Size(44.0, 44.0),
          child: const Icon(
            LucideIcons.chevronLeft,
            size: _iconSize,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class PracticeButton extends StatelessWidget {
  final VoidCallback onNext;

  const PracticeButton({
    super.key,
    required this.onNext,
  });

  static const double _verticalPadding = 16.0;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: S.of(context).nextButton,
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          onPressed: onNext,
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          minimumSize: const Size(0, 44.0),
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Text(
            S.of(context).nextButton,
            style: AppTextStyle.inter16w600
                .copyWith(
                  color: AppColors.surface,
                )
                .scaled(context),
          ),
        ),
      ),
    ).animate(delay: 600.ms).moveY(begin: 16, end: 0).fadeIn();
  }
}
