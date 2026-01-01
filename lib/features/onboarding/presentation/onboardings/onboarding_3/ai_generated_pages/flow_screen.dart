import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';

class FlowScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const FlowScreen({
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
            child: FlowBackButton(onPrevious: onPrevious!),
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
                        child: FlowIllustration(),
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: FlowContent(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FlowButton(onNext: onNext),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FlowIllustration extends StatelessWidget {
  const FlowIllustration({super.key});

  static const double _illustrationSize = 256.0;
  static const double _lineWidth = 200.0;
  static const double _lineHeight = 4.0;
  static const double _nodeSize = 48.0;
  static const double _nodeIconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Flow Line
          Container(
            width: _lineWidth,
            height: _lineHeight,
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

          // Nodes
          Positioned(
            left: 32.0,
            child: _buildNode(
              LucideIcons.ear,
              delay: 300.ms,
            ),
          ),
          Positioned(
            left: 104.0,
            child: _buildNode(
              LucideIcons.mic,
              delay: 500.ms,
            ),
          ),
          Positioned(
            right: 104.0,
            child: _buildNode(
              LucideIcons.messageSquare,
              delay: 700.ms,
            ),
          ),
          Positioned(
            right: 32.0,
            child: _buildNode(
              LucideIcons.refreshCw,
              delay: 900.ms,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNode(IconData icon, {Duration delay = Duration.zero}) {
    return Container(
      width: _nodeSize,
      height: _nodeSize,
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
        size: _nodeIconSize,
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

class FlowContent extends StatelessWidget {
  const FlowContent({super.key});

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

class FlowBackButton extends StatelessWidget {
  final VoidCallback onPrevious;

  const FlowBackButton({
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

class FlowButton extends StatelessWidget {
  final VoidCallback onNext;

  const FlowButton({
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

