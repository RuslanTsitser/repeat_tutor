import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/chat.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../logic/chat_list_notifier.dart';

@RoutePage()
class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Чаты'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => ref.read(createChatUseCaseProvider).execute(),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatNotifier = ref.watch(chatProvider);
    final ChatsState state = chatNotifier.state;
    final bool isLoading = state.isLoading;
    final String? error = state.error;
    final List<Chat> chats = state.chats;

    if (isLoading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (error != null) {
      return Center(
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
              style: CupertinoTheme.of(context).textTheme.textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              onPressed: () {
                ref.read(chatProvider).getChats();
              },
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

    if (chats.isEmpty) {
      return const Center(
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
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return _ChatListItem(
          chat: chat,
          onTap: () => ref.read(openChatUseCaseProvider).execute(chat),
          onDeletePressed: () =>
              ref.read(deleteChatUseCaseProvider).execute(chat.chatId),
        );
      },
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
          chat.topic.isEmpty ? '?' : chat.topic[0].toUpperCase(),
          style: const TextStyle(
            color: CupertinoColors.systemGrey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      title: Text(
        chat.topic,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        chat.chatLanguage.name,
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
            chat.createdAt.toLocal().toString(),
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 12,
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
