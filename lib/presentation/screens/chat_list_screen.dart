import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/router/router.dart';
import '../../domain/models/chat.dart';
import '../../infrastructure/core.dart';
import '../../infrastructure/handlers.dart';
import '../../infrastructure/state_managers.dart';
import '../notifiers/chat_notifier.dart';

@RoutePage()
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
      final chatEventHandler = ref.read(chatEventHandlerProvider);
      chatEventHandler.onLoadChatsPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatNotifier = ref.watch<ChatNotifier>(chatProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Чаты'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            ref.read(routerProvider).push(const CreateChatRoute());
          },
          child: const Icon(CupertinoIcons.add),
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
                        final chatEventHandler = ref.read(
                          chatEventHandlerProvider,
                        );
                        chatEventHandler.onLoadChatsPressed();
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
                  return _ChatListItem(
                    chat: chat,
                    onTap: () {
                      ref.read(routerProvider).push(ChatRoute(chat: chat));
                    },
                    onDeletePressed: () {
                      final chatEventHandler = ref.read(
                        chatEventHandlerProvider,
                      );
                      chatEventHandler.onDeleteChatPressed(chat.id);
                    },
                  );
                },
              ),
      ),
    );
  }
}

class _ChatListItem extends StatelessWidget {
  const _ChatListItem({
    required this.chat,
    required this.onTap,
    required this.onDeletePressed,
  });
  final Chat chat;
  final VoidCallback onTap;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: CupertinoColors.systemGrey4,
        child: Text(
          chat.name[0].toUpperCase(),
          style: const TextStyle(
            color: CupertinoColors.systemGrey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      title: Text(
        chat.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        chat.lastMessage,
        style: const TextStyle(
          color: CupertinoColors.systemGrey,
          fontSize: 14,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chat.time,
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 12,
            ),
          ),
          if (chat.unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: const BoxDecoration(
                color: CupertinoColors.systemBlue,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                chat.unreadCount.toString(),
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          CupertinoButton(
            onPressed: onDeletePressed,
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.delete),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
