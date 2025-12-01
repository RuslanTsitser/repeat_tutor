import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/router/router.dart';
import '../../domain/models/realtime_session.dart';
import '../../infrastructure/core.dart';
import '../../infrastructure/state_managers.dart';
import '../../infrastructure/use_case.dart';

@RoutePage()
class RealtimeSessionListScreen extends ConsumerStatefulWidget {
  const RealtimeSessionListScreen({super.key});

  @override
  ConsumerState<RealtimeSessionListScreen> createState() =>
      _RealtimeSessionListScreenState();
}

class _RealtimeSessionListScreenState
    extends ConsumerState<RealtimeSessionListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getRealtimeSessionsUseCaseProvider).execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(realtimeSessionListProvider);
    final state = notifier.state;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Реалтайм звонки'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            ref.read(routerProvider).push(const CreateRealtimeSessionRoute());
          },
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: state.isLoading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : state.error != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.exclamationmark_triangle,
                      size: 64,
                      color: CupertinoColors.systemRed,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ошибка загрузки сессий',
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.error!,
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CupertinoButton.filled(
                      onPressed: () {
                        ref.read(getRealtimeSessionsUseCaseProvider).execute();
                      },
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              )
            : state.sessions.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.phone,
                      size: 64,
                      color: CupertinoColors.systemGrey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Нет сессий',
                      style: TextStyle(
                        fontSize: 18,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: state.sessions.length,
                itemBuilder: (context, index) {
                  final session = state.sessions[index];
                  return _RealtimeSessionListItem(
                    session: session,
                    onTap: () {
                      ref
                          .read(openRealtimeSessionDetailUseCaseProvider)
                          .execute(session.id);
                    },
                    onDelete: () {
                      ref
                          .read(deleteRealtimeSessionUseCaseProvider)
                          .execute(session.id);
                    },
                  );
                },
              ),
      ),
    );
  }
}

class _RealtimeSessionListItem extends StatelessWidget {
  const _RealtimeSessionListItem({
    required this.session,
    required this.onTap,
    required this.onDelete,
  });
  final RealtimeSession session;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text('Сессия ${session.id.substring(0, 8)}'),
      subtitle: Text(
        'Создана: ${_formatDate(session.createdAt)}',
      ),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onDelete,
        child: const Icon(
          CupertinoIcons.delete,
          color: CupertinoColors.systemRed,
        ),
      ),
      onTap: onTap,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}
