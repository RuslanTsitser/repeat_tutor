import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';

class CreateChatBottomSheet extends ConsumerWidget {
  const CreateChatBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entity = ref.watch(createChatProvider);

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('Новый чат'),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => ref.read(routerProvider).pop(),
              child: const Text('Отмена'),
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => ref.read(routerProvider).pop(entity.state),
              child: const Text('Создать'),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                controller: scrollController,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Тема',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CupertinoTextFormFieldRow(
                    initialValue: entity.state.topic,
                    placeholder: 'Разговор о путешествиях',
                    padding: EdgeInsets.zero,
                    onChanged: (value) {
                      entity.setState(entity.state.copyWith(topic: value));
                    },

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Тема обязательна';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Язык',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: CupertinoPicker(
                      looping: true,
                      itemExtent: 44,
                      onSelectedItemChanged: (index) {
                        entity.setState(
                          entity.state.copyWith(
                            language: Language.values[index],
                          ),
                        );
                      },
                      children: Language.values.map((language) {
                        return Center(
                          child: Text(language.localizedName),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Уровень',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: CupertinoPicker(
                      itemExtent: 44,
                      onSelectedItemChanged: (index) {
                        entity.setState(
                          entity.state.copyWith(
                            level: DifficultyLevel.values[index],
                          ),
                        );
                      },
                      children: DifficultyLevel.values.map((level) {
                        return Center(
                          child: Text(level.localizedName),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Режим с языком преподавателя',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    'Язык преподавателя',
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
                      scrollController: FixedExtentScrollController(
                        initialItem: Language.values.indexOf(
                          entity.state.teacherLanguage,
                        ),
                      ),
                      onSelectedItemChanged: (index) {
                        entity.setState(
                          entity.state.copyWith(
                            teacherLanguage: Language.values[index],
                          ),
                        );
                      },
                      children: Language.values.map((language) {
                        return Center(
                          child: Text(language.localizedName),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
