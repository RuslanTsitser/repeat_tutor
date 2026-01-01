import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class MethodScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const MethodScreen({
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
            child: MethodBackButton(onPrevious: onPrevious!),
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
                        child: MethodIllustration(),
                      ),
                      SizedBox(height: 32.0),
                      MethodContent(),
                    ],
                  ),
                ),

                MethodButton(onNext: onNext),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MethodIllustration extends StatelessWidget {
  const MethodIllustration({super.key});

  static const double _illustrationSize = 256.0;
  static const double _trackSize = 238.0;
  static const double _centerSize = 73.0;
  static const double _orbitRadius = 24.0;
  static const double _orbitItemSize = 44.0;
  static const double _orbitIconSize = 18.0;
  static const double _centerIconSize = 29.0;
  static const double _borderRadius = 18.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _illustrationSize,
      height: _illustrationSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Track
          Container(
            width: _trackSize,
            height: _trackSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.colorFF8E8E93.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
          ),

          // Central AI Brain
          Transform.rotate(
            angle: 0.785, // 45 degrees
            child: Container(
              width: _centerSize,
              height: _centerSize,
              decoration: BoxDecoration(
                color: AppColors.colorFF5856D6,
                borderRadius: BorderRadius.circular(_borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorFF5856D6.withValues(alpha: 0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Transform.rotate(
                angle: -0.785,
                child: const Icon(
                  LucideIcons.mic,
                  color: AppColors.colorFFFFFFFF,
                  size: _centerIconSize,
                ),
              ),
            ),
          ).animate().scale(
            duration: 600.ms,
            curve: Curves.elasticOut,
          ),

          // Orbiting Elements
          _buildOrbitItem(
            0,
            LucideIcons.ear,
            const Color(0xFF00C7BE),
          ),
          _buildOrbitItem(
            1,
            LucideIcons.refreshCw,
            const Color(0xFF007AFF),
          ),
          _buildOrbitItem(
            2,
            LucideIcons.checkCircle2,
            AppColors.colorFF5856D6,
          ),
        ],
      ),
    );
  }

  Widget _buildOrbitItem(int index, IconData icon, Color color) {
    // Начальный угол для распределения элементов (0, 120, 240 градусов)
    final initialAngle = index * (3.14159 * 2 / 3);

    return Container(
          alignment: Alignment.topCenter,
          child: Transform.translate(
            offset: const Offset(0, -_orbitRadius),
            child: Container(
              width: _orbitItemSize,
              height: _orbitItemSize,
              decoration: BoxDecoration(
                color: AppColors.colorFFFFFFFF,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.colorFF8E8E93.withValues(alpha: 0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorFFFFFFFF.withValues(alpha: 0.05),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: _orbitIconSize),
            ),
          ),
        )
        .animate(onPlay: (c) => c.repeat())
        .rotate(
          begin: initialAngle / (2 * 3.14159),
          end: initialAngle / (2 * 3.14159) + 1,
          duration: 20.seconds,
        );
  }
}

class MethodContent extends StatelessWidget {
  const MethodContent({super.key});

  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Semantics(
              label: S.of(context).theRepetitionLoop,
              child: Text(
                S.of(context).theRepetitionLoop,
                textAlign: TextAlign.center,
                style: AppTextStyle.inter24w700.scaled(context),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label: S
                  .of(context)
                  .listenSpeakGetGentleAiFeedbackAndRepeatItsThe,
              child: Text(
                S.of(context).listenSpeakGetGentleAiFeedbackAndRepeatItsThe,
                textAlign: TextAlign.center,
                style: AppTextStyle.inter16w400
                    .copyWith(
                      color: AppColors.colorFF8E8E93,
                    )
                    .scaled(context),
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MethodTag(text: S.of(context).personalized),
                const SizedBox(width: 8.0),
                MethodTag(text: S.of(context).pressureFree),
              ],
            ),
          ],
        )
        .animate(delay: 400.ms)
        .moveY(begin: 16, end: 0, curve: Curves.easeOut)
        .fadeIn();
  }
}

class MethodTag extends StatelessWidget {
  final String text;

  const MethodTag({
    super.key,
    required this.text,
  });

  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 8.0;
  static const double _borderRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: _verticalPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.colorFFEFF6FF,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Text(
          text,
          style: AppTextStyle.inter12w600
              .copyWith(
                color: AppColors.colorFF8E8E93,
              )
              .scaled(context),
        ),
      ),
    );
  }
}

class MethodBackButton extends StatelessWidget {
  final VoidCallback onPrevious;

  const MethodBackButton({
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

class MethodButton extends StatelessWidget {
  final VoidCallback onNext;

  const MethodButton({
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
          color: AppColors.colorFF5856D6,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          minimumSize: const Size(0, 44.0),
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Text(
            S.of(context).nextButton,
            style: AppTextStyle.inter16w600
                .copyWith(
                  color: AppColors.colorFFFFFFFF,
                )
                .scaled(context),
          ),
        ),
      ),
    ).animate(delay: 600.ms).moveY(begin: 16, end: 0).fadeIn();
  }
}
