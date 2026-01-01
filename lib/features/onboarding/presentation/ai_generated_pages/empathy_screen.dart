import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class EmpathyScreen extends StatelessWidget {
  final VoidCallback onNext;

  const EmpathyScreen({super.key, required this.onNext});

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
                  child: EmpathyIllustration(),
                ),
                SizedBox(height: 32.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: EmpathyContent(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: EmpathyButton(onNext: onNext),
          ),
        ],
      ),
    );
  }
}

class EmpathyIllustration extends StatelessWidget {
  const EmpathyIllustration({super.key});

  static const _illustrationSize = 256.0;
  static const _innerCircleSize = 120.0;
  static const _aiFigureSize = 64.0;
  static const _aiIconSize = 32.0;
  static const _userBottomOffset = 32.0;
  static const _userLeftOffset = 16.0;
  static const _aiTopOffset = 32.0;
  static const _aiRightOffset = 16.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        children: [
          // Background Blobs
          Positioned.fill(
            child:
                Container(
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundLight,
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate()
                    .scale(
                      duration: 1.seconds,
                      curve: Curves.easeOut,
                    )
                    .fadeIn(duration: 1.seconds),
          ),

          // Connection Line
          Center(
            child:
                Container(
                      width: _innerCircleSize,
                      height: _innerCircleSize,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.5),
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(delay: 800.ms)
                    .fadeIn()
                    .custom(
                      builder: (context, val, child) {
                        return child;
                      },
                    ),
          ),

          // User Figure (Hesitant)
          Positioned(
            bottom: _userBottomOffset,
            left: _userLeftOffset,
            child:
                const CharacterBox(
                      icon: LucideIcons.messageCircle,
                      bgColor: Color(0xFFE5E5EA),
                      iconColor: AppColors.textMuted,
                      showSweat: true,
                    )
                    .animate(delay: 200.ms)
                    .moveX(
                      begin: -16,
                      end: 0,
                      curve: Curves.easeOut,
                    )
                    .fadeIn(),
          ),

          // AI Figure (Supportive)
          Positioned(
            top: _aiTopOffset,
            right: _aiRightOffset,
            child:
                Container(
                      width: _aiFigureSize,
                      height: _aiFigureSize,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        LucideIcons.heartHandshake,
                        color: AppColors.surface,
                        size: _aiIconSize,
                      ),
                    )
                    .animate(delay: 400.ms)
                    .moveX(begin: 16, end: 0, curve: Curves.easeOut)
                    .fadeIn(),
          ),
        ],
      ),
    );
  }
}

class CharacterBox extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final bool showSweat;

  const CharacterBox({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    this.showSweat = false,
  });

  static const double _size = 64.0;
  static const double _iconSize = 32.0;
  static const double _borderRadius = 16.0;
  static const double _sweatSize = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, color: iconColor, size: _iconSize),
          if (showSweat)
            Positioned(
              top: 8.0,
              right: 8.0,
              child:
                  Container(
                        width: _sweatSize,
                        height: _sweatSize,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveY(begin: 0, end: 5, duration: 2.seconds)
                      .fadeIn(duration: 1.seconds)
                      .fadeOut(delay: 1.seconds, duration: 1.seconds),
            ),
        ],
      ),
    );
  }
}

class SafeSpaceTag extends StatelessWidget {
  const SafeSpaceTag({super.key});

  static const double _iconSize = 16.0;
  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 4.0;
  static const double _spacing = 8.0;
  static const double _borderRadius = 24.0; // Допустимо для больших элементов

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

class EmpathyContent extends StatelessWidget {
  const EmpathyContent({super.key});

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

class EmpathyButton extends StatelessWidget {
  final VoidCallback onNext;

  const EmpathyButton({
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
          minimumSize: const Size(0, 44.0), // Минимальный размер тач-таргета
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
