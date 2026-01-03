import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';
import 'onboarding_back_button_wrapper.dart';

class RealLifeTopicsPage extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const RealLifeTopicsPage({
    super.key,
    required this.onNext,
    this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingBackButtonWrapper(
      onPrevious: onPrevious,
      child: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RealLifeTopicsIllustration(),
                  ),
                  SizedBox(height: 32.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RealLifeTopicsContent(),
                    ),
                  ),
                  SizedBox(height: 32.0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RealLifeTopicsButton(
                onNext: onNext,
                onPrevious: onPrevious,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RealLifeTopicsIllustration extends StatefulWidget {
  const RealLifeTopicsIllustration({super.key});

  @override
  State<RealLifeTopicsIllustration> createState() =>
      _RealLifeTopicsIllustrationState();
}

class _RealLifeTopicsIllustrationState
    extends State<RealLifeTopicsIllustration> {
  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;
  double _scrollPosition = 0.0;

  List<String> _getTopics(BuildContext context) {
    final s = S.of(context);
    return [
      s.topicTravel,
      s.topicFood,
      s.topicSports,
      s.topicMusic,
      s.topicMovies,
      s.topicBooks,
      s.topicTechnology,
      s.topicArt,
      s.topicFashion,
      s.topicNature,
      s.topicCooking,
      s.topicPhotography,
      s.topicFitness,
      s.topicGaming,
      s.topicHistory,
      s.topicScience,
      s.topicBusiness,
      s.topicEducation,
      s.topicHealth,
      s.topicCulture,
      s.topicPolitics,
      s.topicEconomy,
      s.topicEntertainment,
      s.topicLifestyle,
    ];
  }

  static const double _verticalSpacing = 8.0;
  static const double _horizontalSpacing = 8.0;
  static const double _brickOffset = 60.0;
  static const double _scrollSpeed = 0.3; // пикселей за кадр
  static const double _fadeZoneHeight = 64.0; // высота зоны fade

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(
      const Duration(milliseconds: 16), // ~60 FPS
      (timer) {
        if (!mounted || !_scrollController.hasClients) return;

        setState(() {
          _scrollPosition += _scrollSpeed;
          final maxScroll = _scrollController.position.maxScrollExtent;

          // Бесконечный скролл: когда доходим до конца, возвращаемся к началу
          // Используем модуль для плавного перехода
          if (_scrollPosition >= maxScroll) {
            _scrollPosition = _scrollPosition % maxScroll;
          }

          _scrollController.jumpTo(_scrollPosition);
        });
      },
    );
  }

  List<List<String>> _buildRows(BuildContext context) {
    final topics = _getTopics(context);
    final rows = <List<String>>[];
    for (int i = 0; i < 5; i++) {
      final startIndex = i * 4;
      final endIndex = (i + 1) * 4;
      if (startIndex < topics.length) {
        rows.add(
          topics.sublist(
            startIndex,
            endIndex > topics.length ? topics.length : endIndex,
          ),
        );
      }
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final rows = _buildRows(context);
    // Дублируем контент для бесконечного скролла
    final duplicatedRows = [
      ...rows,
      ...rows,
      ...rows,
      ...rows,
      ...rows,
      ...rows,
      ...rows,
      ...rows,
      ...rows,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRect(
          child: Stack(
            children: [
              // Скроллируемый контент
              ListView(
                controller: _scrollController,
                physics: const NeverScrollableScrollPhysics(),
                children: duplicatedRows.asMap().entries.map((entry) {
                  final rowIndex = entry.key;
                  final topics = entry.value;
                  final isEvenRow = rowIndex % 2 == 1;
                  final offset = isEvenRow ? _brickOffset : 0.0;

                  return Padding(
                    key: ValueKey('row_$rowIndex'),
                    padding: EdgeInsets.only(
                      bottom: rowIndex < duplicatedRows.length - 1
                          ? _verticalSpacing
                          : 0,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (offset > 0) SizedBox(width: offset),
                          ...topics.map((topic) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: topics.last == topic
                                    ? 0
                                    : _horizontalSpacing,
                              ),
                              child: _TopicCard(
                                topic: topic,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Градиенты для fade эффекта сверху и снизу
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: _fadeZoneHeight,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.surface,
                          AppColors.surface.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: _fadeZoneHeight,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.surface,
                          AppColors.surface.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TopicCard extends StatelessWidget {
  final String topic;

  const _TopicCard({
    required this.topic,
  });

  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 8.0;
  static const double _borderRadius = 16.0;
  static const double _minHeight = 32.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding,
      ),
      constraints: const BoxConstraints(
        minHeight: _minHeight,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.textMuted.withValues(alpha: 0.1),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        topic,
        style: AppTextStyle.inter14w500
            .copyWith(
              color: AppColors.textPrimary,
            )
            .scaled(context),
      ),
    );
  }
}

class RealLifeTopicsContent extends StatelessWidget {
  const RealLifeTopicsContent({super.key});

  static const double _spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Semantics(
                label: s.onboarding6RealLifeTopicsTitle,
                child: Text(
                  s.onboarding6RealLifeTopicsTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.inter24w700.scaled(context),
                ),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label: s.onboarding6RealLifeTopicsSubtitle,
              child: Text(
                s.onboarding6RealLifeTopicsSubtitle,
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

class RealLifeTopicsButton extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const RealLifeTopicsButton({
    super.key,
    required this.onNext,
    this.onPrevious,
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
