import 'package:flutter/cupertino.dart';

import '../../../core/database/daos/sessions_durations_dao.dart';
import '../../../core/database/daos/settings_dao.dart';
import '../../../core/domain/enums/language.dart';

class ProfileSettingsNotifier extends ChangeNotifier {
  static const String _defaultTeacherLanguageKey = 'default_teacher_language';

  ProfileSettingsNotifier({
    required SettingsDao settingsDao,
    required SessionsDurationsDao sessionsDurationsDao,
  }) : _settingsDao = settingsDao,
       _sessionsDurationsDao = sessionsDurationsDao,
       _state = ProfileSettingsState.initial() {
    _loadSettings();
    _loadDurations();
  }

  final SettingsDao _settingsDao;
  final SessionsDurationsDao _sessionsDurationsDao;
  ProfileSettingsState _state = ProfileSettingsState.initial();
  ProfileSettingsState get state => _state;

  void setState(ProfileSettingsState value) {
    _state = value;
    notifyListeners();
  }

  Future<void> _loadSettings() async {
    try {
      final savedLanguageValue = await _settingsDao.getValue(
        _defaultTeacherLanguageKey,
      );
      if (savedLanguageValue != null) {
        final language = Language.fromLanguage(savedLanguageValue);
        if (language != null) {
          setState(_state.copyWith(defaultTeacherLanguage: language));
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
}

class ProfileSettingsState {
  factory ProfileSettingsState.initial() {
    return const ProfileSettingsState(
      defaultTeacherLanguage: Language.english,
      todayDuration: Duration.zero,
      totalDuration: Duration.zero,
      isLoading: false,
    );
  }

  const ProfileSettingsState({
    required this.defaultTeacherLanguage,
    required this.todayDuration,
    required this.totalDuration,
    required this.isLoading,
  });

  final Language defaultTeacherLanguage;
  final Duration todayDuration;
  final Duration totalDuration;
  final bool isLoading;

  ProfileSettingsState copyWith({
    Language? defaultTeacherLanguage,
    Duration? todayDuration,
    Duration? totalDuration,
    bool? isLoading,
  }) {
    return ProfileSettingsState(
      defaultTeacherLanguage:
          defaultTeacherLanguage ?? this.defaultTeacherLanguage,
      todayDuration: todayDuration ?? this.todayDuration,
      totalDuration: totalDuration ?? this.totalDuration,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
