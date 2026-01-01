import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';

class AchievementScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const AchievementScreen({
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
            child: AchievementBackButton(onPrevious: onPrevious!),
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
                        child: AchievementIllustration(),
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: AchievementContent(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AchievementButton(onNext: onNext),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AchievementIllustration extends StatelessWidget {
  const AchievementIllustration({super.key});

  static const double _illustrationSize = 256.0;
  static const double _trophySize = 120.0;
  static const double _trophyIconSize = 64.0;
  static const double _badgeSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Trophy Background
          Container(
            width: _trophySize,
            height: _trophySize,
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

          // Trophy Icon
          const Icon(
            LucideIcons.trophy,
            color: AppColors.primary,
            size: _trophyIconSize,
          )
              .animate(delay: 400.ms)
              .scale(
                duration: 600.ms,
                curve: Curves.elasticOut,
              )
              .fadeIn(),

          // Badges
          Positioned(
            top: 24.0,
            left: 24.0,
            child: _buildBadge(
              LucideIcons.checkCircle2,
              delay: 200.ms,
            ),
          ),
          Positioned(
            top: 24.0,
            right: 24.0,
            child: _buildBadge(
              LucideIcons.star,
              delay: 400.ms,
            ),
          ),
          Positioned(
            bottom: 24.0,
            left: 24.0,
            child: _buildBadge(
              LucideIcons.award,
              delay: 600.ms,
            ),
          ),
          Positioned(
            bottom: 24.0,
            right: 24.0,
            child: _buildBadge(
              LucideIcons.medal,
              delay: 800.ms,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, {Duration delay = Duration.zero}) {
    return Container(
      width: _badgeSize,
      height: _badgeSize,
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
        size: 20.0,
      ),
    )
        .animate(delay: delay)
        .scale(duration: 400.ms, curve: Curves.elasticOut)
        .fadeIn();
  }
}

class AchievementContent extends StatelessWidget {
  const AchievementContent({super.key});

  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: S.of(context).gainRealConfidence,
              child: Text(
                S.of(context).gainRealConfidence,
                textAlign: TextAlign.center,
                style: AppTextStyle.inter24w700.scaled(context),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label: S
                  .of(context)
                  .transformFromHesitantToNaturalSpeakerFeelTheProgressWith,
              child: Text(
                S
                    .of(context)
                    .transformFromHesitantToNaturalSpeakerFeelTheProgressWith,
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

class AchievementBackButton extends StatelessWidget {
  final VoidCallback onPrevious;

  const AchievementBackButton({
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

class AchievementButton extends StatelessWidget {
  final VoidCallback onNext;

  const AchievementButton({
    super.key,
    required this.onNext,
  });

  static const double _verticalPadding = 16.0;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: S.of(context).startYourJourney,
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          onPressed: onNext,
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          minimumSize: const Size(0, 44.0),
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Text(
            S.of(context).startYourJourney,
            style: AppTextStyle.inter16w600
                .copyWith(
                  color: AppColors.surface,
                )
                .scaled(context),
          ),
        ),
      ),
    ).animate(delay: 800.ms).moveY(begin: 16, end: 0).fadeIn();
  }
}

