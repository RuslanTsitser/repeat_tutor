import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/localization/generated/l10n.dart';

class ResultScreen extends StatelessWidget {
  final VoidCallback onNext;

  const ResultScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Адаптивные отступы
    final horizontalPadding = screenWidth * 0.08; // 8% от ширины экрана
    final verticalPadding = screenHeight * 0.05; // 5% от высоты экрана

    // Адаптивные размеры иллюстрации
    final illustrationWidth = (screenWidth * 0.7).clamp(240.0, 300.0);
    final illustrationHeight =
        illustrationWidth * 0.893; // Сохраняем пропорции 280:250
    final barHeight = illustrationHeight * 0.64;

    // Адаптивные размеры шрифтов
    final titleFontSize = (screenWidth * 0.07).clamp(24.0, 30.0);
    final bodyFontSize = (screenWidth * 0.045).clamp(16.0, 20.0);
    final buttonFontSize = (screenWidth * 0.042).clamp(15.0, 19.0);

    // Адаптивные размеры элементов
    final floatingIconSize = illustrationWidth * 0.14;
    final floatingIconPadding = illustrationWidth * 0.03;
    final barWidth = illustrationWidth * 0.17;
    final starIconSize = barWidth * 0.5;

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
                // === Progress Illustration ===
                SizedBox(
                  width: illustrationWidth,
                  height: illustrationHeight,
                  child: Stack(
                    children: [
                      // Floating Elements
                      Positioned(
                        top: 0,
                        right: illustrationWidth * 0.143,
                        child:
                            _buildFloatingIcon(
                                  LucideIcons.trendingUp,
                                  Colors.green,
                                  floatingIconSize,
                                  floatingIconPadding,
                                )
                                .animate(onPlay: (c) => c.repeat(reverse: true))
                                .moveY(
                                  begin: 0,
                                  end: -10,
                                  duration: 3.seconds,
                                  curve: Curves.easeInOut,
                                ),
                      ),
                      Positioned(
                        top: illustrationHeight * 0.16,
                        left: illustrationWidth * 0.057,
                        child:
                            _buildFloatingIcon(
                                  LucideIcons.sparkles,
                                  const Color(0xFF00C7BE),
                                  floatingIconSize,
                                  floatingIconPadding,
                                )
                                .animate(onPlay: (c) => c.repeat(reverse: true))
                                .moveY(
                                  begin: 0,
                                  end: 10,
                                  duration: 4.seconds,
                                  curve: Curves.easeInOut,
                                ),
                      ),

                      // Steps Graph
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: barHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildBar(
                              0.3,
                              0,
                              barWidth,
                              barHeight,
                              starIconSize,
                            ),
                            _buildBar(
                              0.5,
                              1,
                              barWidth,
                              barHeight,
                              starIconSize,
                            ),
                            _buildBar(
                              0.7,
                              2,
                              barWidth,
                              barHeight,
                              starIconSize,
                            ),
                            _buildBar(
                              1.0,
                              3,
                              barWidth,
                              barHeight,
                              starIconSize,
                              isFinal: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: largeSpacing),

                // === Text ===
                Column(
                      children: [
                        Text(
                          S.of(context).gainRealConfidence,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          S
                              .of(context)
                              .transformFromHesitantToNaturalSpeakerFeelTheProgressWith,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: bodyFontSize,
                            color: Colors.grey[600],
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
                shadowColor: const Color(0xFF5856D6).withValues(alpha: 0.4),
              ),
              child: Text(
                S.of(context).startYourJourney,
                style: TextStyle(
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ).animate(delay: 800.ms).moveY(begin: 20, end: 0).fadeIn(),
        ],
      ),
    );
  }

  Widget _buildBar(
    double heightFactor,
    int index,
    double barWidth,
    double maxHeight,
    double starIconSize, {
    bool isFinal = false,
  }) {
    return Container(
          width: barWidth,
          height: maxHeight * heightFactor, // Максимальная высота * фактор
          decoration: BoxDecoration(
            color: isFinal
                ? const Color(0xFF5856D6)
                : const Color(0xFFEFF6FF), // Indigo или LightBlue
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(barWidth * 0.25),
            ),
          ),
          child: isFinal
              ? Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: maxHeight * 0.05),
                        child: Icon(
                          LucideIcons.star,
                          color: Colors.amber,
                          size: starIconSize,
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

  Widget _buildFloatingIcon(
    IconData icon,
    Color color,
    double containerSize,
    double padding,
  ) {
    final iconSize = containerSize * 0.6;
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(containerSize * 0.15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.1), blurRadius: 10),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Icon(icon, color: color, size: iconSize),
    );
  }
}
