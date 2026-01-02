import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/models/chat.dart';
import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/logo_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../logic/chat_list_notifier.dart';
import 'components/chat_list_item.dart';
import 'components/chat_list_item_shimmer.dart';

@RoutePage()
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: SafeArea(
        bottom: false,
        child: _Body(),
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
      return const Column(
        children: [
          LogoAppBar(),
          Expanded(
            child: _LoadingState(),
          ),
        ],
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoAppBar(),
            const Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: 64,
              color: CupertinoColors.systemRed,
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).errorLoadingChats,
              style: CupertinoTheme.of(context).textTheme.textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              onPressed: () {
                ref.read(chatListNotifierProvider).getChats();
              },
              child: Text(S.of(context).retry),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        const LogoAppBar(),
        Expanded(
          child: chats.isEmpty
              ? const _EmptyState()
              : ListView.separated(
                  padding: const EdgeInsets.all(16),

                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return ChatListItem(
                      chat: chat,
                      onTap: () =>
                          ref.read(openScreenUseCaseProvider).openChat(chat),
                      onDeletePressed: () => ref
                          .read(deleteChatUseCaseProvider)
                          .execute(chat.chatId),
                      style: ChatListItemStyle.badge,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  static const int _shimmerCount = 5;
  static const double _padding = 16.0;
  static const double _spacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(_padding),
      separatorBuilder: (context, index) => const SizedBox(height: _spacing),
      itemCount: _shimmerCount,
      itemBuilder: (context, index) {
        return ChatListItemShimmer(
          key: ValueKey('shimmer_$index'),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  static const double _iconSize = 64.0;
  static const double _spacing = 8.0;
  static const double _horizontalPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: _spacing),
          const Icon(
            CupertinoIcons.chat_bubble_2,
            size: _iconSize,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: _spacing),
          Text(
            S.of(context).noChatsYet,
            style: AppTextStyle.inter20w500.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: _spacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Text(
              S
                  .of(context)
                  .startYourFirstConversationAndBeginPracticingANewLanguage,
              textAlign: TextAlign.center,
              style: AppTextStyle.inter16w400.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
