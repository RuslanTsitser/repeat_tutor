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
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Адаптивные отступы
    final horizontalPadding = screenWidth * 0.08; // 8% от ширины экрана
    final verticalPadding = screenHeight * 0.05; // 5% от высоты экрана

    // Адаптивные размеры иллюстрации
    final illustrationSize = (screenWidth * 0.65).clamp(200.0, 280.0);
    final innerCircleSize = illustrationSize * 0.6;

    // Адаптивные размеры элементов
    final aiFigureSize = illustrationSize * 0.375;
    final characterBoxSize = illustrationSize * 0.3125;

    // Адаптивные размеры шрифтов
    final titleFontSize = (screenWidth * 0.075).clamp(24.0, 32.0);
    final bodyFontSize = (screenWidth * 0.045).clamp(16.0, 20.0);
    final buttonFontSize = (screenWidth * 0.042).clamp(15.0, 19.0);
    final tagFontSize = (screenWidth * 0.03).clamp(11.0, 13.0);

    // Адаптивные размеры иконок
    final aiIconSize = aiFigureSize * 0.42;
    final characterIconSize = characterBoxSize * 0.4;
    final tagIconSize = tagFontSize;

    // Адаптивные отступы между элементами
    final spacing = screenHeight * 0.02;
    final largeSpacing = screenHeight * 0.04;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // === Abstract Illustration Area ===
                SizedBox(
                  width: illustrationSize,
                  height: illustrationSize,
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
                                .animate() // Аналог initial/animate из Framer
                                .scale(
                                  duration: 1.seconds,
                                  curve: Curves.easeOut,
                                )
                                .fadeIn(duration: 1.seconds),
                      ),

                      // Connection Line (SVG Path аналог - CustomPaint)
                      // Для простоты используем пунктирную линию или иконку
                      Center(
                        child:
                            Container(
                                  width: innerCircleSize,
                                  height: innerCircleSize,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.indigo.withValues(
                                        alpha: 0.5,
                                      ),
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
                                    // Тут можно рисовать path анимацию через CustomPainter
                                    return child;
                                  },
                                ),
                      ),

                      // User Figure (Hesitant)
                      Positioned(
                        bottom: illustrationSize * 0.156,
                        left: illustrationSize * 0.0625,
                        child:
                            _buildCharacterBox(
                                  icon: LucideIcons
                                      .messageCircle, // Fixed undefined 'messageCircleOff'
                                  bgColor: Colors.grey[200]!,
                                  iconColor: Colors.grey,
                                  showSweat: true,
                                  size: characterBoxSize,
                                  iconSize: characterIconSize,
                                )
                                .animate(
                                  delay: 200.ms,
                                ) // transition={{ delay: 0.2 }}
                                .moveX(
                                  begin: -20,
                                  end: 0,
                                  curve: Curves.easeOut,
                                )
                                .fadeIn(),
                      ),

                      // AI Figure (Supportive)
                      Positioned(
                        top: illustrationSize * 0.156,
                        right: illustrationSize * 0.0625,
                        child:
                            Container(
                                  width: aiFigureSize,
                                  height: aiFigureSize,
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
                                        color: AppColors.indigo.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    LucideIcons.heartHandshake,
                                    color: Colors.white,
                                    size: aiIconSize,
                                  ),
                                )
                                .animate(delay: 400.ms)
                                .moveX(begin: 20, end: 0, curve: Curves.easeOut)
                                .fadeIn(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: largeSpacing),

                // === Text Content ===
                Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.005,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blue50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LucideIcons.shieldCheck,
                                size: tagIconSize,
                                color: AppColors.indigo,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                S.of(context).safeSpace,
                                style: TextStyle(
                                  color: AppColors.indigo,
                                  fontWeight: FontWeight.w600,
                                  fontSize: tagFontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spacing),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: titleFontSize,
                              color: Colors.black,
                              height: 1.1,
                              fontFamily: 'SF Pro Text',
                            ),
                            children: [
                              TextSpan(
                                text: S.of(context).scaredToSpeak,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: S.of(context).thatsTotallyNormal,
                                style: const TextStyle(
                                  color: AppColors.textGray,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          S
                              .of(context)
                              .practiceWithoutJudgmentMakeMistakesLearnAndGrowInA,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: bodyFontSize,
                            color: AppColors.textGray,
                            height: 1.5,
                          ),
                        ),
                      ],
                    )
                    .animate(delay: 600.ms)
                    .moveY(begin: 20, end: 0, curve: Curves.easeOut)
                    .fadeIn(),
              ],
            ),
          ),

          // === Bottom Button ===
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.indigo,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: AppColors.indigo.withValues(alpha: 0.5),
                elevation: 8,
              ),
              child: Text(
                S.of(context).continueButton,
                style: TextStyle(
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ).animate(delay: 1000.ms).moveY(begin: 20, end: 0).fadeIn(),
        ],
      ),
    );
  }

  Widget _buildCharacterBox({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    required double size,
    required double iconSize,
    bool showSweat = false,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(size * 0.2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, color: iconColor, size: iconSize),
          if (showSweat)
            Positioned(
              top: size * 0.2,
              right: size * 0.2,
              child:
                  Container(
                        width: size * 0.075,
                        height: size * 0.075,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat()) // repeat: Infinity
                      .moveY(begin: 0, end: 5, duration: 2.seconds)
                      .fadeIn(duration: 1.seconds)
                      .fadeOut(delay: 1.seconds, duration: 1.seconds),
            ),
        ],
      ),
    );
  }
}
