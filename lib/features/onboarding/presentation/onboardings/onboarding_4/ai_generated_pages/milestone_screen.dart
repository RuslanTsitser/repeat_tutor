import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';

class MilestoneScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const MilestoneScreen({
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
            child: MilestoneBackButton(onPrevious: onPrevious!),
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
                        child: MilestoneIllustration(),
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: MilestoneContent(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MilestoneButton(onNext: onNext),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MilestoneIllustration extends StatelessWidget {
  const MilestoneIllustration({super.key});

  static const double _illustrationSize = 256.0;
  static const double _pathWidth = 180.0;
  static const double _pathHeight = 4.0;
  static const double _milestoneSize = 40.0;
  static const double _milestoneIconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Path
          Container(
            width: _pathWidth,
            height: _pathHeight,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.0),
            ),
          )
              .animate()
              .scaleX(
                begin: 0,
                end: 1,
                duration: 1.seconds,
                curve: Curves.easeOut,
              ),

          // Milestones
          Positioned(
            left: 32.0,
            child: _buildMilestone(
              LucideIcons.circle,
              0,
              delay: 300.ms,
            ),
          ),
          Positioned(
            left: 88.0,
            child: _buildMilestone(
              LucideIcons.circle,
              1,
              delay: 500.ms,
            ),
          ),
          Positioned(
            right: 88.0,
            child: _buildMilestone(
              LucideIcons.circle,
              2,
              delay: 700.ms,
            ),
          ),
          Positioned(
            right: 32.0,
            child: _buildMilestone(
              LucideIcons.checkCircle2,
              3,
              isActive: true,
              delay: 900.ms,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestone(
    IconData icon,
    int index, {
    bool isActive = false,
    Duration delay = Duration.zero,
  }) {
    return Container(
      width: _milestoneSize,
      height: _milestoneSize,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Icon(
        icon,
        color: isActive ? AppColors.surface : AppColors.primary,
        size: _milestoneIconSize,
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

class MilestoneContent extends StatelessWidget {
  const MilestoneContent({super.key});

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

class MilestoneBackButton extends StatelessWidget {
  final VoidCallback onPrevious;

  const MilestoneBackButton({
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

class MilestoneButton extends StatelessWidget {
  final VoidCallback onNext;

  const MilestoneButton({
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

