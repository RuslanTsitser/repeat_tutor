import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../gen/assets.gen.dart';
import '../../infrastructure/core.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';
import 'pro_button.dart';

class LogoAppBar extends ConsumerWidget {
  const LogoAppBar({
    super.key,
    this.showProButton = true,
    this.showBackButton = false,
    this.withPadding = true,
    this.title = 'Repeat Tutor',
  });
  final bool showProButton;
  final bool showBackButton;
  final bool withPadding;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider);
    return Container(
      height: 64,
      padding: withPadding
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
          : EdgeInsets.zero,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (showBackButton)
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => router.pop(),
              child: const Icon(CupertinoIcons.chevron_left),
            ),
          Assets.appIcon.image(width: 48, height: 48),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.inter24w500,
            ),
          ),
          if (showProButton) const ProButton(),
        ],
      ),
    );
  }
}
