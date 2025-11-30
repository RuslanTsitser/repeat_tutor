import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';
import '../../infrastructure/core.dart';
import '../../infrastructure/handlers.dart';
import '../../infrastructure/state_managers.dart';

@RoutePage()
class CreateChatScreen extends ConsumerStatefulWidget {
  const CreateChatScreen({super.key});

  @override
  ConsumerState<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends ConsumerState<CreateChatScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _topicController = TextEditingController();
  final _avatarUrlController = TextEditingController();
  bool _isCreating = false;
  SessionLanguage _selectedLanguage = SessionLanguage.english;
  SessionDifficultyLevel _selectedLevel = SessionDifficultyLevel.beginner;

  @override
  void dispose() {
    _nameController.dispose();
    _topicController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  Future<void> _createChat() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isCreating = true;
    });

    final chatEventHandler = ref.read(chatEventHandlerProvider);
    await chatEventHandler.onCreateChatPressed(
      name: _nameController.text.trim(),
      language: _selectedLanguage,
      difficulty: _selectedLevel,
      topic: _topicController.text.trim(),
    );

    if (!mounted) return;

    final chatNotifier = ref.read(chatProvider);
    if (chatNotifier.error != null) {
      _showErrorDialog(chatNotifier.error!);
      chatNotifier.setError(null); // Очищаем ошибку после показа
    } else {
      ref.read(routerProvider).pop();
    }

    setState(() {
      _isCreating = false;
    });
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => ref.read(routerProvider).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Новый чат'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _isCreating ? null : () => ref.read(routerProvider).pop(),
          child: const Text('Отмена'),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _isCreating ? null : _createChat,
          child: _isCreating
              ? const CupertinoActivityIndicator()
              : const Text('Создать'),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                CupertinoFormSection(
                  header: const Text('Информация о чате'),
                  children: [
                    CupertinoFormRow(
                      prefix: const Text('Название'),
                      child: CupertinoTextFormFieldRow(
                        controller: _nameController,
                        placeholder: 'Введите название чата',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Название чата обязательно';
                          }
                          return null;
                        },
                      ),
                    ),
                    CupertinoFormRow(
                      prefix: const Text('Аватар (URL)'),
                      child: CupertinoTextFormFieldRow(
                        controller: _avatarUrlController,
                        placeholder: 'https://example.com/avatar.png',
                        keyboardType: TextInputType.url,
                      ),
                    ),
                    CupertinoFormRow(
                      prefix: const Text('Тема'),
                      child: CupertinoTextFormFieldRow(
                        controller: _topicController,
                        placeholder: 'Разговор о путешествиях',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Тема обязательна';
                          }
                          return null;
                        },
                      ),
                    ),
                    CupertinoFormRow(
                      prefix: const Text('Язык'),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _isCreating ? null : _showLanguageSheet,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_selectedLanguage.localizedName),
                            const Icon(
                              CupertinoIcons.chevron_down,
                              size: 16,
                              color: CupertinoColors.systemGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    CupertinoFormRow(
                      prefix: const Text('Сложность'),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _isCreating ? null : _showLevelSheet,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_mapLevelToLabel(_selectedLevel)),
                            const Icon(
                              CupertinoIcons.chevron_down,
                              size: 16,
                              color: CupertinoColors.systemGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Создайте новый чат для общения с репетитором или для изучения материала.',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageSheet() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text('Выберите язык'),
        actions: SessionLanguage.values
            .map(
              (language) => CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    _selectedLanguage = language;
                  });
                  ref.read(routerProvider).pop();
                },
                child: Text(language.localizedName),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => ref.read(routerProvider).pop(),
          child: const Text('Отмена'),
        ),
      ),
    );
  }

  void _showLevelSheet() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text('Выберите уровень'),
        actions: SessionDifficultyLevel.values
            .map(
              (level) => CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    _selectedLevel = level;
                  });
                  ref.read(routerProvider).pop();
                },
                child: Text(_mapLevelToLabel(level)),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => ref.read(routerProvider).pop(),
          child: const Text('Отмена'),
        ),
      ),
    );
  }

  String _mapLevelToLabel(SessionDifficultyLevel level) {
    switch (level) {
      case SessionDifficultyLevel.beginner:
        return 'Начальный';
      case SessionDifficultyLevel.intermediate:
        return 'Средний';
      case SessionDifficultyLevel.advanced:
        return 'Продвинутый';
    }
  }
}
