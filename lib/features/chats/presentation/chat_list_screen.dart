import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/models/chat.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../logic/chat_list_notifier.dart';

@RoutePage()
class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatNotifier = ref.watch(chatListNotifierProvider);
    final chats = chatNotifier.state.chats;
    final hasChats = chats.isNotEmpty;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Stack(
          children: [
            const _Body(),
            if (hasChats)
              Positioned(
                right: 16,
                bottom: 80,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () =>
                      ref.read(createChatUseCaseProvider).execute(),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF155DFC),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 4,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.add,
                      color: CupertinoColors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _BottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatNotifier = ref.watch(chatListNotifierProvider);
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
                ref.read(chatListNotifierProvider).getChats();
              },
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          height: 65,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: const BoxDecoration(
            color: CupertinoColors.white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE5E7EB),
                width: 1,
              ),
            ),
          ),
          child: const Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Чаты',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0A0A0A),
                letterSpacing: 0.0703,
                height: 32 / 24,
              ),
            ),
          ),
        ),
        Expanded(
          child: chats.isEmpty
              ? _EmptyState(
                  onCreateChat: () =>
                      ref.read(createChatUseCaseProvider).execute(),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: 141),
                  itemCount: chats.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    color: Color(0xFFE5E7EB),
                  ),
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return _ChatListItem(
                      chat: chat,
                      onTap: () =>
                          ref.read(openChatUseCaseProvider).execute(chat),
                      onDeletePressed: () => ref
                          .read(deleteChatUseCaseProvider)
                          .execute(chat.chatId),
                    );
                  },
                ),
        ),
      ],
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

  String _getLevelLabel(DifficultyLevel level) {
    switch (level) {
      case DifficultyLevel.beginner:
        return 'A1';
      case DifficultyLevel.intermediate:
        return 'A2';
      case DifficultyLevel.advanced:
        return 'A3';
    }
  }

  String _getChatTitle() {
    final language = chat.chatLanguage.localizedName;
    final level = _getLevelLabel(chat.level);
    return '$language $level – ${chat.topic}';
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu.builder(
      actions: [
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
            onDeletePressed();
          },
          trailingIcon: CupertinoIcons.delete,
          child: const Text('Delete'),
        ),
      ],
      builder: (context, animation) => CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Container(
          height: 81,
          padding: const EdgeInsets.only(left: 16, top: 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: CupertinoColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getChatTitle(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF101828),
                  letterSpacing: -0.3125,
                  height: 24 / 16,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    chat.lastMessage?.text ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4A5565),
                      letterSpacing: -0.1504,
                      height: 20 / 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.onCreateChat,
  });
  final VoidCallback onCreateChat;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          const Icon(
            CupertinoIcons.chat_bubble_2,
            size: 64,
            color: Color(0xFF9CA3AF),
          ),
          const SizedBox(height: 8),
          const Text(
            'No chats yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF101828),
              letterSpacing: -0.4492,
              height: 28 / 20,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Start your first conversation and begin practicing a new language',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Color(0xFF4A5565),
                letterSpacing: -0.3125,
                height: 24 / 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onCreateChat,
            child: Container(
              width: 192,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF155DFC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Start your first chat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CupertinoColors.white,
                    letterSpacing: -0.3125,
                    height: 24 / 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61,
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            child: _BottomNavItem(
              icon: CupertinoIcons.chat_bubble,
              label: 'Чаты',
              isActive: true,
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: CupertinoIcons.person,
              label: 'Профиль',
              isActive: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });
  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: CupertinoColors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? const Color(0xFF155DFC) : const Color(0xFF6A7282),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive
                  ? const Color(0xFF155DFC)
                  : const Color(0xFF6A7282),
              height: 16 / 12,
            ),
          ),
        ],
      ),
    );
  }
}
