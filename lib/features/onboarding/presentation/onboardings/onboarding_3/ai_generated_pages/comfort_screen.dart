import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';

class ComfortScreen extends StatelessWidget {
  final VoidCallback onNext;

  const ComfortScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: ComfortIllustration(),
                ),
                SizedBox(height: 32.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ComfortContent(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ComfortButton(onNext: onNext),
          ),
        ],
      ),
    );
  }
}

class ComfortIllustration extends StatelessWidget {
  const ComfortIllustration({super.key});

  static const _illustrationSize = 256.0;
  static const _mainCircleSize = 160.0;
  static const _innerCircleSize = 100.0;
  static const _iconSize = 48.0;
  static const _smallCircleSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Circle
          Container(
            width: _mainCircleSize,
            height: _mainCircleSize,
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

          // Inner Circle
          Container(
            width: _innerCircleSize,
            height: _innerCircleSize,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
          )
              .animate(delay: 300.ms)
              .scale(duration: 800.ms, curve: Curves.easeOut)
              .fadeIn(),

          // Center Icon
          const Icon(
            LucideIcons.shieldCheck,
            color: AppColors.primary,
            size: _iconSize,
          )
              .animate(delay: 600.ms)
              .scale(
                duration: 600.ms,
                curve: Curves.elasticOut,
              )
              .fadeIn(),

          // Small Circles
          Positioned(
            top: 16.0,
            child: _buildSmallCircle(delay: 200.ms),
          ),
          Positioned(
            right: 16.0,
            child: _buildSmallCircle(delay: 400.ms),
          ),
          Positioned(
            bottom: 16.0,
            child: _buildSmallCircle(delay: 600.ms),
          ),
          Positioned(
            left: 16.0,
            child: _buildSmallCircle(delay: 800.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCircle({Duration delay = Duration.zero}) {
    return Container(
      width: _smallCircleSize,
      height: _smallCircleSize,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
    )
        .animate(delay: delay)
        .scale(duration: 400.ms, curve: Curves.elasticOut)
        .fadeIn();
  }
}

class ComfortContent extends StatelessWidget {
  const ComfortContent({super.key});

  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: SafeSpaceTag(),
            ),
            const SizedBox(
              height: _spacing,
              width: double.infinity,
            ),
            Semantics(
              label: S
                  .of(context)
                  .practiceWithoutJudgmentMakeMistakesLearnAndGrowInA,
              child: Text(
                S
                    .of(context)
                    .practiceWithoutJudgmentMakeMistakesLearnAndGrowInA,
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
        .animate(delay: 600.ms)
        .moveY(begin: 16, end: 0, curve: Curves.easeOut)
        .fadeIn();
  }
}

class SafeSpaceTag extends StatelessWidget {
  const SafeSpaceTag({super.key});

  static const double _iconSize = 16.0;
  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 4.0;
  static const double _spacing = 8.0;
  static const double _borderRadius = 24.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: S.of(context).safeSpace,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: _verticalPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              LucideIcons.shieldCheck,
              size: _iconSize,
              color: AppColors.primary,
            ),
            const SizedBox(width: _spacing),
            Text(
              S.of(context).safeSpace,
              style: AppTextStyle.inter16w600
                  .copyWith(
                    color: AppColors.primary,
                  )
                  .scaled(context),
            ),
          ],
        ),
      ),
    );
  }
}

class ComfortButton extends StatelessWidget {
  final VoidCallback onNext;

  const ComfortButton({
    super.key,
    required this.onNext,
  });

  static const double _verticalPadding = 16.0;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: S.of(context).continueButton,
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          onPressed: onNext,
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          minimumSize: const Size(0, 44.0),
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Text(
            S.of(context).continueButton,
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

