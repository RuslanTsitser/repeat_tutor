import 'package:ab_test_service/ab_test_service.dart';

import '../model/remote_config/remote_config.dart';

enum ProductType implements BaseProductType {
  main;

  @override
  String? parentProductName(BaseRemoteConfig config) {
    if (config is RemoteConfig) {
      final productName = switch (this) {
        ProductType.main => config.parentMainProduct,
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
      };
      return productName;
    }
    return null;
  }
}
