import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums/language.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';

class ProfileSettingsUseCase {
  const ProfileSettingsUseCase({
    required this.ref,
  });
  final Ref ref;

  static const String _defaultTeacherLanguageKey = 'default_teacher_language';
  static const String _defaultLanguageKey = 'default_language';
  static const String _defaultLanguageToLearnKey = 'default_language_to_learn';

  Future<void> loadSettings() async {
    final settingsDao = ref.read(databaseProvider).settingsDao;
    final profileNotifier = ref.read(profileProvider);
    try {
      final savedTeacherLanguageValue = await settingsDao.getValue(
        _defaultTeacherLanguageKey,
      );

      if (savedTeacherLanguageValue != null) {
        final language = Language.fromLanguage(savedTeacherLanguageValue);
        if (language != null) {
          profileNotifier.setState(
            profileNotifier.state.copyWith(defaultTeacherLanguage: language),
          );
        }
      }
      final savedLanguageValue = await settingsDao.getValue(
        _defaultLanguageKey,
      );

      if (savedLanguageValue != null) {
        final language = Language.fromLanguage(savedLanguageValue);
        if (language != null) {
          profileNotifier.setState(
            profileNotifier.state.copyWith(defaultLanguage: language),
          );
        }
      }
      final savedLanguageToLearnValue = await settingsDao.getValue(
        _defaultLanguageToLearnKey,
      );

      if (savedLanguageToLearnValue != null) {
        final language = Language.fromLanguage(savedLanguageToLearnValue);
        if (language != null) {
          profileNotifier.setState(
            profileNotifier.state.copyWith(defaultLanguageToLearn: language),
          );
        }
      }
    } catch (e) {
      // Если ошибка при загрузке, используем значение по умолчанию
    }
  }

  Future<void> setDefaultTeacherLanguage(Language language) async {
    final settingsDao = ref.read(databaseProvider).settingsDao;
    await settingsDao.setValue(
      _defaultTeacherLanguageKey,
      language.value,
    );
    final profileNotifier = ref.read(profileProvider);
    profileNotifier.setState(
      profileNotifier.state.copyWith(defaultTeacherLanguage: language),
    );
  }

  Future<void> setDefaultLanguageToLearn(Language language) async {
    final settingsDao = ref.read(databaseProvider).settingsDao;
    await settingsDao.setValue(
      _defaultLanguageToLearnKey,
      language.value,
    );
  }

  Future<void> setDefaultLanguage(Language language) async {
    final settingsDao = ref.read(databaseProvider).settingsDao;
    await settingsDao.setValue(
      _defaultLanguageKey,
      language.value,
    );
  }

  Future<void> refreshDurations() async {
    final sessionsDurationsDao = ref
        .read(databaseProvider)
        .sessionsDurationsDao;
    await sessionsDurationsDao.getTodaySessionsDuration();
    await sessionsDurationsDao.getAllSessionsDurations();
    final profileNotifier = ref.read(profileProvider);
    profileNotifier.setState(profileNotifier.state.copyWith(isLoading: false));
  }

  Future<void> loadIsPremium() async {
    final abTestService = ref.read(abTestServiceProvider);
    await abTestService.checkUserPremium();
    final profileNotifier = ref.read(profileProvider);
    profileNotifier.setState(
      profileNotifier.state.copyWith(isPremium: abTestService.isPremium),
    );
  }
}
