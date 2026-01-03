import 'package:flutter/cupertino.dart';

import 'onboarding_back_button.dart';

class OnboardingBackButtonWrapper extends StatelessWidget {
  const OnboardingBackButtonWrapper({
    super.key,
    required this.child,
    this.onPrevious,
  });

  final Widget child;
  final VoidCallback? onPrevious;

  static const double _topPadding = 8.0;
  static const double _leftPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (onPrevious != null)
          Positioned(
            top: _topPadding,
            left: _leftPadding,
            child: SafeArea(
              bottom: false,
              child: OnboardingBackButton(onPrevious: onPrevious!),
            ),
          ),
      ],
    );
  }
}

