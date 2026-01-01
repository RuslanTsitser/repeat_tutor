import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/use_case.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class ProButton extends ConsumerWidget {
  const ProButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: AppColors.primary,
      foregroundColor: AppColors.surface,
      onPressed: () {
        ref.read(openScreenUseCaseProvider).openProPaywall();
      },
      child: const Row(
        spacing: 8,
        children: [
          Icon(CupertinoIcons.star, color: AppColors.surface),
          Text('Pro', style: AppTextStyle.inter16w600),
        ],
      ),
    );
  }
}
