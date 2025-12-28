import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ResultScreen extends StatelessWidget {
  final VoidCallback onNext;

  const ResultScreen({super.key, required this.onNext});

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
                // === Progress Illustration ===
                SizedBox(
                  width: 280,
                  height: 250,
                  child: Stack(
                    children: [
                      // Floating Elements
                      Positioned(
                        top: 0,
                        right: 40,
                        child:
                            _buildFloatingIcon(
                                  LucideIcons.trendingUp,
                                  Colors.green,
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
                        top: 40,
                        left: 16,
                        child:
                            _buildFloatingIcon(
                                  LucideIcons.sparkles,
                                  const Color(0xFF00C7BE),
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
                        height: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildBar(0.3, 0),
                            _buildBar(0.5, 1),
                            _buildBar(0.7, 2),
                            _buildBar(1.0, 3, isFinal: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // === Text ===
                Column(
                      children: [
                        const Text(
                          'Gain Real Confidence',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Transform from hesitant to natural speaker. Feel the progress with every session.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
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
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: const Color(0xFF5856D6).withOpacity(0.4),
              ),
              child: const Text(
                'Start Your Journey',
                style: TextStyle(
                  fontSize: 17,
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

  Widget _buildBar(double heightFactor, int index, {bool isFinal = false}) {
    return Container(
          width: 48,
          height: 160 * heightFactor, // Максимальная высота * фактор
          decoration: BoxDecoration(
            color: isFinal
                ? const Color(0xFF5856D6)
                : const Color(0xFFEFF6FF), // Indigo или LightBlue
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: isFinal
              ? const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0), // Отступ для звезды
                        child: Icon(
                          LucideIcons.star,
                          color: Colors.amber,
                          size: 24,
                        ),
                      ),
                    )
                    .animate(delay: 1.seconds)
                    .scale(duration: 400.ms, curve: Curves.elasticOut)
              : null,
        )
        .animate(delay: (200 + index * 150).ms)
        .scaleY(
          begin: 0,
          end: 1,
          alignment: Alignment.bottomCenter,
          duration: 600.ms,
          curve: Curves.elasticOut,
        );
  }

  Widget _buildFloatingIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}
