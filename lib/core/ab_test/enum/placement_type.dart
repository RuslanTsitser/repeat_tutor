import 'package:ab_test_service/ab_test_service.dart';

enum PlacementType implements BasePlacementType {
  /// Показывается после первого онбординга
  placementOnboarding,

  /// Показывается для всех не премиум юзеров при старте приложения
  placementStart,

  /// Показывается при отправке N сообщений за сегодняшний день
  placementSendMessage,

  /// Показывается при старте голосового режима, если нет лимитов
  placementVoiceCall,

  /// Не показывается,
  /// используется для хранения информации обо всех продуктах
  placementGeneral;

  bool get isOnboarding => this == PlacementType.placementOnboarding;

  @override
  String get placementName => switch (this) {
    PlacementType.placementOnboarding => 'placement_onboarding',
    PlacementType.placementStart => 'placement_start',
    PlacementType.placementSendMessage => 'placement_send_message',
    PlacementType.placementVoiceCall => 'placement_voice_call',
    PlacementType.placementGeneral => 'placement_general',
  };
}
