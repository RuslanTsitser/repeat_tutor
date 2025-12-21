import '../../../core/ab_test/enum/placement_type.dart';
import '../../../core/database/daos/sessions_durations_dao.dart';
import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';
import '../../../core/domain/models/realtime_session.dart';
import '../../../core/gpt/gpt_service.dart';
import '../../../core/gpt/instructions/tutor_instruction.dart';
import '../../../core/realtime/realtime_webrtc_manager.dart';
import '../../../core/router/router.dart';
import '../../paywall/use_case/open_paywall_use_case.dart';
import '../logic/realtime_call_notifier.dart';

/// Use case для создания новой Realtime-сессии.
class StartRealtimeCallUseCase {
  const StartRealtimeCallUseCase({
    required this.gptService,
    required this.realtimeWebRTCConnection,
    required this.realtimeCallNotifier,
    required this.appRouter,
    required this.sessionsDurationsDao,
    required this.openPaywallUseCase,
  });
  final GptService gptService;
  final RealtimeWebRTCConnection realtimeWebRTCConnection;
  final RealtimeCallNotifier realtimeCallNotifier;
  final AppRouter appRouter;
  final SessionsDurationsDao sessionsDurationsDao;
  final OpenPaywallUseCase openPaywallUseCase;

  Future<void> execute({
    required String topic,
    required Language language,
    required DifficultyLevel level,
    required Language teacherLanguage,
  }) async {
    final isPremium = await openPaywallUseCase.openPaywall(
      placementType: PlacementType.placementRealtimeCall,
    );
    if (!isPremium) {
      return;
    }

    final currentState = realtimeCallNotifier.state;
    realtimeCallNotifier.setState(
      currentState.copyWith(
        status: RealtimeCallStatus.initial,
        error: null,
        session: null,
      ),
    );

    final instructions = TutorInstruction.repeatTutor(
      topic: topic,
      languageName: language.localizedName,
      levelName: level.localizedName,
      teacherLanguageName: teacherLanguage.localizedName,
    );

    final newSession = await gptService.createSession(instructions);
    final createdAt = DateTime.now();
    realtimeCallNotifier.setState(
      currentState.copyWith(
        session: RealtimeSession(
          createdAt: createdAt,
          topic: topic,
          language: language,
          level: level,
          teacherLanguage: teacherLanguage,
          clientSecret: newSession.clientSecret,
        ),
      ),
    );
    await realtimeWebRTCConnection.connect(newSession.clientSecret);
    final sessionId = await sessionsDurationsDao.startSession();
    await realtimeWebRTCConnection.setSpeakerEnabled(true);
    await appRouter.push(const RealtimeCallRoute());
    realtimeWebRTCConnection.disconnect();
    await sessionsDurationsDao.finishSession(sessionId);
  }

  Future<void> toggleMic() async {
    final currentState = realtimeCallNotifier.state;
    await realtimeWebRTCConnection.setMicEnabled(!currentState.isMuted);
  }
}
