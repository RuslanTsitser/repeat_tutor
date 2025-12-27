import 'dart:math' show max;

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';
import '../../../core/localization/generated/l10n.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../logic/create_chat_notifier.dart';

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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, -6),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              height: 69,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).newChat,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0A0A0A),
                      letterSpacing: -0.4492,
                      height: 28 / 20,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => ref.read(routerProvider).pop(),
                    minimumSize: const Size(36, 36),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        CupertinoIcons.xmark,
                        size: 20,
                        color: Color(0xFF0A0A0A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Form
            Padding(
              padding: const EdgeInsets.all(16),
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
                        _TopicInput(
                          value: state.topic,
                          onChanged: (topic) {
                            entity.setState(state.copyWith(topic: topic));
                          },
                        ),
                        const SizedBox(height: 8),
                        Wrap(
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
                                  entity.setState(
                                    state.copyWith(topic: topic),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Language to learn
                  _FormField(
                    label: S.of(context).languageToLearn,
                    child: _LanguageDropdown(
                      value: state.language,
                      onChanged: (language) {
                        entity.setState(state.copyWith(language: language));
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // // Teacher language
                  // _FormField(
                  //   label: S.of(context).teacherLanguage,
                  //   child: _LanguageDropdown(
                  //     value: state.teacherLanguage,
                  //     onChanged: (teacherLanguage) {
                  //       entity.setState(
                  //         state.copyWith(teacherLanguage: teacherLanguage),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(height: 16),
                  // Level
                  _FormField(
                    label: S.of(context).level,
                    child: _LevelDropdown(
                      value: state.level,
                      onChanged: (level) {
                        entity.setState(state.copyWith(level: level));
                      },
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _CancelButton(
                          onPressed: () => ref.read(routerProvider).pop(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StartChatButton(
                          onPressed: state.topic.trim().isEmpty
                              ? null
                              : () => ref.read(routerProvider).pop(state),
                        ),
                      ),
                    ],
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
          ],
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
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF364153),
            letterSpacing: -0.1504,
            height: 20 / 14,
          ),
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
      child: Container(
        height: 47,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFD1D5DC),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value.localizedName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Color(0xFF101828),
                letterSpacing: -0.3125,
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_down,
              size: 16,
              color: Color(0xFF101828),
            ),
          ],
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
      child: Container(
        height: 47,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFD1D5DC),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value.localizedName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Color(0xFF101828),
                letterSpacing: -0.3125,
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_down,
              size: 16,
              color: Color(0xFF101828),
            ),
          ],
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF101828),
            letterSpacing: -0.3125,
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
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFD1D5DC),
          width: 1,
        ),
      ),
      child: CupertinoTextField(
        controller: _controller,
        placeholder: S.of(context).egFreeTimeShoppingTravel,
        placeholderStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Color(0xFF99A1AF),
          letterSpacing: -0.3125,
        ),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Color(0xFF101828),
          letterSpacing: -0.3125,
        ),
        decoration: const BoxDecoration(),
        padding: EdgeInsets.zero,
        onChanged: widget.onChanged,
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
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFD1D5DC),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            S.of(context).cancel,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF364153),
              letterSpacing: -0.3125,
              height: 24 / 16,
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
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: onPressed != null
              ? const Color(0xFF155DFC)
              : const Color(0xFFD1D5DC),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Start chat',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: CupertinoColors.white,
              letterSpacing: -0.3125,
              height: 24 / 16,
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
      height: 300,
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE5E7EB),
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
                  child: const Text('Cancel'),
                ),
                const Text(
                  'Language to learn',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 60),
              ],
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 44,
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF101828),
                      letterSpacing: -0.3125,
                    ),
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
      height: 300,
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE5E7EB),
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
                  child: const Text('Cancel'),
                ),
                const Text(
                  'Level',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 60),
              ],
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 44,
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF101828),
                      letterSpacing: -0.3125,
                    ),
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
