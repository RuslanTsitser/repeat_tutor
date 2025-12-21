import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/domain/enums/language.dart';
import '../../core/localization/generated/l10n.dart';
import '../../infrastructure/state_managers.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _Header(),
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

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          S.of(context).profile,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color(0xFF0A0A0A),
            letterSpacing: 0.0703,
            height: 32 / 24,
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends ConsumerWidget {
  const _SettingsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(profileSettingsProvider);
    final state = settings.state;
    final selectedLanguage = state.defaultTeacherLanguage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Settings',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6A7282),
            letterSpacing: -0.1504,
            height: 20 / 14,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Default teacher language',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFF364153),
            letterSpacing: -0.3125,
            height: 24 / 16,
          ),
        ),
        const SizedBox(height: 12),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showLanguagePicker(context, ref, selectedLanguage),
          child: Container(
            height: 45,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFE5E7EB),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedLanguage.localizedName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF101828),
                    letterSpacing: -0.3125,
                    height: 24 / 16,
                  ),
                ),
                const Icon(
                  CupertinoIcons.chevron_down,
                  size: 20,
                  color: Color(0xFF101828),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    Language selectedLanguage,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => _LanguagePicker(
        selectedValue: selectedLanguage,
        onSelected: (language) {
          ref.read(profileSettingsProvider).setDefaultTeacherLanguage(language);
        },
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
                  child: Text(
                    S.of(context).cancel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF364153),
                    ),
                  ),
                ),
                const Text(
                  'Default teacher language',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF101828),
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

class _CallDurationSection extends ConsumerWidget {
  const _CallDurationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(profileSettingsProvider);
    final state = settings.state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Call Duration',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6A7282),
            letterSpacing: -0.1504,
            height: 20 / 14,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            _DurationRow(
              label: 'Today',
              duration: state.todayDuration,
              showBorder: true,
            ),
            _DurationRow(
              label: 'Total',
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
    return Container(
      height: 49,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: showBorder
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFF3F4F6),
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(0xFF364153),
              letterSpacing: -0.3125,
              height: 24 / 16,
            ),
          ),
          Text(
            _formatDuration(duration),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF101828),
              letterSpacing: -0.3125,
              height: 24 / 16,
            ),
          ),
        ],
      ),
    );
  }
}
