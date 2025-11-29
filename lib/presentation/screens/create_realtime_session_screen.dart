import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';
import '../../domain/models/session_settings.dart';
import '../../infrastructure/di.dart';
import '../notifiers/realtime_session_notifier.dart';
import 'realtime_session_detail_screen.dart';

class CreateRealtimeSessionScreen extends ConsumerStatefulWidget {
  const CreateRealtimeSessionScreen({super.key});

  @override
  ConsumerState<CreateRealtimeSessionScreen> createState() =>
      _CreateRealtimeSessionScreenState();
}

class _CreateRealtimeSessionScreenState
    extends ConsumerState<CreateRealtimeSessionScreen> {
  SessionLanguage _selectedLanguage = SessionLanguage.japanese;
  SessionDifficultyLevel _selectedLevel = SessionDifficultyLevel.beginner;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch<RealtimeSessionListNotifier>(
      realtimeSessionListProvider,
    );

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Создать сессию'),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
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
                    setState(() {
                      _selectedLanguage = SessionLanguage.values[index];
                    });
                  },
                  children: SessionLanguage.values.map((language) {
                    return Center(
                      child: Text(_getLanguageName(language)),
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
                    setState(() {
                      _selectedLevel = SessionDifficultyLevel.values[index];
                    });
                  },
                  children: SessionDifficultyLevel.values.map((level) {
                    return Center(
                      child: Text(_getLevelName(level)),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),
              CupertinoButton.filled(
                onPressed: notifier.isLoading
                    ? null
                    : () async {
                        final settings = SessionSettings(
                          language: _selectedLanguage,
                          level: _selectedLevel,
                        );
                        final session = await notifier.createSession(settings);
                        if (session != null && mounted) {
                          Navigator.of(context).pushReplacement(
                            CupertinoPageRoute<void>(
                              builder: (context) =>
                                  RealtimeSessionDetailScreen(session: session),
                            ),
                          );
                        }
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

  String _getLanguageName(SessionLanguage language) {
    switch (language) {
      case SessionLanguage.japanese:
        return 'Японский';
      case SessionLanguage.portugueseEuropean:
        return 'Португальский (Европа)';
      case SessionLanguage.portugueseBrazilian:
        return 'Португальский (Бразилия)';
      case SessionLanguage.spanish:
        return 'Испанский';
      case SessionLanguage.french:
        return 'Французский';
      case SessionLanguage.italian:
        return 'Итальянский';
      case SessionLanguage.german:
        return 'Немецкий';
      case SessionLanguage.russian:
        return 'Русский';
      case SessionLanguage.english:
        return 'Английский';
    }
  }

  String _getLevelName(SessionDifficultyLevel level) {
    switch (level) {
      case SessionDifficultyLevel.beginner:
        return 'Начинающий';
      case SessionDifficultyLevel.intermediate:
        return 'Средний';
      case SessionDifficultyLevel.advanced:
        return 'Продвинутый';
    }
  }
}
