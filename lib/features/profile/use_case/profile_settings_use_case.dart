import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ab_test/model/user_premium_source.dart';
import '../../../core/domain/enums/language.dart';
import '../../../core/local_storage/storage_keys.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../logic/profile_notifier.dart';

class ProfileSettingsUseCase {
  const ProfileSettingsUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<void> loadSettings() async {
    final localStorageService = ref.read(localStorageProvider);
    final profileNotifier = ref.read(profileProvider);
    try {
      final savedTeacherLanguageValue = await localStorageService
          .getValue<String>(
            StorageKeys.defaultTeacherLanguageKey,
          );

      if (savedTeacherLanguageValue != null) {
        final language = Language.fromLanguage(savedTeacherLanguageValue);
        if (language != null) {
          profileNotifier.setState(
            profileNotifier.state.copyWith(defaultTeacherLanguage: language),
          );
        }
      }
      final savedLanguageValue = await localStorageService.getValue<String>(
        StorageKeys.defaultLanguageKey,
      );

      if (savedLanguageValue != null) {
        final language = Language.fromLanguage(savedLanguageValue);
        if (language != null) {
          profileNotifier.setState(
            profileNotifier.state.copyWith(defaultLanguage: language),
          );
        }
      }
      final savedLanguageToLearnValue = await localStorageService
          .getValue<String>(
            StorageKeys.defaultLanguageToLearnKey,
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
    final localStorageService = ref.read(localStorageProvider);
    final profileNotifier = ref.read(profileProvider);
    await localStorageService.setValue<String>(
      StorageKeys.defaultTeacherLanguageKey,
      language.value,
    );
    profileNotifier.setState(
      profileNotifier.state.copyWith(defaultTeacherLanguage: language),
    );
  }

  Future<void> setDefaultLanguageToLearn(Language language) async {
    final localStorageService = ref.read(localStorageProvider);
    final profileNotifier = ref.read(profileProvider);

    await localStorageService.setValue<String>(
      StorageKeys.defaultLanguageToLearnKey,
      language.value,
    );
    profileNotifier.setState(
      profileNotifier.state.copyWith(defaultLanguageToLearn: language),
    );
  }

  Future<void> setDefaultLanguage(Language language) async {
    final localStorageService = ref.read(localStorageProvider);
    final profileNotifier = ref.read(profileProvider);
    await localStorageService.setValue<String>(
      StorageKeys.defaultLanguageKey,
      language.value,
    );
    profileNotifier.setState(
      profileNotifier.state.copyWith(defaultLanguage: language),
    );
  }

  Future<void> refreshDurations() async {
    final sessionsDurationsDao = ref
        .read(databaseProvider)
        .sessionsDurationsDao;
    final todayDuration = await sessionsDurationsDao.getTodaySessionsDuration();
    final totalDuration = await sessionsDurationsDao.getAllSessionsDurations();
    final profileNotifier = ref.read(profileProvider);
    profileNotifier.setState(
      profileNotifier.state.copyWith(
        isLoading: false,
        todayDuration: todayDuration,
        totalDuration: totalDuration,
      ),
    );
  }

  Future<void> loadIsPremium() async {
    final abTestService = ref.read(abTestServiceProvider);
    await abTestService.checkUserPremium();
    final profileNotifier = ref.read(profileProvider);
    final premiumSource = abTestService.userPremiumSource;
    if (premiumSource.isGold) {
      profileNotifier.setState(
        profileNotifier.state.copyWith(
          premiumStatus: PremiumStatus.gold,
        ),
      );
    } else if (premiumSource.isPremium) {
      profileNotifier.setState(
        profileNotifier.state.copyWith(
          premiumStatus: PremiumStatus.pro,
        ),
      );
    } else {
      profileNotifier.setState(
        profileNotifier.state.copyWith(
          premiumStatus: PremiumStatus.free,
        ),
      );
    }
  }
}
