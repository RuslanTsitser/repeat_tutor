import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onNext;

  const WelcomeScreen({super.key, required this.onNext});

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
                  child: WelcomeIllustration(),
                ),
                SizedBox(height: 32.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: WelcomeContent(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: WelcomeButton(onNext: onNext),
          ),
        ],
      ),
    );
  }
}

class WelcomeIllustration extends StatelessWidget {
  const WelcomeIllustration({super.key});

  static const _illustrationSize = 256.0;
  static const _circleSize = 180.0;
  static const _iconSize = 80.0;
  static const _smallIconSize = 32.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main Circle
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

          // Central Icon
          Container(
                width: _iconSize,
                height: _iconSize,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.globe,
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

          // Small Icons around
          Positioned(
            top: 0,
            child: _buildSmallIcon(
              LucideIcons.messageSquare,
              delay: 200.ms,
            ),
          ),
          Positioned(
            right: 0,
            child: _buildSmallIcon(
              LucideIcons.mic,
              delay: 400.ms,
            ),
          ),
          Positioned(
            bottom: 0,
            child: _buildSmallIcon(
              LucideIcons.heart,
              delay: 600.ms,
            ),
          ),
          Positioned(
            left: 0,
            child: _buildSmallIcon(
              LucideIcons.star,
              delay: 800.ms,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallIcon(IconData icon, {Duration delay = Duration.zero}) {
    return Container(
          width: _smallIconSize,
          height: _smallIconSize,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
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
            size: 16.0,
          ),
        )
        .animate(delay: delay)
        .scale(duration: 400.ms, curve: Curves.elasticOut)
        .fadeIn();
  }
}

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Semantics(
                label: S.of(context).hello,
                child: Text(
                  S.of(context).hello,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.inter24w700.scaled(context),
                ),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label: S
                  .of(context)
                  .startYourFirstConversationAndBeginPracticingANewLanguage,
              child: Text(
                S
                    .of(context)
                    .startYourFirstConversationAndBeginPracticingANewLanguage,
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

class WelcomeButton extends StatelessWidget {
  final VoidCallback onNext;

  const WelcomeButton({
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
