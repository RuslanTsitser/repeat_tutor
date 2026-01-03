import 'package:flutter/cupertino.dart';

import '../../../core/domain/enums/language.dart';

enum PremiumStatus {
  free,
  pro,
  gold,
}

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
      defaultTeacherLanguage: null,
      defaultLanguageToLearn: null,
      defaultLanguage: Language.english,
      todayDuration: Duration.zero,
      totalDuration: Duration.zero,
      isLoading: false,
      premiumStatus: PremiumStatus.free,
    );
  }

  const ProfileSettingsState({
    required this.defaultTeacherLanguage,
    required this.defaultLanguageToLearn,
    required this.defaultLanguage,
    required this.todayDuration,
    required this.totalDuration,
    required this.isLoading,
    required this.premiumStatus,
  });

  final Language? defaultTeacherLanguage;
  final Language? defaultLanguageToLearn;
  final Language defaultLanguage;
  final Duration todayDuration;
  final Duration totalDuration;
  final bool isLoading;
  final PremiumStatus premiumStatus;

  ProfileSettingsState copyWith({
    Language? defaultTeacherLanguage,
    Language? defaultLanguageToLearn,
    Language? defaultLanguage,
    Duration? todayDuration,
    Duration? totalDuration,
    bool? isLoading,
    PremiumStatus? premiumStatus,
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
      premiumStatus: premiumStatus ?? this.premiumStatus,
    );
  }
}
