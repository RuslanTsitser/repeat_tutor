import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

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

class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({super.key});

  static const double _illustrationSize = 256.0;
  static const double _logoSize = 180.0;
  static const double _smallIconSize = 32.0;

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
                LucideIcons.bookOpen,
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
                label: 'Welcome to Repeat Tutor',
                child: Text(
                  'Welcome to Repeat Tutor',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.inter24w700.scaled(context),
                ),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label:
                  'A safe, stress-free place to practice speaking for real life',
              child: Text(
                'A safe, stress-free place to practice speaking for real life',
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
      label: 'Continue',
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          onPressed: onNext,
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          minimumSize: const Size(0, 44.0),
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Text(
            'Continue',
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
