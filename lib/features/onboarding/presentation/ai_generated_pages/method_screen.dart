import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MethodScreen extends StatelessWidget {
  final VoidCallback onNext;

  const MethodScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Адаптивные отступы
    final horizontalPadding = screenWidth * 0.08; // 8% от ширины экрана
    final verticalPadding = screenHeight * 0.05; // 5% от высоты экрана

    // Адаптивные размеры иллюстрации
    final illustrationSize = (screenWidth * 0.7).clamp(240.0, 300.0);
    final trackSize = illustrationSize * 0.93;
    final centerSize = illustrationSize * 0.286;
    final orbitRadius = trackSize * 0.1;

    // Адаптивные размеры шрифтов
    final titleFontSize = (screenWidth * 0.07).clamp(24.0, 30.0);
    final bodyFontSize = (screenWidth * 0.045).clamp(16.0, 20.0);
    final buttonFontSize = (screenWidth * 0.042).clamp(15.0, 19.0);
    final tagFontSize = (screenWidth * 0.03).clamp(11.0, 13.0);

    // Адаптивные размеры иконок
    final centerIconSize = centerSize * 0.4;
    final orbitItemSize = illustrationSize * 0.17;
    final orbitIconSize = orbitItemSize * 0.42;

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
                // === Method Loop Illustration ===
                SizedBox(
                  width: illustrationSize,
                  height: illustrationSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular Track (Dashed border simulation)
                      Container(
                        width: trackSize,
                        height: trackSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 2,
                          ), // Можно использовать пакет dotted_border для пунктира
                        ),
                      ),

                      // Central AI Brain
                      Transform.rotate(
                        angle: 0.785, // 45 degrees
                        child: Container(
                          width: centerSize,
                          height: centerSize,
                          decoration: BoxDecoration(
                            color: const Color(0xFF5856D6), // AppColors.indigo
                            borderRadius: BorderRadius.circular(
                              centerSize * 0.25,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF5856D6).withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Transform.rotate(
                            angle: -0.785,
                            child: Icon(
                              LucideIcons.mic,
                              color: Colors.white,
                              size: centerIconSize,
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
                        orbitRadius,
                        orbitItemSize,
                        orbitIconSize,
                      ), // Mint
                      _buildOrbitItem(
                        1,
                        LucideIcons.refreshCw,
                        const Color(0xFF007AFF),
                        orbitRadius,
                        orbitItemSize,
                        orbitIconSize,
                      ), // Blue
                      _buildOrbitItem(
                        2,
                        LucideIcons.checkCircle2,
                        Colors.purple,
                        orbitRadius,
                        orbitItemSize,
                        orbitIconSize,
                      ), // Purple
                    ],
                  ),
                ),

                SizedBox(height: largeSpacing),

                // === Text Content ===
                Column(
                      children: [
                        Text(
                          'The Repetition Loop',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'San Francisco',
                          ),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          "Listen, speak, get gentle AI feedback, and repeat. It's the natural way to fluency.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: bodyFontSize,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: spacing * 1.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTag('Personalized', tagFontSize, screenWidth),
                            SizedBox(width: screenWidth * 0.02),
                            _buildTag(
                              'Pressure-free',
                              tagFontSize,
                              screenWidth,
                            ),
                          ],
                        ),
                      ],
                    )
                    .animate(delay: 400.ms)
                    .moveY(begin: 20, end: 0, curve: Curves.easeOut)
                    .fadeIn(),
              ],
            ),
          ),

          // === Button ===
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5856D6),
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: const Color(0xFF5856D6).withOpacity(0.4),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ).animate(delay: 600.ms).moveY(begin: 20, end: 0).fadeIn(),
        ],
      ),
    );
  }

  Widget _buildOrbitItem(
    int index,
    IconData icon,
    Color color,
    double orbitRadius,
    double itemSize,
    double iconSize,
  ) {
    // Начальный угол для распределения элементов (0, 120, 240 градусов)
    double initialAngle = index * (3.14159 * 2 / 3);

    return Container(
          alignment: Alignment.topCenter, // Иконка будет на "орбите"
          child: Transform.translate(
            offset: Offset(0, -orbitRadius), // Радиус орбиты
            child: Container(
              width: itemSize,
              height: itemSize,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[200]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: iconSize),
            ),
          ),
        )
        .animate(onPlay: (c) => c.repeat())
        .rotate(
          begin: initialAngle / (2 * 3.14159),
          end: initialAngle / (2 * 3.14159) + 1,
          duration: 20.seconds,
        );
    // flutter_animate rotate принимает значения от 0.0 до 1.0 (полный оборот)
  }

  Widget _buildTag(String text, double fontSize, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.015,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
