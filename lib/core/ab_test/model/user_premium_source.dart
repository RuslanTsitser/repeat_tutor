import 'package:ab_test_service/ab_test_service.dart';

export 'package:ab_test_service/ab_test_service.dart';

class UserPremiumSourceGold extends UserPremiumSource {
  const UserPremiumSourceGold() : super(source: 'gold');

  @override
  bool get isPremium => true;
}

extension UserPremiumSourceExtension on UserPremiumSource {
  bool get isGold => this == const UserPremiumSourceGold();
}
