// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ab_test_service/ab_test_service.dart';

class RemoteConfig extends BaseRemoteConfig {
  const RemoteConfig({
    this.mainProduct,
    this.parentMainProduct,
    super.onboarding,
    super.paywall,
    super.onboardingPaywall,
    super.promoOfferId,
  });

  /// String, название продукта product1
  final String? mainProduct;

  /// String, продукт, от которого считаем скидку для [mainProduct]
  final String? parentMainProduct;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mainProduct': mainProduct,
      'parentMainProduct': parentMainProduct,
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
    );
  }

  RemoteConfig copyWith({
    String? mainProduct,
    String? parentMainProduct,
    String? onboarding,
    String? paywall,
    String? onboardingPaywall,
    String? promoOfferId,
  }) {
    return RemoteConfig(
      mainProduct: mainProduct ?? this.mainProduct,
      parentMainProduct: parentMainProduct ?? this.parentMainProduct,
      onboarding: onboarding ?? this.onboarding,
      paywall: paywall ?? this.paywall,
      onboardingPaywall: onboardingPaywall ?? this.onboardingPaywall,
      promoOfferId: promoOfferId ?? this.promoOfferId,
    );
  }
}
