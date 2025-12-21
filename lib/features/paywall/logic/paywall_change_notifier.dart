import 'package:ab_test_service/ab_test_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/ab_test/ab_test_service.dart';
import '../../../core/ab_test/enum/placement_type.dart';
import '../../../core/ab_test/enum/product_type.dart';

class PaywallChangeNotifier extends ChangeNotifier {
  final AbTestService abTestService;
  PaywallChangeNotifier({required this.abTestService});
  PaywallState _state = PaywallState.initial();
  PaywallState get state => _state;

  void setState(PaywallState value) {
    _state = value;
    notifyListeners();
  }

  PaywallProduct paywallProduct(ProductType productType) {
    return abTestService.paywallProduct(
      state.placementType,
      productType,
      config: abTestService.remoteConfig(state.placementType),
    );
  }
}

class PaywallState {
  factory PaywallState.initial() {
    return const PaywallState(
      placementType: PlacementType.placementGeneral,
    );
  }
  const PaywallState({
    required this.placementType,
  });
  final PlacementType placementType;

  PaywallState copyWith({
    PlacementType? placementType,
  }) {
    return PaywallState(
      placementType: placementType ?? this.placementType,
    );
  }
}
