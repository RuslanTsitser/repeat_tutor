import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';
import '../../infrastructure/core.dart';
import '../../infrastructure/state_managers.dart';
import '../../infrastructure/use_case.dart';

@RoutePage()
class CreateRealtimeSessionScreen extends ConsumerStatefulWidget {
  const CreateRealtimeSessionScreen({super.key});

  @override
  ConsumerState<CreateRealtimeSessionScreen> createState() =>
      _CreateRealtimeSessionScreenState();
}

class _CreateRealtimeSessionScreenState
    extends ConsumerState<CreateRealtimeSessionScreen> {
  @override
  Widget build(BuildContext context) {
    final formNotifier = ref.watch(createRealtimeSessionProvider);
    final formState = formNotifier.state;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Создать сессию'),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => ref.read(routerProvider).pop(),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (formState.error != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    formState.error!,
                    style: const TextStyle(
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              const Text(
                'Язык',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: CupertinoPicker(
                  looping: true,
                  itemExtent: 44,
                  onSelectedItemChanged: (index) {
                    ref
                        .read(createRealtimeSessionProvider)
                        .selectLanguage(SessionLanguage.values[index]);
                  },
                  children: SessionLanguage.values.map((language) {
                    return Center(
                      child: Text(language.localizedName),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Уровень',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: CupertinoPicker(
                  itemExtent: 44,
                  onSelectedItemChanged: (index) {
                    ref
                        .read(createRealtimeSessionProvider)
                        .selectLevel(SessionDifficultyLevel.values[index]);
                  },
                  children: SessionDifficultyLevel.values.map((level) {
                    return Center(
                      child: Text(level.localizedName),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),
              CupertinoButton.filled(
                onPressed: formState.isLoading
                    ? null
                    : () {
                        ref
                            .read(createRealtimeSessionUseCaseProvider)
                            .execute();
                      },
                child: formState.isLoading
                    ? const CupertinoActivityIndicator()
                    : const Text('Создать сессию'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
