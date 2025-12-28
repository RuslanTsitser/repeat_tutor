import 'package:apphud/apphud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_premium_source.dart';

mixin CheckUserPremiumExpanded {
  Future<void> cacheIsPremium(UserPremiumSource userPremiumSource);
  Future<UserPremiumSource> getCachedIsPremium();
  Future<void> setDebugPremiumDate(DateTime date);
  Future<DateTime?> getDebugPremiumDate();
  bool get isOffline;

  void logInfo(Object message);
  void logError(Object message, [Object? error, StackTrace? stackTrace]);

  static const String isRestoredKey = 'isRestored';

  UserPremiumSource _userPremiumSource = UserPremiumSource.none;
  UserPremiumSource get userPremiumSource => _userPremiumSource;
  Future<void> setPremium(UserPremiumSource value) async {
    _userPremiumSource = value;
    await cacheIsPremium(value);
    if (value == UserPremiumSource.debug) {
      await setDebugPremiumDate(DateTime.now());
    }
    logInfo('UserPremiumMixin setPremium: $value');
  }

  Future<void> checkUserPremium() async {
    if (isOffline) {
      final isPremium = await getCachedIsPremium();
      await setPremium(isPremium);
      return;
    }

    final debugPremiumDate = await getDebugPremiumDate();
    if (debugPremiumDate != null) {
      final now = DateTime.now().add(const Duration(days: 2));
      final difference = now.difference(debugPremiumDate).inDays;
      if (difference > 7) {
        await setPremium(UserPremiumSource.none);
      } else {
        final isPremium = await getCachedIsPremium();
        _userPremiumSource = isPremium;
        if (isPremium == UserPremiumSource.debug) {
          return;
        }
      }
    }

    try {
      final pref = await SharedPreferences.getInstance();
      final isRestored = pref.getBool(isRestoredKey) ?? false;
      if (!isRestored) {
        final result = await Apphud.restorePurchases();
        final activeSubscriptions = result.subscriptions.where(
          (element) => element.isActive,
        );
        final isGold = activeSubscriptions.any(
          (element) => element.productId.contains('gold'),
        );
        final isPremium = activeSubscriptions.isNotEmpty;

        await setPremium(
          isGold
              ? const UserPremiumSourceGold()
              : isPremium
              ? UserPremiumSource.apphud
              : UserPremiumSource.none,
        );
        await cacheIsPremium(
          isGold
              ? const UserPremiumSourceGold()
              : isPremium
              ? UserPremiumSource.apphud
              : UserPremiumSource.none,
        );
        await pref
            .setBool(isRestoredKey, true)
            .whenComplete(() => logInfo({'setIsRestored': true}));
      } else {
        final subscriptions = await Apphud.subscriptions();
        final activeSubscriptions = subscriptions.where(
          (element) => element.isActive,
        );
        final isGold = activeSubscriptions.any(
          (element) => element.productId.contains('gold'),
        );
        final isPremium = activeSubscriptions.isNotEmpty;

        await cacheIsPremium(
          isGold
              ? const UserPremiumSourceGold()
              : isPremium
              ? UserPremiumSource.apphud
              : UserPremiumSource.none,
        );
        await setPremium(
          isGold
              ? const UserPremiumSourceGold()
              : isPremium
              ? UserPremiumSource.apphud
              : UserPremiumSource.none,
        );
      }
    } catch (error, stackTrace) {
      logError('Error in Apphud.hasPremiumAccess()', error, stackTrace);
    }
  }
}
