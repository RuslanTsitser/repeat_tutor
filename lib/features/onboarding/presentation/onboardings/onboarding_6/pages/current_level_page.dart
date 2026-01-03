import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/domain/enums/difficulty_level.dart';
import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../../../../../infrastructure/state_managers.dart';
import 'onboarding_back_button_wrapper.dart';

class CurrentLevelPage extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const CurrentLevelPage({
    super.key,
    required this.onNext,
    this.onPrevious,
  });

  @override
  ConsumerState<CurrentLevelPage> createState() => _CurrentLevelPageState();
}

class _CurrentLevelPageState extends ConsumerState<CurrentLevelPage> {
  DifficultyLevel? _selectedLevel;
  Timer? _transitionTimer;

  @override
  void dispose() {
    _transitionTimer?.cancel();
    super.dispose();
  }

  void _handleLevelSelected(DifficultyLevel level) {
    if (_selectedLevel == level) return;

    setState(() {
      _selectedLevel = level;
    });

    ref.read(onboarding6NotifierProvider).setCurrentLevel(level);

    _transitionTimer?.cancel();
    _transitionTimer = Timer(const Duration(milliseconds: 500), () {
      widget.onNext();
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingBackButtonWrapper(
      onPrevious: widget.onPrevious,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 32.0),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: CurrentLevelContent(
                  selectedLevel: _selectedLevel,
                  onLevelSelected: _handleLevelSelected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentLevelContent extends StatelessWidget {
  final DifficultyLevel? selectedLevel;
  final ValueChanged<DifficultyLevel> onLevelSelected;

  const CurrentLevelContent({
    super.key,
    required this.selectedLevel,
    required this.onLevelSelected,
  });

  static const double _spacing = 16.0;
  static const double _itemSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32.0),
            Center(
              child: Semantics(
                label: S.of(context).onboarding6CurrentLevelTitle,
                child: Text(
                  S.of(context).onboarding6CurrentLevelTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.inter24w700.scaled(context),
                ),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label: S.of(context).onboarding6CurrentLevelSubtitle,
              child: Text(
                S.of(context).onboarding6CurrentLevelSubtitle,
                textAlign: TextAlign.start,
                style: AppTextStyle.inter16w400
                    .copyWith(
                      color: AppColors.textMuted,
                    )
                    .scaled(context),
              ),
            ),
            const SizedBox(height: 32.0),
            Semantics(
              label: 'Level list',
              child: Column(
                children: DifficultyLevel.values.map((level) {
                  final isSelected = selectedLevel == level;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: _itemSpacing),
                    child: _LevelItem(
                      level: level,
                      isSelected: isSelected,
                      onTap: () => onLevelSelected(level),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        )
        .animate(delay: 200.ms)
        .moveY(begin: 16, end: 0, curve: Curves.easeOut)
        .fadeIn();
  }
}

class _LevelItem extends StatelessWidget {
  final DifficultyLevel level;
  final bool isSelected;
  final VoidCallback onTap;

  const _LevelItem({
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  static const double _horizontalPadding = 16.0;
  static const double _borderRadius = 16.0;
  static const double _checkmarkSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${level.localizedName}${isSelected ? ', selected' : ''}',
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 56.0,
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(_borderRadius),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.divider,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  level.localizedName,
                  style: AppTextStyle.inter16w400
                      .copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      )
                      .scaled(context),
                ),
              ),
              if (isSelected)
                Container(
                  width: _checkmarkSize,
                  height: _checkmarkSize,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.checkmark,
                    size: 16,
                    color: AppColors.surface,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
