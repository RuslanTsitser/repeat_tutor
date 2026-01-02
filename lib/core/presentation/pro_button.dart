import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../features/profile/logic/profile_notifier.dart';
import '../../infrastructure/state_managers.dart';
import '../../infrastructure/use_case.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class ProButton extends ConsumerWidget {
  const ProButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PremiumStatus premiumStatus = ref
        .watch(profileProvider)
        .state
        .premiumStatus;

    if (premiumStatus == PremiumStatus.free) {
      return const SizedBox.shrink();
    }
    return CupertinoButton(
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: AppColors.primary,
      foregroundColor: AppColors.surface,
      onPressed: () {
        ref.read(openScreenUseCaseProvider).openProPaywall();
      },
      child: Row(
        spacing: 8,
        children: [
          Icon(
            premiumStatus == PremiumStatus.pro
                ? LucideIcons.star
                : LucideIcons.crown,
            color: AppColors.surface,
          ),
          Text(
            premiumStatus == PremiumStatus.pro ? 'Pro' : 'Gold',
            style: AppTextStyle.inter16w600,
          ),
        ],
      ),
    );
  }
}
