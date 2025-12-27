import 'package:flutter/material.dart';

class HomeScreenNotifier with ChangeNotifier {
  HomeScreenNotifier();

  HomeScreenState _state = HomeScreenState.initial();
  HomeScreenState get state => _state;

  void setState(HomeScreenState value) {
    _state = value;
    notifyListeners();
  }
}

enum HomeScreenTab {
  loading,
  onboarding,
  home,
}

class HomeScreenState {
  factory HomeScreenState.initial() {
    return const HomeScreenState(tab: HomeScreenTab.loading);
  }
  const HomeScreenState({
    required this.tab,
  });
  final HomeScreenTab tab;

  HomeScreenState copyWith({
    HomeScreenTab? tab,
  }) {
    return HomeScreenState(
      tab: tab ?? this.tab,
    );
  }
}
