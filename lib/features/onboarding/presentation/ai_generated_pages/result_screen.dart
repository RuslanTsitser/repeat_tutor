import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class ResultScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const ResultScreen({
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
            child: ResultBackButton(onPrevious: onPrevious!),
          ),
          const SizedBox(height: 16.0),
        ],
        Expanded(
          child: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: ResultIllustration(),
                      ),
                      SizedBox(height: 32.0),
                      ResultContent(),
                    ],
                  ),
                ),

                ResultButton(onNext: onNext),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ResultIllustration extends StatelessWidget {
  const ResultIllustration({super.key});

  static const double _illustrationWidth = 256.0;
  static const double _illustrationHeight = 229.0;
  static const double _barHeight = 147.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationWidth,
      height: _illustrationHeight,
      child: Stack(
        children: [
          // Floating Elements
          Positioned(
            top: 0,
            right: 37.0,
            child:
                const FloatingIcon(
                      icon: LucideIcons.trendingUp,
                      color: Colors.green,
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(
                      begin: 0,
                      end: -8,
                      duration: 3.seconds,
                      curve: Curves.easeInOut,
                    ),
          ),
          Positioned(
            top: 37.0,
            left: 15.0,
            child:
                const FloatingIcon(
                      icon: LucideIcons.sparkles,
                      color: Color(0xFF00C7BE),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(
                      begin: 0,
                      end: 8,
                      duration: 4.seconds,
                      curve: Curves.easeInOut,
                    ),
          ),

          // Steps Graph
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: _barHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ProgressBar(
                  heightFactor: 0.3,
                  index: 0,
                ),
                ProgressBar(
                  heightFactor: 0.5,
                  index: 1,
                ),
                ProgressBar(
                  heightFactor: 0.7,
                  index: 2,
                ),
                ProgressBar(
                  heightFactor: 1.0,
                  index: 3,
                  isFinal: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const FloatingIcon({
    super.key,
    required this.icon,
    required this.color,
  });

  static const double _padding = 8.0;
  static const double _borderRadius = 5.0;
  static const double _iconSize = 22.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: AppColors.colorFFFFFFFF,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorFF8E8E93.withValues(alpha: 0.1),
            blurRadius: 16,
          ),
        ],
        border: Border.all(
          color: AppColors.colorFF8E8E93.withValues(alpha: 0.1),
        ),
      ),
      child: Icon(icon, color: color, size: _iconSize),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final double heightFactor;
  final int index;
  final bool isFinal;

  const ProgressBar({
    super.key,
    required this.heightFactor,
    required this.index,
    this.isFinal = false,
  });

  static const double _barWidth = 44.0;
  static const double _maxHeight = 147.0;
  static const double _starIconSize = 22.0;
  static const double _barBorderRadius = 11.0;
  static const double _starTopPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: _barWidth,
          height: _maxHeight * heightFactor,
          decoration: BoxDecoration(
            color: isFinal ? AppColors.colorFF5856D6 : AppColors.colorFFEFF6FF,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(_barBorderRadius),
            ),
          ),
          child: isFinal
              ? const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: _starTopPadding),
                        child: Icon(
                          LucideIcons.star,
                          color: Colors.amber,
                          size: _starIconSize,
                        ),
                      ),
                    )
                    .animate(delay: 1.seconds)
                    .scale(duration: 400.ms, curve: Curves.elasticOut)
              : null,
        )
        .animate(delay: (300 + index * 250).ms)
        .scaleY(
          begin: 0,
          end: 1,
          alignment: Alignment.bottomCenter,
          duration: 1000.ms,
          curve: Curves.elasticOut,
        );
  }
}

class ResultContent extends StatelessWidget {
  const ResultContent({super.key});

  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                textAlign: TextAlign.center,
                style: AppTextStyle.inter16w400
                    .copyWith(
                      color: AppColors.colorFF8E8E93,
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

class ResultBackButton extends StatelessWidget {
  final VoidCallback onPrevious;

  const ResultBackButton({
    super.key,
    required this.onPrevious,
  });

  static const double _iconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Back',
      child: Align(
        alignment: Alignment.centerLeft,
        child: CupertinoButton(
          onPressed: onPrevious,
          padding: EdgeInsets.zero,
          minimumSize: const Size(44.0, 44.0),
          child: const Icon(
            LucideIcons.chevronLeft,
            size: _iconSize,
            color: AppColors.colorFF5856D6,
          ),
        ),
      ),
    );
  }
}

class ResultButton extends StatelessWidget {
  final VoidCallback onNext;

  const ResultButton({
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
          color: AppColors.colorFF5856D6,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          minimumSize: const Size(0, 44.0),
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Text(
            S.of(context).startYourJourney,
            style: AppTextStyle.inter16w600
                .copyWith(
                  color: AppColors.colorFFFFFFFF,
                )
                .scaled(context),
          ),
        ),
      ),
    ).animate(delay: 800.ms).moveY(begin: 16, end: 0).fadeIn();
  }
}
