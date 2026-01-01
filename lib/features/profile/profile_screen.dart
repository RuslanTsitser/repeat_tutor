import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/domain/enums/language.dart';
import '../../core/localization/generated/l10n.dart';
import '../../core/presentation/logo_app_bar.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';
import '../../infrastructure/state_managers.dart';
import '../../infrastructure/use_case.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            LogoAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SettingsSection(),
                      SizedBox(height: 24),
                      _CallDurationSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends ConsumerWidget {
  const _SettingsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(profileProvider);
    final state = settings.state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LanguageSelector(
          label: S.of(context).appLanguage,
          selectedLanguage: state.defaultLanguage,
          onLanguageSelected: (language) {
            ref
                .read(profileSettingsUseCaseProvider)
                .setDefaultLanguage(language);
          },
        ),
        const SizedBox(height: 16),
        _LanguageSelector(
          label: S.of(context).languageToLearn,
          selectedLanguage: state.defaultLanguageToLearn,
          onLanguageSelected: (language) {
            ref
                .read(profileSettingsUseCaseProvider)
                .setDefaultLanguageToLearn(language);
          },
        ),
        const SizedBox(height: 16),
        _LanguageSelector(
          label: S.of(context).tutorLanguage,
          selectedLanguage: state.defaultTeacherLanguage,
          onLanguageSelected: (language) {
            ref
                .read(profileSettingsUseCaseProvider)
                .setDefaultTeacherLanguage(language);
          },
        ),
      ],
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector({
    required this.label,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  final String label;
  final Language selectedLanguage;
  final ValueChanged<Language> onLanguageSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.inter16w400.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Semantics(
          label: '$label: ${selectedLanguage.localizedName}',
          button: true,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _showLanguagePicker(context, selectedLanguage),
            child: Container(
              height: 44,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.divider,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedLanguage.localizedName,
                    style: AppTextStyle.inter16w500.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.chevron_down,
                    size: 24,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showLanguagePicker(
    BuildContext context,
    Language selectedLanguage,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => _LanguagePicker(
        title: label,
        selectedValue: selectedLanguage,
        onSelected: onLanguageSelected,
      ),
    );
  }
}

class _LanguagePicker extends StatelessWidget {
  const _LanguagePicker({
    required this.title,
    required this.selectedValue,
    required this.onSelected,
  });

  final String title;
  final Language selectedValue;
  final ValueChanged<Language> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: AppColors.surface,
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
                  color: AppColors.divider,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Semantics(
                  label: S.of(context).cancel,
                  button: true,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      S.of(context).cancel,
                      style: AppTextStyle.inter16w400.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: AppTextStyle.inter16w500.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 64),
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
                    style: AppTextStyle.inter16w400.copyWith(
                      color: AppColors.textPrimary,
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

class _CallDurationSection extends ConsumerWidget {
  const _CallDurationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(profileProvider);
    final state = settings.state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).callDuration,
          style: AppTextStyle.inter14w500.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            _DurationRow(
              label: S.of(context).today,
              duration: state.todayDuration,
              showBorder: true,
            ),
            _DurationRow(
              label: S.of(context).total,
              duration: state.totalDuration,
              showBorder: false,
            ),
          ],
        ),
      ],
    );
  }
}

class _DurationRow extends StatelessWidget {
  const _DurationRow({
    required this.label,
    required this.duration,
    this.showBorder = false,
  });

  final String label;
  final Duration duration;
  final bool showBorder;

  String _formatDuration(Duration duration) {
    final totalSeconds = duration.inSeconds;
    if (totalSeconds < 60) {
      return '${totalSeconds}s';
    }
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    if (minutes < 60) {
      return '${minutes}m ${seconds}s';
    }
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}m';
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label: ${_formatDuration(duration)}',
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: showBorder
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.backgroundLight,
                    width: 1,
                  ),
                ),
              )
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyle.inter16w400.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              _formatDuration(duration),
              style: AppTextStyle.inter16w500.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
