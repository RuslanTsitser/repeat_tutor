import 'package:flutter/cupertino.dart';

import '../../../core/ab_test/ab_test_service.dart';
import '../../../core/database/daos/sessions_durations_dao.dart';
import '../../../core/database/daos/settings_dao.dart';
import '../../../core/domain/enums/language.dart';

class ProfileSettingsNotifier extends ChangeNotifier {
  static const String _defaultTeacherLanguageKey = 'default_teacher_language';
  static const String _defaultLanguageKey = 'default_language';
  static const String _defaultLanguageToLearnKey = 'default_language_to_learn';

  ProfileSettingsNotifier({
    required SettingsDao settingsDao,
    required SessionsDurationsDao sessionsDurationsDao,
    required AbTestService abTestService,
  }) : _settingsDao = settingsDao,
       _sessionsDurationsDao = sessionsDurationsDao,
       _abTestService = abTestService,
       _state = ProfileSettingsState.initial() {
    _loadSettings();
    _loadDurations();
    _loadIsPremium();
  }

  final SettingsDao _settingsDao;
  final SessionsDurationsDao _sessionsDurationsDao;
  final AbTestService _abTestService;
  ProfileSettingsState _state = ProfileSettingsState.initial();
  ProfileSettingsState get state => _state;

  void setState(ProfileSettingsState value) {
    _state = value;
    notifyListeners();
  }

  Future<void> _loadSettings() async {
    try {
      final savedTeacherLanguageValue = await _settingsDao.getValue(
        _defaultTeacherLanguageKey,
      );

      if (savedTeacherLanguageValue != null) {
        final language = Language.fromLanguage(savedTeacherLanguageValue);
        if (language != null) {
          setState(_state.copyWith(defaultTeacherLanguage: language));
        }
      }
      final savedLanguageValue = await _settingsDao.getValue(
        _defaultLanguageKey,
      );

      if (savedLanguageValue != null) {
        final language = Language.fromLanguage(savedLanguageValue);
        if (language != null) {
          setState(_state.copyWith(defaultLanguage: language));
        }
      }
      final savedLanguageToLearnValue = await _settingsDao.getValue(
        _defaultLanguageToLearnKey,
      );

      if (savedLanguageToLearnValue != null) {
        final language = Language.fromLanguage(savedLanguageToLearnValue);
        if (language != null) {
          setState(_state.copyWith(defaultLanguageToLearn: language));
        }
      }
    } catch (e) {
      // Если ошибка при загрузке, используем значение по умолчанию
    }
  }

  Future<void> setDefaultTeacherLanguage(Language language) async {
    if (_state.defaultTeacherLanguage != language) {
      await _settingsDao.setValue(
        _defaultTeacherLanguageKey,
        language.value,
      );
      setState(_state.copyWith(defaultTeacherLanguage: language));
    }
  }

  Future<void> setDefaultLanguageToLearn(Language language) async {
    if (_state.defaultLanguageToLearn != language) {
      await _settingsDao.setValue(
        _defaultLanguageToLearnKey,
        language.value,
      );
      setState(_state.copyWith(defaultLanguageToLearn: language));
    }
  }

  Future<void> setDefaultLanguage(Language language) async {
    if (_state.defaultLanguage != language) {
      await _settingsDao.setValue(
        _defaultLanguageKey,
        language.value,
      );
      setState(_state.copyWith(defaultLanguage: language));
    }
  }

  Future<void> _loadDurations() async {
    setState(_state.copyWith(isLoading: true));

    try {
      final today = await _sessionsDurationsDao.getTodaySessionsDuration();
      final total = await _sessionsDurationsDao.getAllSessionsDurations();

      setState(
        _state.copyWith(
          todayDuration: today,
          totalDuration: total,
          isLoading: false,
        ),
      );
    } catch (e) {
      setState(_state.copyWith(isLoading: false));
    }
  }

  Future<void> refreshDurations() async {
    await _loadDurations();
  }

  Future<void> _loadIsPremium() async {
    await _abTestService.checkUserPremium();
    setState(_state.copyWith(isPremium: _abTestService.isPremium));
  }
}

class ProfileSettingsState {
  factory ProfileSettingsState.initial() {
    return const ProfileSettingsState(
      defaultTeacherLanguage: Language.english,
      defaultLanguageToLearn: Language.english,
      defaultLanguage: Language.english,
      todayDuration: Duration.zero,
      totalDuration: Duration.zero,
      isLoading: false,
      isPremium: false,
    );
  }

  const ProfileSettingsState({
    required this.defaultTeacherLanguage,
    required this.defaultLanguageToLearn,
    required this.defaultLanguage,
    required this.todayDuration,
    required this.totalDuration,
    required this.isLoading,
    required this.isPremium,
  });

  final Language defaultTeacherLanguage;
  final Language defaultLanguageToLearn;
  final Language defaultLanguage;
  final Duration todayDuration;
  final Duration totalDuration;
  final bool isLoading;
  final bool isPremium;

  ProfileSettingsState copyWith({
    Language? defaultTeacherLanguage,
    Language? defaultLanguageToLearn,
    Language? defaultLanguage,
    Duration? todayDuration,
    Duration? totalDuration,
    bool? isLoading,
    bool? isPremium,
  }) {
    return ProfileSettingsState(
      defaultTeacherLanguage:
          defaultTeacherLanguage ?? this.defaultTeacherLanguage,
      defaultLanguageToLearn:
          defaultLanguageToLearn ?? this.defaultLanguageToLearn,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      todayDuration: todayDuration ?? this.todayDuration,
      totalDuration: totalDuration ?? this.totalDuration,
      isLoading: isLoading ?? this.isLoading,
      isPremium: isPremium ?? this.isPremium,
    );
  }
}
