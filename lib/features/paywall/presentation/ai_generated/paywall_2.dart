import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/ab_test/enum/product_type.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../infrastructure/state_managers.dart';
import '../utils/paywall_utils.dart';

/// Paywall2 - вариант с карточками продуктов и вертикальной компоновкой
class Paywall2 extends StatelessWidget {
  const Paywall2({
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
                      SizedBox(height: 16),
                      Flexible(child: _FeaturesList()),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
              'Unlock Premium',
              style: AppTextStyle.inter24w700
                  .copyWith(color: AppColors.textPrimary)
                  .scaled(context),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(duration: 400.ms)
            .moveY(begin: -8, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 8),
        Text(
              'Practice speaking with confidence',
              style: AppTextStyle.inter16w400
                  .copyWith(color: AppColors.textSecondary)
                  .scaled(context),
              textAlign: TextAlign.center,
            )
            .animate(delay: 200.ms)
            .fadeIn(duration: 400.ms)
            .moveY(begin: -8, end: 0, curve: Curves.easeOut),
      ],
    );
  }
}

class _FeaturesList extends StatelessWidget {
  const _FeaturesList();

  static const _features = [
    ('Unlimited conversations', LucideIcons.messageCircle),
    ('Voice practice mode', LucideIcons.mic),
    ('Advanced corrections', LucideIcons.sparkles),
    ('Priority support', LucideIcons.heartHandshake),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _features
          .asMap()
          .entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child:
                  _FeatureItem(
                        icon: entry.value.$2,
                        text: entry.value.$1,
                      )
                      .animate(delay: (400 + entry.key * 100).ms)
                      .fadeIn(duration: 400.ms)
                      .moveX(begin: -16, end: 0, curve: Curves.easeOut),
            ),
          )
          .toList(),
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
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 14,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.inter14w500
                .copyWith(color: AppColors.textPrimary)
                .scaled(context),
          ),
        ),
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
              'Choose your plan',
              style: AppTextStyle.inter18w600
                  .copyWith(color: AppColors.textPrimary)
                  .scaled(context),
            )
            .animate(delay: 700.ms)
            .fadeIn(duration: 400.ms)
            .moveY(begin: 8, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 8),
        ...products.asMap().entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child:
                _ProductCard(
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
                    .animate(delay: (800 + entry.key * 100).ms)
                    .fadeIn(duration: 400.ms)
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1, 1),
                      curve: Curves.easeOut,
                    ),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : AppColors.divider,
              ),
              child: isSelected
                  ? const Icon(
                      CupertinoIcons.checkmark,
                      size: 16,
                      color: AppColors.surface,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paywallProduct.productLabelFull,
                    style: AppTextStyle.inter16w600
                        .copyWith(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        )
                        .scaled(context),
                  ),
                  if (paywallProduct.discountPercent != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Save ${paywallProduct.discountPercent}%',
                      style: AppTextStyle.inter12w500
                          .copyWith(color: AppColors.primary)
                          .scaled(context),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              paywallProduct.fullPrice ?? '',
              style: AppTextStyle.inter18w700
                  .copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
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
                        'Subscribe for ${paywallProduct.fullPrice ?? ''}',
                        style: AppTextStyle.inter16w600
                            .copyWith(color: AppColors.surface)
                            .scaled(context),
                      ),
              )
              .animate(delay: 1000.ms)
              .fadeIn(duration: 400.ms)
              .moveY(begin: 16, end: 0, curve: Curves.easeOut),
    );
  }
}
