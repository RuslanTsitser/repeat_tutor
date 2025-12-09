import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/state_managers.dart';
import '../../infrastructure/use_case.dart';
import '../notifiers/realtime_call_notifier.dart';

@RoutePage()
class RealtimeSessionDetailScreen extends ConsumerStatefulWidget {
  const RealtimeSessionDetailScreen({super.key});

  @override
  ConsumerState<RealtimeSessionDetailScreen> createState() =>
      _RealtimeSessionDetailScreenState();
}

class _RealtimeSessionDetailScreenState
    extends ConsumerState<RealtimeSessionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(realtimeCallProvider);
    final state = notifier.state;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Реалтайм звонок'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.error != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemRed.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.error!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 40, 27, 26),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    _StatusCard(state: state),
                    const SizedBox(height: 16),
                    _AudioLevelCard(state: state),
                    const SizedBox(height: 16),
                    _MessagesCard(state: state),
                  ],
                ),
              ),
            ),
            _ControlButtons(state: state),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.state});
  final RealtimeCallState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Статус',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text('Подключен: ${state.isConnected ? "Да" : "Нет"}'),
          Text('Запись: ${state.isRecording ? "Да" : "Нет"}'),
          Text('Воспроизведение: ${state.isPlaying ? "Да" : "Нет"}'),
        ],
      ),
    );
  }
}

class _AudioLevelCard extends StatelessWidget {
  const _AudioLevelCard({required this.state});
  final RealtimeCallState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Уровень звука',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: state.audioLevel,
              backgroundColor: CupertinoColors.systemGrey4,
              valueColor: const AlwaysStoppedAnimation<Color>(
                CupertinoColors.activeGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessagesCard extends StatelessWidget {
  const _MessagesCard({required this.state});
  final RealtimeCallState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Сообщения',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (state.receivedMessages.isEmpty)
            const Text(
              'Нет сообщений',
              style: TextStyle(color: CupertinoColors.systemGrey),
            )
          else
            ...state.receivedMessages.map(
              (message) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
        ],
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
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.separator,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!state.isConnected && !state.isConnecting)
            CupertinoButton(
              onPressed: state.session == null
                  ? null
                  : () {
                      ref.read(connectRealtimeSessionUseCaseProvider).execute();
                    },
              child: const Text('Подключиться'),
            )
          else if (state.isConnecting)
            const CupertinoActivityIndicator()
          else
            CupertinoButton(
              color: CupertinoColors.systemRed,
              onPressed: () {
                ref.read(disconnectRealtimeSessionUseCaseProvider).execute();
              },
              child: const Text('Отключиться'),
            ),
        ],
      ),
    );
  }
}
