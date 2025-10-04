import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/chat.dart';
import '../../infrastructure/di.dart';
import '../notifiers/chat_notifier.dart';

class CreateChatScreen extends ConsumerStatefulWidget {
  const CreateChatScreen({super.key});

  @override
  ConsumerState<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends ConsumerState<CreateChatScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _avatarUrlController = TextEditingController();
  bool _isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
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

    try {
      final chat = Chat(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        lastMessage: 'Чат создан',
        time: DateTime.now().toIso8601String(),
        unreadCount: 0,
        avatarUrl: _avatarUrlController.text.trim(),
      );

      final chatNotifier = ref.read<ChatNotifier>(chatProvider);
      await chatNotifier.createChat(chat);

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Ошибка создания чата: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
      }
    }
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
            onPressed: () => Navigator.of(context).pop(),
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
          onPressed: _isCreating ? null : () => Navigator.of(context).pop(),
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
}
