import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/ab_test/enum/product_type.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../infrastructure/state_managers.dart';
import '../utils/paywall_utils.dart';

/// Paywall3 - вариант с горизонтальным селектором и акцентом на цену
class Paywall3 extends StatelessWidget {
  const Paywall3({
    super.key,
    required this.onPurchase,
    required this.onClose,
  });
  final VoidCallback onPurchase;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: CloseButtonWrapper(
          onClose: onClose,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Header(),
                      SizedBox(height: 16),
                      _ProductSelector(),
                      SizedBox(height: 16),
                      Flexible(child: _FeaturesGrid()),
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
        Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                LucideIcons.star,
                size: 24,
                color: AppColors.primary,
              ),
            )
            .animate()
            .scale(
              duration: 500.ms,
              curve: Curves.easeOut,
            )
            .fadeIn(duration: 400.ms),
        const SizedBox(height: 16),
        Text(
              'Go Premium',
              style: AppTextStyle.inter24w700
                  .copyWith(color: AppColors.textPrimary)
                  .scaled(context),
              textAlign: TextAlign.center,
            )
            .animate(delay: 200.ms)
            .fadeIn(duration: 400.ms)
            .moveY(begin: -8, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 4),
        Text(
              'Unlock all features and practice without limits',
              style: AppTextStyle.inter16w400
                  .copyWith(color: AppColors.textSecondary)
                  .scaled(context),
              textAlign: TextAlign.center,
            )
            .animate(delay: 400.ms)
            .fadeIn(duration: 400.ms)
            .moveY(begin: -8, end: 0, curve: Curves.easeOut),
      ],
    );
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              'Select plan',
              style: AppTextStyle.inter18w600
                  .copyWith(color: AppColors.textPrimary)
                  .scaled(context),
            )
            .animate(delay: 600.ms)
            .fadeIn(duration: 400.ms)
            .moveY(begin: 8, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final productType = products[index];
              return _ProductCard(
                    productType: productType,
                    isSelected: selectedProductType == productType,
                    onTap: () {
                      paywallChangeNotifier.setState(
                        paywallChangeNotifier.state.copyWith(
                          selectedProductType: productType,
                        ),
                      );
                    },
                  )
                  .animate(delay: (700 + index * 100).ms)
                  .fadeIn(duration: 400.ms)
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1, 1),
                    curve: Curves.easeOut,
                  );
            },
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends ConsumerWidget {
  const _ProductCard({
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
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              paywallProduct.productLabel,
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
              style: AppTextStyle.inter20w700
                  .copyWith(
                    color: isSelected
                        ? AppColors.surface
                        : AppColors.textPrimary,
                  )
                  .scaled(context),
            ),
            if (paywallProduct.subscriptionPeriod != null) ...[
              const SizedBox(height: 4),
              Text(
                'per ${paywallProduct.subscriptionPeriod!.days.periodLabel}',
                style: AppTextStyle.inter12w400
                    .copyWith(
                      color: isSelected
                          ? AppColors.surface.withValues(alpha: 0.8)
                          : AppColors.textSecondary,
                    )
                    .scaled(context),
              ),
            ],
            if (paywallProduct.discountPercent != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.surface.withValues(alpha: 0.2)
                      : AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Save ${paywallProduct.discountPercent}%',
                  style: AppTextStyle.inter12w600
                      .copyWith(
                        color: isSelected
                            ? AppColors.surface
                            : AppColors.primary,
                      )
                      .scaled(context),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

}

class _FeaturesGrid extends StatelessWidget {
  const _FeaturesGrid();

  static const _features = [
    (LucideIcons.infinity, 'Unlimited chats'),
    (LucideIcons.mic, 'Voice mode'),
    (LucideIcons.sparkles, 'Smart corrections'),
    (LucideIcons.zap, 'Priority support'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              'What\'s included',
              style: AppTextStyle.inter18w600
                  .copyWith(color: AppColors.textPrimary)
                  .scaled(context),
            )
            .animate(delay: 900.ms)
            .fadeIn(duration: 400.ms)
            .moveY(begin: 8, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _features
              .asMap()
              .entries
              .map(
                (entry) => SizedBox(
                  width: (MediaQuery.of(context).size.width - 64) / 2,
                  child:
                      _FeatureItem(
                            icon: entry.value.$1,
                            text: entry.value.$2,
                          )
                          .animate(delay: (1000 + entry.key * 100).ms)
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
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.primary,
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: AppTextStyle.inter12w500
                .copyWith(color: AppColors.textPrimary)
                .scaled(context),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child:
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
                        'Start Premium - ${paywallProduct.fullPrice ?? ''}',
                        style: AppTextStyle.inter16w600
                            .copyWith(color: AppColors.surface)
                            .scaled(context),
                      ),
              )
              .animate(delay: 1400.ms)
              .fadeIn(duration: 400.ms)
              .moveY(begin: 16, end: 0, curve: Curves.easeOut),
    );
  }
}
