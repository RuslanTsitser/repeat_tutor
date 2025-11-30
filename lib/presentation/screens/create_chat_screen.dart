import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/core.dart';

@RoutePage()
class CreateChatScreen extends ConsumerStatefulWidget {
  const CreateChatScreen({super.key});

  @override
  ConsumerState<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends ConsumerState<CreateChatScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Новый чат'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => ref.read(routerProvider).pop(),
          child: const Text('Отмена'),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // TODO: Implement onCreateChat
          },
          child: const Text('Создать'),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
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
                        // controller: _nameController,
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
                      prefix: const Text('Тема'),
                      child: CupertinoTextFormFieldRow(
                        // controller: TextEditingController(),
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
                        onPressed: () {
                          // TODO: Implement onShowLanguageSheet
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('LocalizedName'),
                            Icon(
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
                        onPressed: () {
                          // TODO: Implement onShowLevelSheet
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('LocalizedName'),
                            Icon(
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
}
