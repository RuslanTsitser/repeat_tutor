// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ab_test_service/ab_test_service.dart';

class RemoteConfig extends BaseRemoteConfig {
  const RemoteConfig({
    this.mainProduct,
    this.parentMainProduct,
    this.product1,
    this.parentProduct1,
    this.product2,
    this.parentProduct2,
    super.onboarding,
    super.paywall,
    super.onboardingPaywall,
    super.promoOfferId,
  });

  /// String, название продукта product1
  final String? mainProduct;

  /// String, продукт, от которого считаем скидку для [mainProduct]
  final String? parentMainProduct;

  /// String, название продукта product1
  final String? product1;

  /// String, продукт, от которого считаем скидку для [product1]
  final String? parentProduct1;

  /// String, название продукта product2
  final String? product2;

  /// String, продукт, от которого считаем скидку для [product2]
  final String? parentProduct2;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mainProduct': mainProduct,
      'parentMainProduct': parentMainProduct,
      'product1': product1,
      'parentProduct1': parentProduct1,
      'product2': product2,
      'parentProduct2': parentProduct2,
      'onboarding': onboarding,
      'paywall': paywall,
      'onboardingPaywall': onboardingPaywall,
      'promoOfferId': promoOfferId,
    };
  }

  factory RemoteConfig.fromJson(Map<String, dynamic> map) {
    return RemoteConfig(
      onboarding: map['onboarding'] != null
          ? map['onboarding'] as String
          : null,
      paywall: map['paywall'] != null ? map['paywall'] as String : null,
      onboardingPaywall: map['onboardingPaywall'] != null
          ? map['onboardingPaywall'] as String
          : null,
      promoOfferId: map['promoOfferId'] != null
          ? map['promoOfferId'] as String
          : null,
      mainProduct: map['mainProduct'] != null
          ? map['mainProduct'] as String
          : null,
      parentMainProduct: map['parentMainProduct'] != null
          ? map['parentMainProduct'] as String
          : null,
      product1: map['product1'] != null ? map['product1'] as String : null,
      parentProduct1: map['parentProduct1'] != null
          ? map['parentProduct1'] as String
          : null,
      product2: map['product2'] != null ? map['product2'] as String : null,
      parentProduct2: map['parentProduct2'] != null
          ? map['parentProduct2'] as String
          : null,
    );
  }

  RemoteConfig copyWith({
    String? mainProduct,
    String? parentMainProduct,
    String? product1,
    String? parentProduct1,
    String? product2,
    String? parentProduct2,
    String? onboarding,
    String? paywall,
    String? onboardingPaywall,
    String? promoOfferId,
  }) {
    return RemoteConfig(
      mainProduct: mainProduct ?? this.mainProduct,
      parentMainProduct: parentMainProduct ?? this.parentMainProduct,
      product1: product1 ?? this.product1,
      parentProduct1: parentProduct1 ?? this.parentProduct1,
      product2: product2 ?? this.product2,
      parentProduct2: parentProduct2 ?? this.parentProduct2,
      onboarding: onboarding ?? this.onboarding,
      paywall: paywall ?? this.paywall,
      onboardingPaywall: onboardingPaywall ?? this.onboardingPaywall,
      promoOfferId: promoOfferId ?? this.promoOfferId,
    );
  }
}
