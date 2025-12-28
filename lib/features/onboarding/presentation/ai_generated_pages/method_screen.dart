import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MethodScreen extends StatelessWidget {
  final VoidCallback onNext;

  const MethodScreen({super.key, required this.onNext});

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
                // === Method Loop Illustration ===
                SizedBox(
                  width: 280,
                  height: 280,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular Track (Dashed border simulation)
                      Container(
                        width: 260,
                        height: 260,
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
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFF5856D6), // AppColors.indigo
                            borderRadius: BorderRadius.circular(20),
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
                            child: const Icon(
                              LucideIcons.mic,
                              color: Colors.white,
                              size: 32,
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
                      ), // Mint
                      _buildOrbitItem(
                        1,
                        LucideIcons.refreshCw,
                        const Color(0xFF007AFF),
                      ), // Blue
                      _buildOrbitItem(
                        2,
                        LucideIcons.checkCircle2,
                        Colors.purple,
                      ), // Purple
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // === Text Content ===
                Column(
                      children: [
                        const Text(
                          'The Repetition Loop',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'San Francisco',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Listen, speak, get gentle AI feedback, and repeat. It's the natural way to fluency.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTag('Personalized'),
                            const SizedBox(width: 8),
                            _buildTag('Pressure-free'),
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
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: const Color(0xFF5856D6).withOpacity(0.4),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 17,
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

  Widget _buildOrbitItem(int index, IconData icon, Color color) {
    // Начальный угол для распределения элементов (0, 120, 240 градусов)
    double initialAngle = index * (3.14159 * 2 / 3);

    return Container(
          alignment: Alignment.topCenter, // Иконка будет на "орбите"
          child: Transform.translate(
            offset: const Offset(0, -130), // Радиус орбиты (половина от 260)
            child: Container(
              width: 48,
              height: 48,
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
              child: Icon(icon, color: color, size: 20),
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

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
