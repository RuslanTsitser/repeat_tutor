import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/localization/generated/l10n.dart';

// Цвета из вашего tailwind config
class AppColors {
  static const indigo = Color(0xFF5856D6);
  static const bgLight = Color(0xFFFFFFFF);
  static const textGray = Color(0xFF8E8E93);
  static const blue50 = Color(0xFFEFF6FF); // Примерный hex для blue-50
}

class EmpathyScreen extends StatelessWidget {
  final VoidCallback onNext;

  const EmpathyScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0,
      ),
      child: Column(
        children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmpathyIllustration(),
                SizedBox(height: 32.0),
                EmpathyContent(),
              ],
            ),
          ),
          EmpathyButton(onNext: onNext),
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
              top: 16.0,
              right: 16.0,
              child:
                  Container(
                        width: _sweatSize,
                        height: _sweatSize,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
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

class EmpathyIllustration extends StatelessWidget {
  const EmpathyIllustration({super.key});

  static const double _illustrationSize = 256.0;
  static const double _innerCircleSize = 128.0;
  static const double _aiFigureSize = 64.0;
  static const double _aiIconSize = 32.0;
  static const double _userBottomOffset = 32.0;
  static const double _userLeftOffset = 16.0;
  static const double _aiTopOffset = 32.0;
  static const double _aiRightOffset = 16.0;

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
                        color: AppColors.blue50,
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
                          color: AppColors.indigo.withValues(alpha: 0.5),
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
                      iconColor: Colors.grey,
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
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.indigo,
                            Colors.purpleAccent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.indigo.withValues(alpha: 0.2),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        LucideIcons.heartHandshake,
                        color: Colors.white,
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

class SafeSpaceTag extends StatelessWidget {
  const SafeSpaceTag({super.key});

  static const double _iconSize = 16.0;
  static const double _fontSize = 16.0;
  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 4.0;
  static const double _spacing = 8.0;
  static const double _borderRadius = 24.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.blue50,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            LucideIcons.shieldCheck,
            size: _iconSize,
            color: AppColors.indigo,
          ),
          const SizedBox(width: _spacing),
          Text(
            S.of(context).safeSpace,
            style: const TextStyle(
              color: AppColors.indigo,
              fontWeight: FontWeight.w600,
              fontSize: _fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

class EmpathyContent extends StatelessWidget {
  const EmpathyContent({super.key});

  static const double _bodyFontSize = 16.0;
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
            Text(
              S.of(context).practiceWithoutJudgmentMakeMistakesLearnAndGrowInA,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: _bodyFontSize,
                color: AppColors.textGray,
                height: 1.5,
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

  static const double _fontSize = 16.0;
  static const double _verticalPadding = 16.0;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.indigo,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          shadowColor: AppColors.indigo.withValues(alpha: 0.5),
          elevation: 0,
        ),
        child: Text(
          S.of(context).continueButton,
          style: const TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    ).animate(delay: 1000.ms).moveY(begin: 16, end: 0).fadeIn();
  }
}
