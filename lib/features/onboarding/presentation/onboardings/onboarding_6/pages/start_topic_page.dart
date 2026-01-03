import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../../../../../infrastructure/state_managers.dart';
import '../../../../../../infrastructure/use_case.dart';
import 'onboarding_back_button_wrapper.dart';

class StartTopicPage extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const StartTopicPage({
    super.key,
    required this.onNext,
    this.onPrevious,
  });

  @override
  ConsumerState<StartTopicPage> createState() => _StartTopicPageState();
}

class _StartTopicPageState extends ConsumerState<StartTopicPage> {
  final TextEditingController _topicController = TextEditingController();
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    final onboarding6State = ref.read(onboarding6NotifierProvider).state;
    final selectedTopic = onboarding6State.selectedTopic;
    if (selectedTopic != null && selectedTopic.isNotEmpty) {
      _topicController.text = selectedTopic;
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  Future<void> _createChat() async {
    if (_isCreating) return;

    final topic = _topicController.text.trim();
    if (topic.isEmpty) return;

    setState(() {
      _isCreating = true;
    });

    try {
      ref.read(onboarding6NotifierProvider).setSelectedTopic(topic);

      await ref
          .read(openChatAfterOnboardingUseCaseProvider)
          .openChatAfterOnboarding();
      return;
    } catch (e) {
      // Обработка ошибки создания чата
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
      }
    }
  }

  void _selectTopic(String topic) {
    _topicController.text = topic;
    ref.read(onboarding6NotifierProvider).setSelectedTopic(topic);
  }

  @override
  Widget build(BuildContext context) {
    final onboarding6State = ref.watch(onboarding6NotifierProvider);
    final selectedTopic = onboarding6State.state.selectedTopic;

    return OnboardingBackButtonWrapper(
      onPrevious: widget.onPrevious,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32.0),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32.0),
                    StartTopicContent(
                      topicController: _topicController,
                      selectedTopic: selectedTopic ?? '',
                      onTopicSelected: _selectTopic,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: StartTopicButton(
                onNext: _createChat,
                onPrevious: widget.onPrevious,
                isCreating: _isCreating,
                canProceed: _topicController.text.trim().isNotEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StartTopicContent extends StatelessWidget {
  final TextEditingController topicController;
  final String selectedTopic;
  final ValueChanged<String> onTopicSelected;

  const StartTopicContent({
    super.key,
    required this.topicController,
    required this.selectedTopic,
    required this.onTopicSelected,
  });

  static const double _spacing = 16.0;
  static const double _chipSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    final exampleTopics = [
      S.of(context).exampleTopicFreeTime,
      S.of(context).exampleTopicShopping,
      S.of(context).exampleTopicTravel,
      S.of(context).exampleTopicFood,
      S.of(context).exampleTopicWork,
      S.of(context).exampleTopicHobbies,
      S.of(context).exampleTopicSports,
    ];

    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Semantics(
                label: S.of(context).onboarding6StartTopicTitle,
                child: Text(
                  S.of(context).onboarding6StartTopicTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.inter24w700.scaled(context),
                ),
              ),
            ),
            const SizedBox(height: _spacing),
            Semantics(
              label: S.of(context).onboarding6StartTopicSubtitle,
              child: Text(
                S.of(context).onboarding6StartTopicSubtitle,
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
              textField: true,
              label: 'Topic input',
              hint: S.of(context).egFreeTimeShoppingTravel,
              child: Container(
                height: 48.0,
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: AppColors.divider,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CupertinoTextField(
                  controller: topicController,
                  placeholder: S.of(context).egFreeTimeShoppingTravel,
                  placeholderStyle: AppTextStyle.inter16w400.copyWith(
                    color: AppColors.textMuted,
                  ),
                  style: AppTextStyle.inter16w400
                      .copyWith(color: AppColors.textPrimary)
                      .scaled(context),
                  decoration: const BoxDecoration(),
                ),
              ),
            ),
            const SizedBox(height: _spacing),
            Wrap(
              spacing: _chipSpacing,
              runSpacing: _chipSpacing,
              children: exampleTopics.map((topic) {
                final isSelected = selectedTopic == topic;
                return _TopicChip(
                  label: topic,
                  isSelected: isSelected,
                  onTap: () {
                    onTopicSelected(topic);
                  },
                );
              }).toList(),
            ),
          ],
        )
        .animate(delay: 200.ms)
        .moveY(begin: 16, end: 0, curve: Curves.easeOut)
        .fadeIn();
  }
}

class _TopicChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TopicChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  static const double _horizontalPadding = 12.0;
  static const double _verticalPadding = 8.0;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: _horizontalPadding,
            vertical: _verticalPadding,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(_borderRadius),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.divider,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyle.inter14w400
                .copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                )
                .scaled(context),
          ),
        ),
      ),
    );
  }
}

class StartTopicButton extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  final bool isCreating;
  final bool canProceed;

  const StartTopicButton({
    super.key,
    required this.onNext,
    this.onPrevious,
    required this.isCreating,
    required this.canProceed,
  });

  static const double _verticalPadding = 16.0;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Semantics(
      button: true,
      label: s.continueButton,
      enabled: canProceed && !isCreating,
      child: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          onPressed: (canProceed && !isCreating) ? onNext : null,
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
          minimumSize: const Size(0, 44.0),
          borderRadius: BorderRadius.circular(_borderRadius),
          child: isCreating
              ? const CupertinoActivityIndicator(
                  color: AppColors.surface,
                )
              : Text(
                  s.continueButton,
                  style: AppTextStyle.inter16w600
                      .copyWith(
                        color: AppColors.surface,
                      )
                      .scaled(context),
                ),
        ),
      ),
    ).animate(delay: 400.ms).moveY(begin: 16, end: 0).fadeIn();
  }
}
