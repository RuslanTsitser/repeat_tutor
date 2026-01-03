import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../../../../../gen/assets.gen.dart';

class WelcomePage extends StatelessWidget {
  final VoidCallback onNext;

  const WelcomePage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WelcomeLogo(),
                SizedBox(height: 64.0),
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

class WelcomeLogo extends StatefulWidget {
  const WelcomeLogo({super.key});

  @override
  State<WelcomeLogo> createState() => _WelcomeLogoState();
}

class _WelcomeLogoState extends State<WelcomeLogo>
    with SingleTickerProviderStateMixin {
  static const double _illustrationSize = 320.0;
  static const double _logoSize = 180.0;
  static const double _smallIconSize = 64.0;
  static const double _largeIconSize = 40.0;
  static const double _orbitRadius = _illustrationSize / 2 - _smallIconSize / 2;

  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        width: _illustrationSize,
        height: _illustrationSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Assets.appIcon
                .image(
                  width: _logoSize,
                  height: _logoSize,
                )
                .animate(delay: 400.ms)
                .scale(
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                )
                .fadeIn(),
            _buildOrbitingIcon(
              LucideIcons.messageSquare,
              initialAngle: -math.pi / 2,
              delay: 200.ms,
            ),
            _buildOrbitingIcon(
              LucideIcons.mic,
              initialAngle: 0,
              delay: 400.ms,
            ),
            _buildOrbitingIcon(
              LucideIcons.bookOpen,
              initialAngle: math.pi / 2,
              delay: 600.ms,
            ),
            _buildOrbitingIcon(
              LucideIcons.star,
              initialAngle: math.pi,
              delay: 800.ms,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrbitingIcon(
    IconData icon, {
    required double initialAngle,
    required Duration delay,
  }) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        final currentAngle =
            initialAngle + _rotationController.value * 2 * math.pi;
        final x = _orbitRadius * math.cos(currentAngle);
        final y = _orbitRadius * math.sin(currentAngle);

        return Positioned(
          left: _illustrationSize / 2 + x - _smallIconSize / 2,
          top: _illustrationSize / 2 + y - _smallIconSize / 2,
          child: child!,
        );
      },
      child:
          Container(
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
                  size: _largeIconSize,
                ),
              )
              .animate(delay: delay)
              .scale(duration: 400.ms, curve: Curves.elasticOut)
              .fadeIn(),
    );
  }
}

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Semantics(
                label: s.onboarding6WelcomeTitle,
                child: Text(
                  s.onboarding6WelcomeTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.inter24w700.scaled(context),
                ),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label: s.onboarding6WelcomeSubtitle,
              child: Text(
                s.onboarding6WelcomeSubtitle,
                textAlign: TextAlign.center,
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
    final s = S.of(context);
    return Semantics(
      button: true,
      label: s.continueButton,
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          onPressed: onNext,
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          minimumSize: const Size(0, 44.0),
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Text(
            s.continueButton,
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
