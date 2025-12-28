// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ab_test_service/ab_test_service.dart';

class RemoteConfig extends BaseRemoteConfig {
  const RemoteConfig({
    this.product1,
    this.parentProduct1,
    this.product2,
    this.parentProduct2,
    this.product3,
    this.parentProduct3,
    this.product4,
    this.parentProduct4,
    super.onboarding,
    super.paywall,
    super.onboardingPaywall,
    super.promoOfferId,
  });

  /// String, название продукта product1
  final String? product1;

  /// String, продукт, от которого считаем скидку для [product1]
  final String? parentProduct1;

  /// String, название продукта product2
  final String? product2;

  /// String, продукт, от которого считаем скидку для [product2]
  final String? parentProduct2;

  /// String, название продукта product3
  final String? product3;

  /// String, продукт, от которого считаем скидку для [product3]
  final String? parentProduct3;

  /// String, название продукта product4
  final String? product4;

  /// String, продукт, от которого считаем скидку для [product4]
  final String? parentProduct4;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'product1': product1,
      'parentProduct1': parentProduct1,
      'product2': product2,
      'parentProduct2': parentProduct2,
      'product3': product3,
      'parentProduct3': parentProduct3,
      'product4': product4,
      'parentProduct4': parentProduct4,
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
      product1: map['product1'] != null ? map['product1'] as String : null,
      parentProduct1: map['parentProduct1'] != null
          ? map['parentProduct1'] as String
          : null,
      product2: map['product2'] != null ? map['product2'] as String : null,
      parentProduct2: map['parentProduct2'] != null
          ? map['parentProduct2'] as String
          : null,
      product3: map['product3'] != null ? map['product3'] as String : null,
      parentProduct3: map['parentProduct3'] != null
          ? map['parentProduct3'] as String
          : null,
      product4: map['product4'] != null ? map['product4'] as String : null,
      parentProduct4: map['parentProduct4'] != null
          ? map['parentProduct4'] as String
          : null,
    );
  }

  RemoteConfig copyWith({
    String? product1,
    String? parentProduct1,
    String? product2,
    String? parentProduct2,
    String? product3,
    String? parentProduct3,
    String? product4,
    String? parentProduct4,
    String? onboarding,
    String? paywall,
    String? onboardingPaywall,
    String? promoOfferId,
  }) {
    return RemoteConfig(
      product1: product1 ?? this.product1,
      parentProduct1: parentProduct1 ?? this.parentProduct1,
      product2: product2 ?? this.product2,
      parentProduct2: parentProduct2 ?? this.parentProduct2,
      product3: product3 ?? this.product3,
      parentProduct3: parentProduct3 ?? this.parentProduct3,
      product4: product4 ?? this.product4,
      parentProduct4: parentProduct4 ?? this.parentProduct4,
      onboarding: onboarding ?? this.onboarding,
      paywall: paywall ?? this.paywall,
      onboardingPaywall: onboardingPaywall ?? this.onboardingPaywall,
      promoOfferId: promoOfferId ?? this.promoOfferId,
    );
  }
}
