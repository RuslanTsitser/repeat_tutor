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
import '../../onboarding/presentation/onboarding_wrappers/onboarding_chat_list_wrapper.dart';
import '../logic/chat_list_notifier.dart';
import 'chat_list_item.dart';

@RoutePage()
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingChatListWrapper(
      child: CupertinoPageScaffold(
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              _Body(),
              Positioned(
                right: 16,
                bottom: 16,
                child: AddButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddButton extends ConsumerWidget {
  const AddButton({
    super.key,
  });

  static const double _buttonSize = 56.0;
  static const double _iconSize = 24.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AddButtonWrapper(
      child: Semantics(
        button: true,
        label: S.of(context).newChat,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            final chat = await ref.read(createChatUseCaseProvider).execute();
            if (chat != null) {
              ref.read(openScreenUseCaseProvider).openChat(chat);
            }
          },
          child: Container(
            width: _buttonSize,
            height: _buttonSize,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.add,
              color: CupertinoColors.white,
              size: _iconSize,
            ),
          ),
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
      return const Column(
        children: [
          LogoAppBar(),
          Expanded(
            child: CupertinoActivityIndicator(),
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
