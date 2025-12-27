import 'package:flutter/cupertino.dart';

import '../../../core/domain/enums/language.dart';

class ProfileNotifier with ChangeNotifier {
  ProfileNotifier();

  ProfileSettingsState _state = ProfileSettingsState.initial();
  ProfileSettingsState get state => _state;

  void setState(ProfileSettingsState value) {
    _state = value;
    notifyListeners();
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
