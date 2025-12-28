import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/ab_test/enum/placement_type.dart';

@RoutePage()
class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key, required this.placement});
  final PlacementType placement;

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text('Paywall'),
      ),
    );
  }
}
