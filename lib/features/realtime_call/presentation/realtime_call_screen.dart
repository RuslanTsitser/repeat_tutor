import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/generated/l10n.dart';
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
  Duration _callDuration = Duration.zero;
  DateTime? _callStartTime;

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
    final notifier = ref.read(realtimeCallProvider);
    final state = notifier.state;

    if (state.status == RealtimeCallStatus.connected &&
        _callStartTime == null) {
      _callStartTime = DateTime.now();
    }

    _callTimer?.cancel();
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        final notifier = ref.read(realtimeCallProvider);
        final state = notifier.state;

        if (state.status == RealtimeCallStatus.connected) {
          _callStartTime ??= DateTime.now();
          _callDuration = DateTime.now().difference(_callStartTime!);
        } else {
          _callStartTime = null;
          _callDuration = Duration.zero;
        }

        setState(() {});
      }
    });
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String _getLanguageInitial(RealtimeCallState state) {
    if (state.session == null) return 'E';
    final languageName = state.session!.language.localizedName;
    if (languageName.isEmpty) return 'E';
    return languageName[0].toUpperCase();
  }

  String _getCallTitle(RealtimeCallState state) {
    if (state.session == null) return 'English A1 – Free time';
    final topic = state.session!.topic;
    final language = state.session!.language.localizedName;
    final levelLabel = state.session!.level.shortLocalizedName;
    return '$topic $language $levelLabel';
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(realtimeCallProvider);
    final state = notifier.state;

    // Обновляем таймер при изменении статуса
    if (state.status == RealtimeCallStatus.connected &&
        _callStartTime == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startTimer();
      });
    } else if (state.status != RealtimeCallStatus.connected &&
        _callStartTime != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _callStartTime = null;
        _callDuration = Duration.zero;
        setState(() {});
      });
    }

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Аватар с буквой
                    Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        color: const Color(0xFF155DFC),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: CupertinoColors.black.withValues(
                              alpha: 0.05,
                            ),
                            blurRadius: 4,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _getLanguageInitial(state),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.white,
                            letterSpacing: 0.3516,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Заголовок
                    Text(
                      _getCallTitle(state),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF101828),
                        letterSpacing: 0.0703,
                        height: 32 / 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Подзаголовок
                    Text(
                      S.of(context).voiceCallInProgress,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF4A5565),
                        letterSpacing: -0.3125,
                        height: 24 / 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Таймер
                    Text(
                      _formatDuration(_callDuration),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF101828),
                        letterSpacing: 0.3691,
                        height: 40 / 36,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Статус подключения
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: state.status == RealtimeCallStatus.connected
                                ? const Color(0xFF00C950)
                                : const Color(0xFF4A5565),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          state.status == RealtimeCallStatus.connected
                              ? S.of(context).connected
                              : S.of(context).disconnected,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF4A5565),
                            letterSpacing: -0.3125,
                            height: 24 / 16,
                          ),
                        ),
                      ],
                    ),
                    if (state.error != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemRed.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.error!,
                          style: const TextStyle(
                            color: Color(0xFF82181A),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            // Кнопки управления
            _ControlButtons(state: state),
          ],
        ),
      ),
    );
  }
}

class _ControlButtons extends ConsumerWidget {
  const _ControlButtons({required this.state});
  final RealtimeCallState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Кнопка микрофона
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: state.status == RealtimeCallStatus.connected
                ? () => ref.read(startRealtimeCallUseCaseProvider).toggleMic()
                : null,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 0.714,
                ),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: CupertinoColors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Icon(
                state.isMuted ? CupertinoIcons.mic_slash : CupertinoIcons.mic,
                color: const Color(0xFF101828),
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 32),
          // Кнопка завершения звонка
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: state.status == RealtimeCallStatus.connected
                ? () => ref.read(routerProvider).pop()
                : null,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFE7000B),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: CupertinoColors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.phone_down,
                color: CupertinoColors.white,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
