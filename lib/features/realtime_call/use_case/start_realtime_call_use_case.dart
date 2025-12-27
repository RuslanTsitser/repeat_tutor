import '../../../core/database/daos/sessions_durations_dao.dart';
import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';
import '../../../core/domain/models/realtime_session.dart';
import '../../../core/gpt/gpt_service.dart';
import '../../../core/gpt/instructions/tutor_instruction.dart';
import '../../../core/realtime/realtime_webrtc_manager.dart';
import '../../paywall/use_case/open_paywall_use_case.dart';
import '../logic/realtime_call_notifier.dart';

/// Use case для создания новой Realtime-сессии.
class StartRealtimeCallUseCase {
  const StartRealtimeCallUseCase({
    required this.gptService,
    required this.realtimeWebRTCConnection,
    required this.realtimeCallNotifier,
    required this.sessionsDurationsDao,
    required this.openPaywallUseCase,
  });
  final GptService gptService;
  final RealtimeWebRTCConnection realtimeWebRTCConnection;
  final RealtimeCallNotifier realtimeCallNotifier;
  final SessionsDurationsDao sessionsDurationsDao;
  final OpenPaywallUseCase openPaywallUseCase;

  Future<void> start({
    required String topic,
    required Language language,
    required DifficultyLevel level,
    required Language teacherLanguage,
  }) async {
    realtimeCallNotifier.setState(RealtimeCallState.initial());
    final instructions = TutorInstruction.repeatTutor(
      topic: topic,
      languageName: language.localizedName,
      levelName: level.localizedName,
      teacherLanguageName: teacherLanguage.localizedName,
    );

    final newSession = await gptService.createSession(instructions);
    final createdAt = DateTime.now();
    realtimeCallNotifier.setState(
      realtimeCallNotifier.state.copyWith(
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
    realtimeCallNotifier.setState(
      realtimeCallNotifier.state.copyWith(
        sessionId: sessionId,
      ),
    );
    await realtimeWebRTCConnection.setSpeakerEnabled(true);
  }

  Future<void> stop() async {
    realtimeWebRTCConnection.disconnect();
    final sessionId = realtimeCallNotifier.state.sessionId;
    if (sessionId == null) return;
    await sessionsDurationsDao.finishSession(sessionId);
  }

  Future<void> toggleMic() async {
    final currentState = realtimeCallNotifier.state;
    await realtimeWebRTCConnection.setMicEnabled(!currentState.isMuted);
  }
}
