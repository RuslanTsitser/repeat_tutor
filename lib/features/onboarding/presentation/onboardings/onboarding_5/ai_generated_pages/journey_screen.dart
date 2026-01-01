import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';

class JourneyScreen extends StatelessWidget {
  final VoidCallback onNext;

  const JourneyScreen({super.key, required this.onNext});

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
                  child: JourneyIllustration(),
                ),
                SizedBox(height: 32.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: JourneyContent(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: JourneyButton(onNext: onNext),
          ),
        ],
      ),
    );
  }
}

class JourneyIllustration extends StatelessWidget {
  const JourneyIllustration({super.key});

  static const _illustrationSize = 256.0;
  static const _mountainSize = 200.0;
  static const _sunSize = 64.0;
  static const _sunIconSize = 32.0;
  static const _pathHeight = 4.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Mountains
          Positioned(
            bottom: 0,
            child: Container(
              width: _mountainSize,
              height: _mountainSize * 0.6,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
              ),
            )
                .animate(delay: 200.ms)
                .scaleY(
                  begin: 0,
                  end: 1,
                  alignment: Alignment.bottomCenter,
                  duration: 800.ms,
                  curve: Curves.easeOut,
                )
                .fadeIn(),
          ),

          // Sun
          Positioned(
            top: 16.0,
            right: 16.0,
            child: Container(
              width: _sunSize,
              height: _sunSize,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.sun,
                color: AppColors.surface,
                size: _sunIconSize,
              ),
            )
                .animate(delay: 400.ms)
                .scale(
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                )
                .fadeIn(),
          ),

          // Path
          Positioned(
            bottom: 32.0,
            child: Container(
              width: _mountainSize * 0.8,
              height: _pathHeight,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2.0),
              ),
            )
                .animate(delay: 600.ms)
                .scaleX(
                  begin: 0,
                  end: 1,
                  duration: 1.seconds,
                  curve: Curves.easeOut,
                ),
          ),
        ],
      ),
    );
  }
}

class JourneyContent extends StatelessWidget {
  const JourneyContent({super.key});

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

class JourneyButton extends StatelessWidget {
  final VoidCallback onNext;

  const JourneyButton({
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

