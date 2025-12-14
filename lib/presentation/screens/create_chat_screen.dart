import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/session_difficulty_level.dart';
import '../../domain/models/session_language.dart';
import '../../infrastructure/core.dart';

class CreateChatEntity {
  const CreateChatEntity({
    required this.language,
    required this.level,
    required this.teacherLanguage,
    required this.topic,
  });
  final SessionLanguage language;
  final SessionDifficultyLevel level;
  final SessionLanguage? teacherLanguage;
  final String topic;

  CreateChatEntity copyWith({
    SessionLanguage? language,
    SessionDifficultyLevel? level,
    SessionLanguage? teacherLanguage,
    String? topic,
  }) {
    return CreateChatEntity(
      language: language ?? this.language,
      level: level ?? this.level,
      teacherLanguage: teacherLanguage ?? this.teacherLanguage,
      topic: topic ?? this.topic,
    );
  }
}

final createChatEntityProvider = StateProvider((ref) {
  return const CreateChatEntity(
    language: SessionLanguage.english,
    level: SessionDifficultyLevel.beginner,
    teacherLanguage: null,
    topic: 'Разговор о путешествиях',
  );
});

@RoutePage()
class CreateChatScreen extends ConsumerWidget {
  const CreateChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entity = ref.watch(createChatEntityProvider);

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
          onPressed: () => ref.read(routerProvider).pop(entity),
          child: const Text('Создать'),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              CupertinoTextFormFieldRow(
                initialValue: entity.topic,
                placeholder: 'Разговор о путешествиях',
                padding: EdgeInsets.zero,
                onChanged: (value) =>
                    ref.read(createChatEntityProvider.notifier).state = ref
                        .read(createChatEntityProvider.notifier)
                        .state
                        .copyWith(topic: value),
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
                  onSelectedItemChanged: (index) =>
                      ref.read(createChatEntityProvider.notifier).state = ref
                          .read(createChatEntityProvider.notifier)
                          .state
                          .copyWith(language: SessionLanguage.values[index]),
                  children: SessionLanguage.values.map((language) {
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
                  onSelectedItemChanged: (index) => ref
                      .read(createChatEntityProvider)
                      .copyWith(
                        level: SessionDifficultyLevel.values[index],
                      ),
                  children: SessionDifficultyLevel.values.map((level) {
                    return Center(
                      child: Text(level.localizedName),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CupertinoSwitch(
                      value: entity.teacherLanguage != null,
                      onChanged: (value) {
                        if (value) {
                          // Включаем режим с языком преподавателя, выбираем первый язык по умолчанию
                          ref
                              .read(createChatEntityProvider.notifier)
                              .state = ref
                              .read(createChatEntityProvider.notifier)
                              .state
                              .copyWith(
                                teacherLanguage: SessionLanguage.english,
                              );
                        } else {
                          // Выключаем режим
                          ref
                              .read(createChatEntityProvider.notifier)
                              .state = ref
                              .read(createChatEntityProvider.notifier)
                              .state
                              .copyWith(teacherLanguage: null);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
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
              if (entity.teacherLanguage != null) ...[
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
                      initialItem: SessionLanguage.values.indexOf(
                        entity.teacherLanguage!,
                      ),
                    ),
                    onSelectedItemChanged: (index) =>
                        ref.read(createChatEntityProvider.notifier).state = ref
                            .read(createChatEntityProvider.notifier)
                            .state
                            .copyWith(
                              teacherLanguage: SessionLanguage.values[index],
                            ),
                    children: SessionLanguage.values.map((language) {
                      return Center(
                        child: Text(language.localizedName),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
