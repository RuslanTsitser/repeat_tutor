import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/domain/models/message.dart';
import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/logo_app_bar.dart';
import '../../../core/router/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../../onboarding/presentation/onboarding_wrappers/onboarding_chat_wrapper.dart';
import '../logic/chat_notifier.dart';
import 'components/message_bubble.dart';
import 'components/message_input.dart';

final scrollControllerProvider = ChangeNotifierProvider.autoDispose(
  (ref) => ScrollController(),
);

@RoutePage()
class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingChatWrapper(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const CupertinoPageScaffold(
          resizeToAvoidBottomInset: true,
          child: _Body(),
        ),
      ),
    );
  }
}

class _MessageInput extends ConsumerWidget {
  const _MessageInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.read(scrollControllerProvider);
    return MessageInput(scrollController: scrollController);
  }
}

class _StartVoiceCall extends ConsumerStatefulWidget {
  const _StartVoiceCall();

  @override
  ConsumerState<_StartVoiceCall> createState() => __StartVoiceCallState();
}

class __StartVoiceCallState extends ConsumerState<_StartVoiceCall> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return StartVoiceCallWrapper(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          final chat = ref.read(chatNotifierProvider).state.chat;
          final router = ref.read(routerProvider);
          final useCase = ref.read(startRealtimeCallUseCaseProvider);
          final profileNotifier = ref.read(profileProvider);
          await useCase.start(
            chat: chat.copyWith(
              teacherLanguage: profileNotifier.state.defaultTeacherLanguage,
            ),
          );
          await router.push(const RealtimeCallRoute());
          await useCase.stop();
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        child: _isLoading
            ? const CupertinoActivityIndicator()
            : const Icon(
                LucideIcons.phone,
                color: AppColors.primary,
                size: 24,
                fontWeight: FontWeight.w400,
              ),
      ),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body();

  @override
  ConsumerState<_Body> createState() => __BodyState();
}

class __BodyState extends ConsumerState<_Body> {
  int _previousMessageCount = 0;
  bool _isInitialLoad = true;

  late final _scrollController = ref.read(scrollControllerProvider);

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatNotifier = ref.watch(chatNotifierProvider);
    final MessagesState state = chatNotifier.state;
    final List<Message> messages = state.messages.reversed.toList();
    final bool isLoading = state.isLoading;
    final String? error = state.error;
    final chat = ref.read(chatNotifierProvider).state.chat;
    final chatTitle = chat.topic;
    // Скролл до конца при первой загрузке сообщений
    if (!isLoading && _isInitialLoad && messages.isNotEmpty) {
      _isInitialLoad = false;
      _previousMessageCount = messages.length;
      _scrollToBottom();
    }

    // Автоматическая прокрутка при появлении новых сообщений
    if (messages.length != _previousMessageCount) {
      _previousMessageCount = messages.length;
      if (messages.isNotEmpty) {
        _scrollToBottom();
      }
    }

    if (isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (error != null) {
      return Center(
        child: Text(error),
      );
    }

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.surface,
            AppColors.surface,
            AppColors.backgroundLight,
            AppColors.backgroundLight,
            AppColors.backgroundLight,
            AppColors.backgroundLight,
            AppColors.backgroundLight,
            AppColors.surface,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            LogoAppBar(
              showBackButton: true,
              withPadding: false,
              subtitle: chatTitle,
              showProButton: false,
              actions: const [
                SizedBox(width: 8),
                _StartVoiceCall(),
                SizedBox(width: 8),
              ],
            ),
            Expanded(
              child: messages.isEmpty
                  ? Center(child: Text(S.of(context).noMessages))
                  : ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: messages.length,
                      itemBuilder: (context, index) => MessageBubble(
                        onMessageUpdated: () {
                          _scrollToBottom();
                        },
                        message: messages[index],
                        onDeletePressed: () {
                          ref
                              .read(deleteChatUseCaseProvider)
                              .deleteMessage(messages[index].id);
                        },
                      ),
                    ),
            ),
            const _MessageInput(),
          ],
        ),
      ),
    );
  }
}
