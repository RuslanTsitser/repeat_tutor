import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';

class ProcessScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const ProcessScreen({
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
            child: ProcessBackButton(onPrevious: onPrevious!),
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
                        child: ProcessIllustration(),
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ProcessContent(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ProcessButton(onNext: onNext),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProcessIllustration extends StatelessWidget {
  const ProcessIllustration({super.key});

  static const double _illustrationSize = 256.0;
  static const double _circleSize = 180.0;
  static const double _stepSize = 48.0;
  static const double _stepIconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Central Circle
          Container(
            width: _circleSize,
            height: _circleSize,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
          )
              .animate()
              .scale(
                duration: 1.seconds,
                curve: Curves.easeOut,
              )
              .fadeIn(duration: 1.seconds),

          // Steps around circle
          Positioned(
            top: 0,
            child: _buildStep(
              LucideIcons.ear,
              0,
              delay: 200.ms,
            ),
          ),
          Positioned(
            right: 0,
            child: _buildStep(
              LucideIcons.mic,
              1,
              delay: 400.ms,
            ),
          ),
          Positioned(
            bottom: 0,
            child: _buildStep(
              LucideIcons.messageSquare,
              2,
              delay: 600.ms,
            ),
          ),
          Positioned(
            left: 0,
            child: _buildStep(
              LucideIcons.refreshCw,
              3,
              delay: 800.ms,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(IconData icon, int index, {Duration delay = Duration.zero}) {
    return Container(
      width: _stepSize,
      height: _stepSize,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: AppColors.surface,
        size: _stepIconSize,
      ),
    )
        .animate(delay: delay)
        .scale(
          duration: 500.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn();
  }
}

class ProcessContent extends StatelessWidget {
  const ProcessContent({super.key});

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

class ProcessBackButton extends StatelessWidget {
  final VoidCallback onPrevious;

  const ProcessBackButton({
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

class ProcessButton extends StatelessWidget {
  final VoidCallback onNext;

  const ProcessButton({
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

