import 'package:flutter/cupertino.dart';

import '../../../core/ab_test/enum/placement_type.dart';
import '../../../core/ab_test/enum/product_type.dart';

class PaywallChangeNotifier extends ChangeNotifier {
  PaywallChangeNotifier({required this.placement});
  final PlacementType placement;

  PaywallState _state = PaywallState.initial();
  PaywallState get state => _state;

  void setState(PaywallState value) {
    _state = value;
    notifyListeners();
  }
}

class PaywallState {
  factory PaywallState.initial() {
    return const PaywallState(
      idPurchasing: false,
      selectedProductType: null,
    );
  }
  const PaywallState({
    required this.idPurchasing,
    required this.selectedProductType,
  });
  final bool idPurchasing;
  final ProductType? selectedProductType;

  PaywallState copyWith({
    bool? idPurchasing,
    ProductType? selectedProductType,
  }) {
    return PaywallState(
      idPurchasing: idPurchasing ?? this.idPurchasing,
      selectedProductType: selectedProductType ?? this.selectedProductType,
    );
  }
}
