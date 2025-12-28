import 'package:ab_test_service/ab_test_service.dart';

import '../model/remote_config/remote_config.dart';

enum ProductType implements BaseProductType {
  product1,
  product2,
  product3,
  product4;

  @override
  String? parentProductName(BaseRemoteConfig config) {
    if (config is RemoteConfig) {
      final productName = switch (this) {
        ProductType.product1 => config.parentProduct1,
        ProductType.product2 => config.parentProduct2,
        ProductType.product3 => config.parentProduct3,
        ProductType.product4 => config.parentProduct4,
      };
      return productName;
    }
    return null;
  }

  @override
  String? productName(BaseRemoteConfig config) {
    if (config is RemoteConfig) {
      final productName = switch (this) {
        ProductType.product1 => config.product1,
        ProductType.product2 => config.product2,
        ProductType.product3 => config.product3,
        ProductType.product4 => config.product4,
      };
      return productName;
    }
    return null;
  }
}
