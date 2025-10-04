# Dependency Injection (DI) Structure

Эта документация описывает структуру управления зависимостями в приложении Repeat Tutor.

## 📁 Структура

```text
lib/infrastructure/di/
├── di.dart          # Главный файл экспорта всех провайдеров
├── providers.dart   # Провайдеры состояния (ChangeNotifier)
└── services.dart    # Сервисы и конфигурация
```

## 📋 Файлы

### `di.dart`

Главный файл, который экспортирует все провайдеры и сервисы.
Импортируйте только этот файл в экранах и виджетах.

```dart
export 'providers.dart';
export 'services.dart';
```

### `providers.dart`

Содержит все провайдеры состояния:

- `chatListProvider` - управление списком чатов
- `messageListProvider` - управление сообщениями в чате

#### ChatListNotifier

```dart
class ChatListNotifier extends ChangeNotifier {
  List<Chat> get chats => _chats;
  
  void updateChatLastMessage(String chatId, String message, String time);
  void markAsRead(String chatId);
}
```

#### MessageListNotifier

```dart
class MessageListNotifier extends ChangeNotifier {
  List<Message> get messages => _messages;
  
  void addMessage(String text);
  void clearMessages();
}
```

### `services.dart`

Содержит сервисы и конфигурацию:

- `appConfigProvider` - конфигурация приложения
- Примеры сервисов для будущего расширения

#### AppConfig

```dart
class AppConfig {
  final String apiBaseUrl;
  final bool isDebugMode;
  final int maxMessageLength;
}
```

## 🚀 Использование

### В экранах

```dart
import '../infrastructure/di/di.dart';

class ChatListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatListNotifier = ref.watch<ChatListNotifier>(chatListProvider);
    
    return ListView.builder(
      itemCount: chatListNotifier.chats.length,
      itemBuilder: (context, index) {
        final chat = chatListNotifier.chats[index];
        return ChatListItem(chat: chat);
      },
    );
  }
}
```

### В виджетах

```dart
class MessageInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoTextField(
      onSubmitted: (text) {
        ref.read<MessageListNotifier>(messageListProvider(chatId))
           .addMessage(text);
      },
    );
  }
}
```

## 🔧 Добавление новых провайдеров

### 1. Создайте Notifier

```dart
class NewFeatureNotifier extends ChangeNotifier {
  String _data = '';
  
  String get data => _data;
  
  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }
}
```

### 2. Создайте провайдер

```dart
final newFeatureProvider = ChangeNotifierProvider<NewFeatureNotifier>((ref) {
  return NewFeatureNotifier();
});
```

### 3. Экспортируйте в di.dart

```dart
export 'providers.dart';
export 'services.dart';
// Добавьте новый экспорт если нужно
```

## 🧪 Тестирование

### Мокирование провайдеров

```dart
class MockChatListNotifier extends ChatListNotifier {
  @override
  List<Chat> get chats => [
    Chat(id: '1', name: 'Test Chat', ...),
  ];
}

void main() {
  testWidgets('Chat list displays chats', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          chatListProvider.overrideWith((ref) => MockChatListNotifier()),
        ],
        child: MyApp(),
      ),
    );
    
    expect(find.text('Test Chat'), findsOneWidget);
  });
}
```

## 📈 Преимущества

1. **Централизация** - Все зависимости в одном месте
2. **Масштабируемость** - Легко добавлять новые провайдеры
3. **Тестируемость** - Простое мокирование зависимостей
4. **Чистота кода** - Четкое разделение ответственности
5. **Производительность** - Эффективное управление состоянием
6. **Типобезопасность** - Строгая типизация с Riverpod

## 🔄 Миграция

При изменении структуры провайдеров:

1. Обновите типы в `providers.dart`
2. Обновите импорты в экранах
3. Обновите тесты
4. Обновите документацию

## 📚 Дополнительные ресурсы

- [Riverpod Documentation](https://riverpod.dev/)
- [Flutter ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html)
- [Dependency Injection Patterns](https://en.wikipedia.org/wiki/Dependency_injection)

