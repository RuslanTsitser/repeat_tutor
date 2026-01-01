import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';

class CycleScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const CycleScreen({
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
            child: CycleBackButton(onPrevious: onPrevious!),
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
                        child: CycleIllustration(),
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: CycleContent(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CycleButton(onNext: onNext),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CycleIllustration extends StatelessWidget {
  const CycleIllustration({super.key});

  static const double _illustrationSize = 256.0;
  static const double _ringSize = 200.0;
  static const double _centerSize = 80.0;
  static const double _stepSize = 44.0;
  static const double _stepIconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ring
          Container(
            width: _ringSize,
            height: _ringSize,
            decoration: BoxDecoration(
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

          // Center
          Container(
            width: _centerSize,
            height: _centerSize,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.repeat,
              color: AppColors.surface,
              size: 32.0,
            ),
          )
              .animate(delay: 400.ms)
              .scale(
                duration: 600.ms,
                curve: Curves.elasticOut,
              )
              .fadeIn(),

          // Steps on ring
          Positioned(
            top: 0,
            child: _buildStep(
              LucideIcons.ear,
              delay: 200.ms,
            ),
          ),
          Positioned(
            right: 0,
            child: _buildStep(
              LucideIcons.mic,
              delay: 400.ms,
            ),
          ),
          Positioned(
            bottom: 0,
            child: _buildStep(
              LucideIcons.messageSquare,
              delay: 600.ms,
            ),
          ),
          Positioned(
            left: 0,
            child: _buildStep(
              LucideIcons.refreshCw,
              delay: 800.ms,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(IconData icon, {Duration delay = Duration.zero}) {
    return Container(
      width: _stepSize,
      height: _stepSize,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textMuted.withValues(alpha: 0.1),
            blurRadius: 16,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: AppColors.primary,
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

class CycleContent extends StatelessWidget {
  const CycleContent({super.key});

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

class CycleBackButton extends StatelessWidget {
  final VoidCallback onPrevious;

  const CycleBackButton({
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

class CycleButton extends StatelessWidget {
  final VoidCallback onNext;

  const CycleButton({
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

