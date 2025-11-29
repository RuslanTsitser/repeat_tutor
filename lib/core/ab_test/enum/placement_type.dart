import 'package:ab_test_service/ab_test_service.dart';

enum PlacementType implements BasePlacementType {
  placementOnboarding,
  placementStart,
  placementRealtimeCall,
  placementGeneral;

  bool get isOnboarding => this == PlacementType.placementOnboarding;

  @override
  String get placementName => switch (this) {
    PlacementType.placementOnboarding => 'placement_onboarding',
    PlacementType.placementStart => 'placement_start',
    PlacementType.placementRealtimeCall => 'placement_realtime_call',
    PlacementType.placementGeneral => 'placement_general',
  };
}
