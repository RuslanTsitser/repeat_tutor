import 'package:ab_test_service/ab_test_service.dart';

import '../model/remote_config/remote_config.dart';

enum ProductType implements BaseProductType {
  main,
  product1,
  product2;

  @override
  String? parentProductName(BaseRemoteConfig config) {
    if (config is RemoteConfig) {
      final productName = switch (this) {
        ProductType.main => config.parentMainProduct,
        ProductType.product1 => config.parentProduct1,
        ProductType.product2 => config.parentProduct2,
      };
      return productName;
    }
    return null;
  }

  @override
  String? productName(BaseRemoteConfig config) {
    if (config is RemoteConfig) {
      final productName = switch (this) {
        ProductType.main => config.mainProduct,
        ProductType.product1 => config.product1,
        ProductType.product2 => config.product2,
      };
      return productName;
    }
    return null;
  }
}
