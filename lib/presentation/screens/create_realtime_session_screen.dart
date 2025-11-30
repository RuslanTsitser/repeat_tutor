import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';
import '../../infrastructure/core.dart';
import '../../infrastructure/state_managers.dart';

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
    final notifier = ref.watch(realtimeSessionListProvider);

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
                    // TODO: Implement onSelectedLanguage
                  },
                  children: SessionLanguage.values.map((language) {
                    return const Center(
                      child: Text('LocalizedName'),
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
                    // TODO: Implement onSelectedLevel
                  },
                  children: SessionDifficultyLevel.values.map((level) {
                    return const Center(
                      child: Text('LocalizedName'),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),
              CupertinoButton.filled(
                onPressed: notifier.isLoading
                    ? null
                    : () {
                        // TODO: Implement onCreateSession
                      },
                child: notifier.isLoading
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
