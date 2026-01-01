import 'package:ab_test_service/ab_test_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/ab_test/ab_test_service.dart';
import '../../../core/ab_test/enum/placement_type.dart';
import '../../../core/ab_test/enum/product_type.dart';
import '../../../core/ab_test/model/remote_config/remote_config.dart';

class PaywallChangeNotifier extends ChangeNotifier {
  final AbTestService abTestService;
  PaywallChangeNotifier({required this.abTestService});

  void init(PlacementType placement) {
    final state = PaywallState.initial(placement);
    setState(state, notify: false);
  }

  PaywallState _state = PaywallState.initial(PlacementType.placementGeneral);
  PaywallState get state => _state;
  RemoteConfig get config => abTestService.remoteConfig(state.placement);
  PaywallProduct paywallProduct(ProductType productType) =>
      abTestService.paywallProduct(
        state.placement,
        productType,
        config: config,
      );

  Future<void> purchase(ProductType productType) async {
    setState(state.copyWith(idPurchasing: true));
    await abTestService.purchasePaywall(
      state.placement,
      productType: productType,
      config: config,
    );
    setState(state.copyWith(idPurchasing: false));
  }

  void setState(PaywallState value, {bool notify = true}) {
    _state = value;
    if (notify) {
      notifyListeners();
    }
  }
}

class PaywallState {
  factory PaywallState.initial(PlacementType placement) {
    return PaywallState(
      placement: placement,
      idPurchasing: false,
      selectedProductType: null,
    );
  }
  const PaywallState({
    required this.placement,
    required this.idPurchasing,
    required this.selectedProductType,
  });
  final PlacementType placement;
  final bool idPurchasing;
  final ProductType? selectedProductType;

  PaywallState copyWith({
    PlacementType? placement,
    bool? idPurchasing,
    ProductType? selectedProductType,
  }) {
    return PaywallState(
      placement: placement ?? this.placement,
      idPurchasing: idPurchasing ?? this.idPurchasing,
      selectedProductType: selectedProductType ?? this.selectedProductType,
    );
  }
}
