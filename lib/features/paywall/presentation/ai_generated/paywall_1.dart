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

/// Paywall1 - базовый вариант с простой компоновкой
class Paywall1 extends StatelessWidget {
  const Paywall1({
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
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Header(),
                      SizedBox(height: 16),
                      Flexible(child: _Content()),
                      SizedBox(height: 16),
                      _Selector(),
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
              S.of(context).upgradeToPremium,
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
              S.of(context).getUnlimitedAccessToAllFeatures,
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

class _Content extends StatelessWidget {
  const _Content();

  static final _features = [
    (LucideIcons.messageCircle, S.current.unlimitedConversations),
    (LucideIcons.mic, S.current.voicePractice),
    (LucideIcons.sparkles, S.current.smartCorrections),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _features
          .asMap()
          .entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child:
                  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            entry.value.$1,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _getFeatureText(context, entry.value.$2),
                            style: AppTextStyle.inter16w500
                                .copyWith(color: AppColors.textPrimary)
                                .scaled(context),
                          ),
                        ],
                      )
                      .animate(delay: (400 + entry.key * 100).ms)
                      .fadeIn(duration: 400.ms)
                      .moveX(begin: -16, end: 0, curve: Curves.easeOut),
            ),
          )
          .toList(),
    );
  }

  static String _getFeatureText(BuildContext context, String key) {
    final localizations = S.of(context);
    return switch (key) {
      'unlimitedConversations' => localizations.unlimitedConversations,
      'voicePractice' => localizations.voicePractice,
      'smartCorrections' => localizations.smartCorrections,
      _ => key,
    };
  }
}

class _Selector extends ConsumerWidget {
  const _Selector();

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
              S.of(context).selectPlan,
              style: AppTextStyle.inter18w600
                  .copyWith(color: AppColors.textPrimary)
                  .scaled(context),
            )
            .animate(delay: 700.ms)
            .fadeIn(duration: 400.ms)
            .moveY(begin: 8, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 8),
        Row(
          children: products
              .asMap()
              .entries
              .map(
                (entry) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
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
                            .animate(delay: (800 + entry.key * 100).ms)
                            .fadeIn(duration: 400.ms)
                            .scale(
                              begin: const Offset(0.9, 0.9),
                              end: const Offset(1, 1),
                              curve: Curves.easeOut,
                            ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                        '${S.of(context).subscribeFor} ${paywallProduct.fullPrice ?? ''}',
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
