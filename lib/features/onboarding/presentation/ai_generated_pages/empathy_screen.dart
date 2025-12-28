import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // === Abstract Illustration Area ===
                SizedBox(
                  width: 256,
                  height: 256,
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
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.indigo.withOpacity(0.5),
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
                        bottom: 40,
                        left: 16,
                        child:
                            _buildCharacterBox(
                                  icon: LucideIcons
                                      .messageCircle, // Fixed undefined 'messageCircleOff'
                                  bgColor: Colors.grey[200]!,
                                  iconColor: Colors.grey,
                                  showSweat: true,
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
                        top: 40,
                        right: 16,
                        child:
                            Container(
                                  width: 96,
                                  height: 96,
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
                                        color: AppColors.indigo.withOpacity(
                                          0.2,
                                        ),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    LucideIcons.heartHandshake,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                )
                                .animate(delay: 400.ms)
                                .moveX(begin: 20, end: 0, curve: Curves.easeOut)
                                .fadeIn(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // === Text Content ===
                Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blue50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LucideIcons.shieldCheck,
                                size: 12,
                                color: AppColors.indigo,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Safe Space',
                                style: TextStyle(
                                  color: AppColors.indigo,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              height: 1.1,
                              fontFamily: 'San Francisco',
                            ),
                            children: [
                              TextSpan(
                                text: 'Scared to speak?\n',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: "That's totally normal.",
                                style: TextStyle(
                                  color: AppColors.textGray,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Practice without judgment. Make mistakes, learn, and grow in a private space designed for you.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
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
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: AppColors.indigo.withOpacity(0.5),
                elevation: 8,
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 17,
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
    bool showSweat = false,
  }) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, color: iconColor, size: 32),
          if (showSweat)
            Positioned(
              top: 16,
              right: 16,
              child:
                  Container(
                        width: 6,
                        height: 6,
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
