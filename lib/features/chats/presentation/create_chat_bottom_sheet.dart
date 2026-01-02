import 'dart:math' show max;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';
import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/logo_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../../onboarding/presentation/onboarding_wrappers/onboarding_create_chat_bottom_sheet_wrapper.dart';
import '../logic/create_chat_notifier.dart';

// Константы для размеров
class _CreateChatBottomSheetConstants {
  _CreateChatBottomSheetConstants._();
  static const double borderRadius = 16.0;
  static const double borderRadiusChip = 16.0;
  static const double inputHeight = 48.0;
  static const double buttonHeight = 48.0;
  static const double pickerHeight = 300.0;
  static const double pickerHeaderHeight = 44.0;
  static const double shadowBlurRadius = 24.0;
  static const double shadowOffset = -8.0;
}

class CreateChatBottomSheet extends ConsumerStatefulWidget {
  const CreateChatBottomSheet({super.key});

  @override
  ConsumerState<CreateChatBottomSheet> createState() =>
      _CreateChatBottomSheetState();
}

class _CreateChatBottomSheetState extends ConsumerState<CreateChatBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(createChatProvider.notifier)
          .setState(
            CreateChatState(
              language: ref.read(profileProvider).state.defaultLanguageToLearn,
              level: DifficultyLevel.beginner,
              teacherLanguage: ref
                  .read(profileProvider)
                  .state
                  .defaultTeacherLanguage,
              topic: '',
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final entity = ref.watch(createChatProvider);
    final state = entity.state;

    return OnboardingCreateChatBottomSheetWrapper(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                _CreateChatBottomSheetConstants.borderRadius,
              ),
              topRight: Radius.circular(
                _CreateChatBottomSheetConstants.borderRadius,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: _CreateChatBottomSheetConstants.shadowBlurRadius,
                offset: const Offset(
                  0,
                  _CreateChatBottomSheetConstants.shadowOffset,
                ),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8.0,
                offset: const Offset(
                  0,
                  _CreateChatBottomSheetConstants.shadowOffset,
                ),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LogoAppBar(),
                // Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Topic
                      _FormField(
                        label: S.of(context).topic,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TopicInputWrapper(
                              child: _TopicInput(
                                value: state.topic,
                                onChanged: (topic) {
                                  entity.setState(state.copyWith(topic: topic));
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            TopicChipsWrapper(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  ...[
                                    S.of(context).exampleTopicFreeTime,
                                    S.of(context).exampleTopicShopping,
                                    S.of(context).exampleTopicTravel,
                                    S.of(context).exampleTopicFood,
                                    S.of(context).exampleTopicWork,
                                    S.of(context).exampleTopicHobbies,
                                    S.of(context).exampleTopicSports,
                                  ].map(
                                    (topic) => _TopicChip(
                                      label: topic,
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        entity.setState(
                                          state.copyWith(topic: topic),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Language to learn
                      LanguageDropdownWrapper(
                        child: _FormField(
                          label: S.of(context).languageToLearn,
                          child: _LanguageDropdown(
                            value: state.language,
                            onChanged: (language) {
                              entity.setState(
                                state.copyWith(language: language),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Level
                      LevelDropdownWrapper(
                        child: _FormField(
                          label: S.of(context).level,
                          child: _LevelDropdown(
                            value: state.level,
                            onChanged: (level) {
                              entity.setState(state.copyWith(level: level));
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const Spacer(),
                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _CancelButton(
                          onPressed: () => ref.read(routerProvider).pop(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _StartChatButton(
                          onPressed: state.topic.trim().isEmpty
                              ? null
                              : () => ref.read(routerProvider).pop(state),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: max(
                    MediaQuery.viewInsetsOf(context).bottom * 0.4,
                    16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.inter14w500
              .copyWith(color: AppColors.textSecondary)
              .scaled(context),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  const _LanguageDropdown({
    required this.value,
    required this.onChanged,
  });

  final Language value;
  final ValueChanged<Language> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (context) => _LanguagePicker(
            selectedValue: value,
            onSelected: onChanged,
          ),
        );
      },
      child: Semantics(
        label: '${S.of(context).languageToLearn}: ${value.localizedName}',
        button: true,
        child: Container(
          height: _CreateChatBottomSheetConstants.inputHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(
              _CreateChatBottomSheetConstants.borderRadius,
            ),
            border: Border.all(
              color: AppColors.divider,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.localizedName,
                style: AppTextStyle.inter16w400
                    .copyWith(color: AppColors.textPrimary)
                    .scaled(context),
              ),
              const Icon(
                CupertinoIcons.chevron_down,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelDropdown extends StatelessWidget {
  const _LevelDropdown({
    required this.value,
    required this.onChanged,
  });

  final DifficultyLevel value;
  final ValueChanged<DifficultyLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (context) => _LevelPicker(
            selectedValue: value,
            onSelected: onChanged,
          ),
        );
      },
      child: Semantics(
        label: '${S.of(context).level}: ${value.localizedName}',
        button: true,
        child: Container(
          height: _CreateChatBottomSheetConstants.inputHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(
              _CreateChatBottomSheetConstants.borderRadius,
            ),
            border: Border.all(
              color: AppColors.divider,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.localizedName,
                style: AppTextStyle.inter16w400
                    .copyWith(color: AppColors.textPrimary)
                    .scaled(context),
              ),
              const Icon(
                CupertinoIcons.chevron_down,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicChip extends StatelessWidget {
  const _TopicChip({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.secondaryCtaBackground,
            borderRadius: BorderRadius.circular(
              _CreateChatBottomSheetConstants.borderRadiusChip,
            ),
            border: Border.all(
              color: AppColors.divider,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyle.inter14w400
                .copyWith(color: AppColors.textPrimary)
                .scaled(context),
          ),
        ),
      ),
    );
  }
}

class _TopicInput extends StatefulWidget {
  const _TopicInput({
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  State<_TopicInput> createState() => _TopicInputState();
}

class _TopicInputState extends State<_TopicInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(_TopicInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: S.of(context).topic,
      hint: S.of(context).egFreeTimeShoppingTravel,
      child: SizedBox(
        height: _CreateChatBottomSheetConstants.inputHeight,

        child: CupertinoTextField(
          controller: _controller,
          placeholder: S.of(context).egFreeTimeShoppingTravel,
          placeholderStyle: AppTextStyle.inter16w400.copyWith(
            color: AppColors.textMuted,
          ),
          style: AppTextStyle.inter16w400
              .copyWith(color: AppColors.textPrimary)
              .scaled(context),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                _CreateChatBottomSheetConstants.borderRadius,
              ),
            ),
            border: Border.all(
              color: AppColors.divider,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          onChanged: widget.onChanged,
          suffixMode: OverlayVisibilityMode.editing,
          suffix: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              _controller.clear();
            },
            child: const Icon(
              LucideIcons.x,
              size: 24,
              color: AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: S.of(context).cancel,
      button: true,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: _CreateChatBottomSheetConstants.buttonHeight,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(
              _CreateChatBottomSheetConstants.borderRadius,
            ),
            border: Border.all(
              color: AppColors.divider,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              S.of(context).cancel,
              style: AppTextStyle.inter16w500
                  .copyWith(color: AppColors.textSecondary)
                  .scaled(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _StartChatButton extends StatelessWidget {
  const _StartChatButton({
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    return Semantics(
      label: S.of(context).startYourFirstChat,
      button: true,
      enabled: isEnabled,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: _CreateChatBottomSheetConstants.buttonHeight,
          decoration: BoxDecoration(
            color: isEnabled ? AppColors.primary : AppColors.divider,
            borderRadius: BorderRadius.circular(
              _CreateChatBottomSheetConstants.borderRadius,
            ),
          ),
          child: Center(
            child: Text(
              S.of(context).start,
              style: AppTextStyle.inter16w500
                  .copyWith(color: CupertinoColors.white)
                  .scaled(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguagePicker extends StatelessWidget {
  const _LanguagePicker({
    required this.selectedValue,
    required this.onSelected,
  });

  final Language selectedValue;
  final ValueChanged<Language> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _CreateChatBottomSheetConstants.pickerHeight,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            _CreateChatBottomSheetConstants.borderRadius,
          ),
          topRight: Radius.circular(
            _CreateChatBottomSheetConstants.borderRadius,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: _CreateChatBottomSheetConstants.pickerHeaderHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.divider,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    S.of(context).cancel,
                    style: AppTextStyle.inter16w400
                        .copyWith(color: AppColors.primary)
                        .scaled(context),
                  ),
                ),
                Text(
                  S.of(context).languageToLearn,
                  style: AppTextStyle.inter16w500
                      .copyWith(color: AppColors.textPrimary)
                      .scaled(context),
                ),
                const SizedBox(width: 64),
              ],
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: _CreateChatBottomSheetConstants.pickerHeaderHeight,
              scrollController: FixedExtentScrollController(
                initialItem: Language.values.indexOf(selectedValue),
              ),
              onSelectedItemChanged: (index) {
                onSelected(Language.values[index]);
              },
              children: Language.values.map((language) {
                return Center(
                  child: Text(
                    language.localizedName,
                    style: AppTextStyle.inter16w400
                        .copyWith(color: AppColors.textPrimary)
                        .scaled(context),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelPicker extends StatelessWidget {
  const _LevelPicker({
    required this.selectedValue,
    required this.onSelected,
  });

  final DifficultyLevel selectedValue;
  final ValueChanged<DifficultyLevel> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _CreateChatBottomSheetConstants.pickerHeight,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            _CreateChatBottomSheetConstants.borderRadius,
          ),
          topRight: Radius.circular(
            _CreateChatBottomSheetConstants.borderRadius,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: _CreateChatBottomSheetConstants.pickerHeaderHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.divider,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    S.of(context).cancel,
                    style: AppTextStyle.inter16w400
                        .copyWith(color: AppColors.primary)
                        .scaled(context),
                  ),
                ),
                Text(
                  S.of(context).level,
                  style: AppTextStyle.inter16w500
                      .copyWith(color: AppColors.textPrimary)
                      .scaled(context),
                ),
                const SizedBox(width: 64),
              ],
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: _CreateChatBottomSheetConstants.pickerHeaderHeight,
              scrollController: FixedExtentScrollController(
                initialItem: DifficultyLevel.values.indexOf(selectedValue),
              ),
              onSelectedItemChanged: (index) {
                onSelected(DifficultyLevel.values[index]);
              },
              children: DifficultyLevel.values.map((level) {
                return Center(
                  child: Text(
                    level.localizedName,
                    style: AppTextStyle.inter16w400
                        .copyWith(color: AppColors.textPrimary)
                        .scaled(context),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
