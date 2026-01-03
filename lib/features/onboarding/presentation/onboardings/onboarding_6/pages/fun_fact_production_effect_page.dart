import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';
import 'onboarding_back_button_wrapper.dart';

class FunFactProductionEffectPage extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const FunFactProductionEffectPage({
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: FunFactProductionEffectIllustration(),
                  ),
                  SizedBox(height: 32.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FunFactProductionEffectContent(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FunFactProductionEffectButton(
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

class FunFactProductionEffectIllustration extends StatelessWidget {
  const FunFactProductionEffectIllustration({super.key});

  static const double _illustrationSize = 256.0;
  static const double _circleSize = 180.0;
  static const double _iconSize = 80.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
                width: _circleSize,
                height: _circleSize,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              )
              .animate()
              .scale(
                duration: 1.seconds,
                curve: Curves.easeOut,
              )
              .fadeIn(duration: 1.seconds),
          Container(
                width: _iconSize,
                height: _iconSize,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.volume2,
                  color: AppColors.surface,
                  size: 40.0,
                ),
              )
              .animate(delay: 400.ms)
              .scale(
                duration: 600.ms,
                curve: Curves.elasticOut,
              )
              .fadeIn(),
        ],
      ),
    );
  }
}

class FunFactProductionEffectContent extends StatelessWidget {
  const FunFactProductionEffectContent({super.key});

  static const double _spacing = 16.0;
  static const double _helperSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Semantics(
            label: 'Fun fact: Saying it out loud helps you remember',
            child: Text(
              'Fun fact: Saying it out loud helps you remember',
              textAlign: TextAlign.center,
              style: AppTextStyle.inter24w700.scaled(context),
            ),
          ),
        ),
        const SizedBox(height: _spacing),
        Semantics(
          label:
              'Studies show that speaking out loud can improve memory by about 10–20% compared to reading silently.',
          child: Text(
            'Studies show that speaking out loud can improve memory by about 10–20% compared to reading silently.',
            textAlign: TextAlign.start,
            style: AppTextStyle.inter16w400
                .copyWith(
                  color: AppColors.textMuted,
                )
                .scaled(context),
          ),
        ),
        const SizedBox(height: _helperSpacing),
        Semantics(
          label:
              'Your voice practice isn\'t just "practice" — it helps new phrases stick faster.',
          child: Text(
            'Your voice practice isn\'t just "practice" — it helps new phrases stick faster.',
            textAlign: TextAlign.start,
            style: AppTextStyle.inter14w400
                .copyWith(
                  color: AppColors.textMuted,
                )
                .scaled(context),
          ),
        ),
      ],
    ).animate(delay: 600.ms).moveY(begin: 16, end: 0, curve: Curves.easeOut).fadeIn();
  }
}

class FunFactProductionEffectButton extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const FunFactProductionEffectButton({
    super.key,
    required this.onNext,
    this.onPrevious,
  });

  static const double _verticalPadding = 16.0;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Nice',
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          onPressed: onNext,
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          minimumSize: const Size(0, 44.0),
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Text(
            'Nice',
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
