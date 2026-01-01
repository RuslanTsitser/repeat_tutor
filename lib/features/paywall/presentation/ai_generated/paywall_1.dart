import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ab_test/enum/product_type.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../infrastructure/state_managers.dart';

class Paywall1 extends StatelessWidget {
  const Paywall1({super.key, required this.onPurchase, required this.onClose});
  final VoidCallback onPurchase;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CloseButtonWrapper(
          onClose: onClose,
          child: Column(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Content(),
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

class CloseButtonWrapper extends StatelessWidget {
  const CloseButtonWrapper({
    super.key,
    required this.child,
    required this.onClose,
  });
  final Widget child;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: CupertinoButton(
            color: AppColors.surface,
            foregroundColor: AppColors.textPrimary,
            onPressed: onClose,
            child: const Icon(CupertinoIcons.xmark),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    // TODO: Implement content with Illustrations and bullet points
    return const Text('Content');
  }
}

class _Selector extends ConsumerWidget {
  const _Selector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Implement selector
    return const Column(
      children: [],
    );
  }
}

class _Button extends ConsumerWidget {
  const _Button({required this.onPurchase});
  final VoidCallback onPurchase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paywallChangeNotifier = ref.watch(paywallChangeNotifierProvider);
    final selectedProductType = paywallChangeNotifier.state.selectedProductType;
    final paywallProduct = paywallChangeNotifier.paywallProduct(
      selectedProductType ?? ProductType.product1,
    );
    final isPurchasing = paywallChangeNotifier.state.idPurchasing;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CupertinoButton(
        color: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(double.infinity, 44),
        borderRadius: BorderRadius.circular(16),
        onPressed: onPurchase,
        child: isPurchasing
            ? const CupertinoActivityIndicator(
                color: AppColors.surface,
              )
            : Text(
                'Subscribe for ${paywallProduct.fullPrice ?? ''}/${paywallProduct.subscriptionPeriod?.days} days',
                style: AppTextStyle.inter14w600
                    .copyWith(color: AppColors.surface)
                    .scaled(context),
              ),
      ),
    );
  }
}
