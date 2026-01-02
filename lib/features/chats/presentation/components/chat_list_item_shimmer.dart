import 'package:flutter/cupertino.dart';

import '../../../../core/theme/app_colors.dart';

class ChatListItemShimmer extends StatelessWidget {
  const ChatListItemShimmer({super.key});

  static const double _padding = 16.0;
  static const double _borderRadius = 16.0;
  static const double _spacing = 4.0;
  static const double _badgeHeight = 20.0;
  // Ширина баджа: padding (8*2=16) + примерная ширина текста
  // Для языка: самый длинный "Português (Europa)" ~18 символов * 6.5px ≈ 117px + 16px = 133px
  // Для уровня: "A1" ~2 символа * 6.5px ≈ 13px + 16px = 29px
  // Используем средние значения для более реалистичного вида
  static const double _badgeLanguageWidth = 80.0;
  static const double _badgeLevelWidth = 32.0;
  static const double _titleHeight = 20.0;
  static const double _titleWidth = 200.0;
  static const double _messageHeight = 16.0;
  static const double _messageWidth = 150.0;
  static const double _badgeSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
          color: AppColors.divider,
          width: 1,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: _spacing,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ShimmerBox(
                  width: _titleWidth,
                  height: _titleHeight,
                ),
              ),
              SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: _badgeSpacing,
                children: [
                  _ShimmerBox(
                    width: _badgeLanguageWidth,
                    height: _badgeHeight,
                    borderRadius: 8.0,
                  ),
                  _ShimmerBox(
                    width: _badgeLevelWidth,
                    height: _badgeHeight,
                    borderRadius: 8.0,
                  ),
                ],
              ),
            ],
          ),
          _ShimmerBox(
            width: _messageWidth,
            height: _messageHeight,
          ),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatefulWidget {
  const _ShimmerBox({
    required this.width,
    required this.height,
    this.borderRadius = 4.0,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1.0 - _controller.value * 2, 0),
              end: Alignment(1.0 - _controller.value * 2, 0),
              colors: const [
                AppColors.divider,
                AppColors.backgroundLight,
                AppColors.divider,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}
