import 'dart:async';

import 'package:ab_test_service/ab_test_service.dart';
import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_paywall.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../logging/app_logger.dart' as logger;
import 'enum/placement_type.dart';
import 'model/remote_config/remote_config.dart';

/// {@template ab_test_ap_hud}
/// AbTestService implementation for Apphud.
/// - offline mode is supported
/// {@endtemplate}
final class AbTestService
    with
        ApphudMixin,
        ApphudCacheMixin,
        ProductMixin,
        RemoteConfigMixin<RemoteConfig>,
        LogPaywallMixin,
        UserPremiumMixin,
        UserIdMixin,
        PurchaseMixin,
        ApphudUserPropertyMixin,
        CancelSubscriptionLinkMixin,
        WithTrialMixin,
        OfflineModeMixin
    implements BaseAbTestService<RemoteConfig> {
  /// {@macro ab_test_ap_hud}
  AbTestService(this.appKey);
  final String appKey;

  /// TODO: For testing purposes
  /// [AppPaywalls.firstPaywall] - for testing purposes
  /// [AppProducts.yearTrialSubscription] - for testing purposes
  @override
  RemoteConfig remoteConfig(
    BasePlacementType type, {
    RemoteConfig? defaultValue,
  }) {
    return super
        .remoteConfig(type, defaultValue: const RemoteConfig())
        .copyWith(
          // paywall: AppPaywalls.firstPaywall,
          // product1: AppProducts.yearTrialSubscription,
          // textThreeDaysFreeSize: 2,
        );
  }

  /// TODO: For testing purposes
  /// [TrialPeriod.oneYear] - for testing purposes
  @override
  PaywallProduct paywallProduct(
    BasePlacementType type,
    BaseProductType productType, {
    required BaseRemoteConfig config,
  }) {
    return super
        .paywallProduct(type, productType, config: config)
        .copyWith(
          // trialPeriod: TrialPeriod.oneYear,
        );
  }

  /// TODO: For testing purposes
  /// [UserPremiumSource.debug] - for testing purposes
  @override
  Future<PurchaseEntity?> purchasePaywall(
    BasePlacementType type, {
    required BaseProductType productType,
    required BaseRemoteConfig config,
  }) async {
    // await setPremium(UserPremiumSource.debug);
    return super.purchasePaywall(
      type,
      productType: productType,
      config: config,
    );
  }

  /// TODO: For testing purposes
  /// [PlacementType.placementAllProducts] - for testing purposes
  @override
  ApphudPaywall? getPaywallByType(BasePlacementType type) {
    final placement = placements.firstWhereOrNull(
      (element) => element.identifier == type.placementName,
    );
    return placement?.paywall;
  }

  Future<void> init() async {
    await checkOfflineMode();
    await initApphud(appKey);
    await Future.wait([
      checkUserPremium(),
      getUserId(),
      initRemoteConfigs(),
    ]);
    logInfo({
      'userId': userId,
      'userPremiumSource': userPremiumSource,
      'placements': placements
          .map(
            (e) => {
              e.identifier: {
                'paywall': e.paywall?.identifier,
                'productsLength': e.paywall?.products?.length,
                'remoteConfig': e.paywall?.json,
              },
            },
          )
          .toList(),
      'allAndroidProducts': remoteConfigPaywall?.products?.map((e) {
        return e.productDetails?.toJson();
      }).toList(),
      'AllIOSProducts': remoteConfigPaywall?.products?.map((e) {
        return e.skProduct?.toJson();
      }).toList(),
    });
  }

  bool get isPremium => userPremiumSource != UserPremiumSource.none;

  @override
  String appHudPlacement(BasePlacementType type) => type.placementName;

  @override
  String appHudPaywall(BasePlacementType type) =>
      getPaywallByType(type)?.identifier ?? '';

  ApphudPaywall? get remoteConfigPaywall =>
      getPaywallByType(PlacementType.placementGeneral);

  Future<void> dispose() => disposeApphud();

  Future<void> getUserId() async {
    if (isOffline) {
      final userId = await getCachedUserId();
      setUserId(userId);
      return;
    }
    try {
      final value = await Apphud.userID();
      await cacheUserId(value);
      // Adjust.getIdfa().then((value) {
      //   if (value != null) {
      //     return Apphud.setAdvertisingIdentifier(value);
      //   }
      // });
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        Apphud.collectSearchAdsAttribution();
      }
      Apphud.collectDeviceIdentifiers();
      // AppMetrica.setUserProfileID(value);
      // FirebaseAnalytics.instance.setUserId(id: value);
      // FirebaseAnalytics.instance.appInstanceId.then((value) => Apphud.addAttribution(
      //       data: {},
      //       provider: ApphudAttributionProvider.firebase,
      //       identifier: value,
      //     ));
      setUserId(value);
    } catch (error, stackTrace) {
      logError('Error in Apphud.userID()', error, stackTrace);
    }
  }

  @override
  ApphudPaywall? get generalPaywall =>
      getPaywallByType(PlacementType.placementGeneral);

  @override
  ApphudProduct? get generalProduct =>
      generalPaywall?.products?.firstWhereOrNull(
        (element) =>
            element.name ==
            remoteConfig(PlacementType.placementGeneral).mainProduct,
      );

  @override
  UserPremiumSource getUserPremiumSource(String source) {
    final sources = <UserPremiumSource>[
      UserPremiumSource.none,
      UserPremiumSource.apphud,
      UserPremiumSource.debug,
    ];
    return sources.firstWhereOrNull((element) => element.source == source) ??
        UserPremiumSource.none;
  }

  @override
  Future<void> initRemoteConfigs() async {
    await Future.wait([
      fetchPlacements(),
    ]);
    _setRemoteConfigs();
  }

  void _setRemoteConfigs() {
    for (final type in PlacementType.values) {
      final remoteConfig = getPaywallByType(type)?.json;
      if (remoteConfig != null) {
        final childPaywall = remoteConfig['childPaywall'];
        if (childPaywall != null && childPaywall is Map) {
          remoteConfig['childPaywall'] = Map<String, dynamic>.from(
            childPaywall,
          );
        }
        final config = RemoteConfig.fromJson(remoteConfig);
        setRemoteConfig(config, type, log: false);
      }
    }
  }

  @override
  void logError(Object message, [Object? error, StackTrace? stackTrace]) =>
      logger.logError(message, error, stackTrace);

  @override
  void logInfo(Object message) => logger.logInfo(message);
}
