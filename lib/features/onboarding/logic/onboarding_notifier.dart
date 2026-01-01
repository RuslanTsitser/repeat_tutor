import 'package:flutter/cupertino.dart';

class OnboardingNotifier with ChangeNotifier {
  OnboardingNotifier();

  OnboardingState _state = OnboardingState.initial();
  OnboardingState get state => _state;

  /// Устанавливает начальное состояние для онбординга без уведомления слушателей
  void setInitialState({
    required int totalSteps,
    required String onboardingName,
  }) {
    _state = state.copyWith(
      currentStep: 0,
      totalSteps: totalSteps,
      onboardingName: onboardingName,
    );
  }

  /// Устанавливает новое состояние для онбординга и уведомляет слушателей
  void setState(OnboardingState value) {
    _state = value;
    notifyListeners();
  }

  /// Переходит на следующий шаг онбординга
  void nextStep() {
    if (state.isLastStep) {
      return;
    }
    setState(state.copyWith(currentStep: state.currentStep + 1));
  }

  /// Переходит на предыдущий шаг онбординга
  void previousStep() {
    if (state.isFirstStep) {
      return;
    }
    setState(state.copyWith(currentStep: state.currentStep - 1));
  }
}

class OnboardingState {
  factory OnboardingState.initial() {
    return const OnboardingState(
      currentStep: 0,
      totalSteps: 3,
      onboardingName: 'default',
    );
  }
  const OnboardingState({
    required this.onboardingName,
    required this.currentStep,
    required this.totalSteps,
  });
  final String onboardingName;
  final int currentStep;
  final int totalSteps;

  bool get isLastStep => currentStep == totalSteps - 1;
  bool get isFirstStep => currentStep == 0;

  OnboardingState copyWith({
    String? onboardingName,
    int? currentStep,
    int? totalSteps,
  }) {
    return OnboardingState(
      onboardingName: onboardingName ?? this.onboardingName,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
    );
  }
}
