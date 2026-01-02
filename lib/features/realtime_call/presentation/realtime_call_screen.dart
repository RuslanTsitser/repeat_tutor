import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../logic/realtime_call_notifier.dart';

@RoutePage()
class RealtimeCallScreen extends ConsumerStatefulWidget {
  const RealtimeCallScreen({super.key});

  @override
  ConsumerState<RealtimeCallScreen> createState() => _RealtimeCallScreenState();
}

class _RealtimeCallScreenState extends ConsumerState<RealtimeCallScreen> {
  Timer? _callTimer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _callTimer?.cancel();
    _callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _onTick();
    });
  }

  Future<void> _onTick() async {
    ref.read(startRealtimeCallUseCaseProvider).addSecondCallDuration();
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: AppColors.backgroundLight,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _CallContent(),
            ),
            _ControlButtons(),
          ],
        ),
      ),
    );
  }
}

class _CallContent extends ConsumerWidget {
  const _CallContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(realtimeCallProvider).state;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _LanguageAvatar(),
          const SizedBox(height: 24),
          const _CallTitle(),
          const SizedBox(height: 32),
          const _CallTimer(),
          if (state.error != null) ...[
            const SizedBox(height: 16),
            _ErrorBanner(error: state.error!),
          ],
        ],
      ),
    );
  }
}

class _LanguageAvatar extends ConsumerWidget {
  const _LanguageAvatar();

  static const double _size = 128.0;
  static const List<BoxShadow> _shadows = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 16.0,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 4.0,
      offset: Offset(0, -4),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: _size,
      height: _size,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        boxShadow: _shadows,
      ),
      clipBehavior: Clip.hardEdge,
      child: Assets.appIcon.image(
        width: _size,
        height: _size,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _CallTitle extends ConsumerWidget {
  const _CallTitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(realtimeCallProvider).state;
    final topic = state.session?.topic ?? '';
    final language = state.session?.language.localizedName ?? '';
    final level = state.session?.level.shortLocalizedName ?? '';

    return Column(
      children: [
        Text(
          topic,
          style: AppTextStyle.inter24w500.copyWith(
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '$language $level',
          style: AppTextStyle.inter16w400.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _CallTimer extends ConsumerWidget {
  const _CallTimer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(realtimeCallProvider).state;
    final duration = state.callDuration;
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return Text(
      '$minutes:$seconds',
      style: AppTextStyle.inter32w500,
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.error});

  final String error;

  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 8.0;
  static const double _borderRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.systemRed.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Text(
        error,
        style: AppTextStyle.inter14w400.copyWith(
          color: CupertinoColors.systemRed,
        ),
      ),
    );
  }
}

class _ControlButtons extends ConsumerWidget {
  const _ControlButtons();

  static const double _horizontalPadding = 24.0;
  static const double _verticalPadding = 32.0;
  static const double _spacing = 32.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(realtimeCallProvider).state;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _MicButton(
            isMuted: state.isMuted,
            isEnabled: state.status == RealtimeCallStatus.connected,
            onPressed: () =>
                ref.read(startRealtimeCallUseCaseProvider).toggleMic(),
          ),
          const SizedBox(width: _spacing),
          _EndCallButton(
            isEnabled: state.status == RealtimeCallStatus.connected,
            onPressed: () => ref.read(routerProvider).pop(),
          ),
        ],
      ),
    );
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton({
    required this.isMuted,
    required this.isEnabled,
    required this.onPressed,
  });

  final bool isMuted;
  final bool isEnabled;
  final VoidCallback onPressed;

  static const double _size = 64.0;
  static const List<BoxShadow> _shadows = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 16.0,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 4.0,
      offset: Offset(0, -4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: isEnabled ? onPressed : null,
      child: Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.divider, width: 0.714),
          boxShadow: _shadows,
        ),
        child: Icon(
          isMuted ? CupertinoIcons.mic_slash : CupertinoIcons.mic,
          color: AppColors.textPrimary,
          size: 32.0,
        ),
      ),
    );
  }
}

class _EndCallButton extends StatelessWidget {
  const _EndCallButton({
    required this.isEnabled,
    required this.onPressed,
  });

  final bool isEnabled;
  final VoidCallback onPressed;

  static const double _size = 64.0;
  static const Color _redColor = Color(0xFFE7000B);
  static const List<BoxShadow> _shadows = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 16.0,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 4.0,
      offset: Offset(0, -4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: isEnabled ? onPressed : null,
      child: Container(
        width: _size,
        height: _size,
        decoration: const BoxDecoration(
          color: _redColor,
          shape: BoxShape.circle,
          boxShadow: _shadows,
        ),
        child: const Icon(
          CupertinoIcons.phone_down,
          color: AppColors.surface,
          size: 32.0,
        ),
      ),
    );
  }
}
