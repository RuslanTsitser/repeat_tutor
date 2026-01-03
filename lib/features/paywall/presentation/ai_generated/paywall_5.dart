import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ab_test/enum/product_type.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../infrastructure/state_managers.dart';
import '../utils/paywall_utils.dart';

/// Paywall5 - вариант с одним продуктом
class Paywall5 extends StatelessWidget {
  const Paywall5({
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
                      _Header(),
                      SizedBox(height: 24),
                      _BenefitsList(),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
              S.of(context).paywall5Headline,
              style: AppTextStyle.inter24w700
                  .copyWith(color: AppColors.textPrimary)
                  .scaled(context),
              textAlign: TextAlign.center,
            )
            .animate(delay: 300.ms)
            .fadeIn(duration: 400.ms)
            .moveY(begin: -8, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 8),
        Text(
              S.of(context).paywall5Subheadline,
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

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);
    final benefits = [
      localizations.paywall5Benefit1,
      localizations.paywall5Benefit2,
      localizations.paywall5Benefit3,
      localizations.paywall5Benefit4,
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: benefits
          .asMap()
          .entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child:
                  Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.checkmark,
                              size: 14,
                              color: AppColors.surface,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: AppTextStyle.inter16w500
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
}

class _Button extends ConsumerWidget {
  const _Button({required this.onPurchase});
  final VoidCallback onPurchase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paywallChangeNotifier = ref.watch(paywallChangeNotifierProvider);
    final paywallProduct = paywallChangeNotifier.paywallProduct(
      ProductType.product1,
    );
    final isPurchasing = paywallChangeNotifier.state.idPurchasing;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CupertinoButton(
                color: AppColors.primary,
                minimumSize: const Size(double.infinity, 44),
                borderRadius: BorderRadius.circular(16),
                onPressed: isPurchasing ? null : onPurchase,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.of(context).paywall5StartPracticing,
                          style: AppTextStyle.inter18w600
                              .copyWith(color: AppColors.surface)
                              .scaled(context),
                        ),
                        if (paywallProduct.fullPrice != null) ...[
                          Text(
                            paywallProduct.subscriptionPeriod != null
                                ? '${paywallProduct.fullPrice} / ${paywallProduct.productLabel(S.of(context))}'
                                : paywallProduct.fullPrice!,
                            style: AppTextStyle.inter12w400
                                .copyWith(
                                  color: AppColors.surface.withValues(
                                    alpha: 0.8,
                                  ),
                                )
                                .scaled(context),
                          ),
                        ],
                      ],
                    ),
                    if (isPurchasing) ...[
                      const Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.primaryCtaPressed,
                          radius: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              )
              .animate(delay: 1100.ms)
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
