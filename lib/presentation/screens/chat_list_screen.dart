import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/di.dart';
import '../notifiers/chat_notifier.dart';
import '../widgets/chat_list_item.dart';
import 'chat_screen.dart';

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем чаты при инициализации экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read<ChatNotifier>(chatProvider).loadChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatNotifier = ref.watch<ChatNotifier>(chatProvider);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Чаты'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: null,
          child: Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: chatNotifier.isLoading
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : chatNotifier.error != null
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
                      'Ошибка загрузки чатов',
                      style: CupertinoTheme.of(
                        context,
                      ).textTheme.navTitleTextStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      chatNotifier.error!,
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CupertinoButton.filled(
                      onPressed: () {
                        chatNotifier.loadChats();
                      },
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              )
            : chatNotifier.chats.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.chat_bubble_2,
                      size: 64,
                      color: CupertinoColors.systemGrey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Нет чатов',
                      style: TextStyle(
                        fontSize: 18,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: chatNotifier.chats.length,
                itemBuilder: (context, index) {
                  final chat = chatNotifier.chats[index];
                  return ChatListItem(
                    chat: chat,
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute<ChatScreen>(
                          builder: (context) => ChatScreen(chat: chat),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
