import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/ab_test/enum/product_type.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../infrastructure/state_managers.dart';
import '../utils/paywall_utils.dart';

/// Paywall4 - минималистичный вариант с большим CTA и простым селектором
class Paywall4 extends StatelessWidget {
  const Paywall4({
    super.key,
    required this.onPurchase,
    required this.onClose,
  });
  final VoidCallback onPurchase;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.backgroundLight,
      child: SafeArea(
        child: CloseButtonWrapper(
          onClose: onClose,
          child: Column(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: _Illustration()),
                      SizedBox(height: 16),
                      _Header(),
                      SizedBox(height: 16),
                      Flexible(child: _BenefitsList()),
                      SizedBox(height: 16),
                      _ProductSelector(),
                    ],
                  ),
                ),
              ),
              _Button(onPurchase: onPurchase),
            ],
          ),
        ),
      ),
    );
  }
}

class _Illustration extends StatelessWidget {
  const _Illustration();

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            LucideIcons.star,
            size: 48,
            color: AppColors.primary,
          ),
        )
        .animate()
        .scale(
          duration: 600.ms,
          curve: Curves.easeOut,
        )
        .fadeIn(duration: 500.ms);
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
              S.of(context).premiumExperience,
              style: AppTextStyle.inter24w700
                  .copyWith(color: AppColors.textPrimary)
                  .scaled(context),
              textAlign: TextAlign.center,
            )
            .animate(delay: 300.ms)
            .fadeIn(duration: 400.ms)
            .moveY(begin: -8, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 4),
        Text(
              S.of(context).everythingYouNeedToMasterANewLanguage,
              style: AppTextStyle.inter16w400
                  .copyWith(color: AppColors.textSecondary)
                  .scaled(context),
              textAlign: TextAlign.center,
            )
            .animate(delay: 500.ms)
            .fadeIn(duration: 400.ms)
            .moveY(begin: -8, end: 0, curve: Curves.easeOut),
      ],
    );
  }
}

class _BenefitsList extends StatelessWidget {
  const _BenefitsList();

  static const _benefits = [
    'unlimitedConversations',
    'advancedVoicePractice',
    'personalizedFeedback',
    'aiTutorAccess',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _benefits
          .asMap()
          .entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child:
                  Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.checkmark,
                              size: 12,
                              color: AppColors.surface,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _getBenefitText(context, entry.value),
                              style: AppTextStyle.inter14w500
                                  .copyWith(color: AppColors.textPrimary)
                                  .scaled(context),
                            ),
                          ),
                        ],
                      )
                      .animate(delay: (700 + entry.key * 100).ms)
                      .fadeIn(duration: 400.ms)
                      .moveX(begin: -16, end: 0, curve: Curves.easeOut),
            ),
          )
          .toList(),
    );
  }

  static String _getBenefitText(BuildContext context, String key) {
    final localizations = S.of(context);
    return switch (key) {
      'unlimitedConversations' => localizations.unlimitedConversations,
      'advancedVoicePractice' => localizations.advancedVoicePractice,
      'personalizedFeedback' => localizations.personalizedFeedback,
      'aiTutorAccess' => localizations.aiTutorAccess,
      _ => key,
    };
  }
}

class _ProductSelector extends ConsumerWidget {
  const _ProductSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paywallChangeNotifier = ref.watch(paywallChangeNotifierProvider);
    final selectedProductType =
        paywallChangeNotifier.state.selectedProductType ?? ProductType.product1;

    final products = [
      ProductType.product1,
      ProductType.product2,
    ];

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: products
            .asMap()
            .entries
            .map(
              (entry) => Expanded(
                child:
                    _ProductOption(
                          productType: entry.value,
                          isSelected: selectedProductType == entry.value,
                          onTap: () {
                            paywallChangeNotifier.setState(
                              paywallChangeNotifier.state.copyWith(
                                selectedProductType: entry.value,
                              ),
                            );
                          },
                        )
                        .animate(delay: (1100 + entry.key * 100).ms)
                        .fadeIn(duration: 400.ms)
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          end: const Offset(1, 1),
                          curve: Curves.easeOut,
                        ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ProductOption extends ConsumerWidget {
  const _ProductOption({
    required this.productType,
    required this.isSelected,
    required this.onTap,
  });
  final ProductType productType;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paywallChangeNotifier = ref.watch(paywallChangeNotifierProvider);
    final paywallProduct = paywallChangeNotifier.paywallProduct(productType);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : CupertinoColors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              paywallProduct.productLabel(S.of(context)),
              style: AppTextStyle.inter14w600
                  .copyWith(
                    color: isSelected
                        ? AppColors.surface
                        : AppColors.textPrimary,
                  )
                  .scaled(context),
            ),
            const SizedBox(height: 4),
            Text(
              paywallProduct.fullPrice ?? '',
              style: AppTextStyle.inter12w500
                  .copyWith(
                    color: isSelected
                        ? AppColors.surface
                        : AppColors.textSecondary,
                  )
                  .scaled(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends ConsumerWidget {
  const _Button({required this.onPurchase});
  final VoidCallback onPurchase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paywallChangeNotifier = ref.watch(paywallChangeNotifierProvider);
    final selectedProductType =
        paywallChangeNotifier.state.selectedProductType ?? ProductType.product1;
    final paywallProduct = paywallChangeNotifier.paywallProduct(
      selectedProductType,
    );
    final isPurchasing = paywallChangeNotifier.state.idPurchasing;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CupertinoButton(
                color: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 44),
                borderRadius: BorderRadius.circular(16),
                onPressed: isPurchasing ? null : onPurchase,
                child: isPurchasing
                    ? const CupertinoActivityIndicator(
                        color: AppColors.surface,
                      )
                    : Text(
                        '${S.of(context).getPremium} - ${paywallProduct.fullPrice ?? ''}',
                        style: AppTextStyle.inter18w600
                            .copyWith(color: AppColors.surface)
                            .scaled(context),
                      ),
              )
              .animate(delay: 1300.ms)
              .fadeIn(duration: 400.ms)
              .moveY(begin: 16, end: 0, curve: Curves.easeOut),
          const SizedBox(height: 8),
          Text(
            S.of(context).cancelAnytime,
            style: AppTextStyle.inter12w400
                .copyWith(color: AppColors.textMuted)
                .scaled(context),
          ),
        ],
      ),
    );
  }
}
