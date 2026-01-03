import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/localization/generated/l10n.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../../../../../infrastructure/use_case.dart';

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({super.key});

  @override
  ConsumerState<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage>
    with SingleTickerProviderStateMixin {
  static const int _totalTexts = 4;
  static const Duration _animationDuration = Duration(seconds: 6);

  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _progressAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOut,
          ),
        );

    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _startLoading();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _startLoading() async {
    _animationController.forward();

    // Ждем завершения анимации
    await _animationController.forward();

    if (!mounted) return;

    try {
      await ref
          .read(openChatAfterOnboardingUseCaseProvider)
          .openChatAfterOnboarding();
    } catch (e) {
      // Обработка ошибки создания чата
    }
  }

  int get _currentTextIndex {
    final progress = _progressAnimation.value;
    return (progress * _totalTexts).floor().clamp(0, _totalTexts - 1);
  }

  String _getLoadingText(BuildContext context) {
    final s = S.of(context);
    switch (_currentTextIndex) {
      case 0:
        return s.onboarding6LoadingText1;
      case 1:
        return s.onboarding6LoadingText2;
      case 2:
        return s.onboarding6LoadingText3;
      case 3:
        return s.onboarding6LoadingText4;
      default:
        return s.onboarding6LoadingText1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progressAnimation.value;
    final progressPercent = (progress * 100).round();

    return Container(
      color: AppColors.backgroundLight,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CircularProgressWidget(
              progress: progress,
              progressPercent: progressPercent,
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: Text(
                  _getLoadingText(context),
                  key: ValueKey<int>(_currentTextIndex),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.inter16w400
                      .copyWith(
                        color: AppColors.textPrimary,
                      )
                      .scaled(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularProgressWidget extends StatelessWidget {
  final double progress;
  final int progressPercent;

  const _CircularProgressWidget({
    required this.progress,
    required this.progressPercent,
  });

  static const double _size = 120.0;
  static const double _strokeWidth = 8.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size,
      height: _size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Фоновый круг
          const SizedBox(
            width: _size,
            height: _size,
            child: material.CircularProgressIndicator(
              value: 1.0,
              strokeWidth: _strokeWidth,
              backgroundColor: AppColors.divider,
              valueColor: material.AlwaysStoppedAnimation<Color>(
                AppColors.divider,
              ),
            ),
          ),
          // Прогресс
          SizedBox(
            width: _size,
            height: _size,
            child: material.CircularProgressIndicator(
              value: progress,
              strokeWidth: _strokeWidth,
              backgroundColor: material.Colors.transparent,
              valueColor: const material.AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
              strokeCap: material.StrokeCap.round,
            ),
          ),
          // Процент в центре
          Text(
            '$progressPercent%',
            style: AppTextStyle.inter24w700
                .copyWith(
                  color: AppColors.textPrimary,
                )
                .scaled(context),
          ),
        ],
      ),
    );
  }
}
