import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../infrastructure/use_case.dart';
import '../../onboarding/presentation/onboarding_wrappers/onboarding_chat_list_wrapper.dart';

class CreateChatButton extends ConsumerWidget {
  const CreateChatButton({
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
