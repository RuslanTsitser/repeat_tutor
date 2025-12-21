import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';
import '../../../core/gpt/gpt_service.dart';
import '../../../core/gpt/instructions/tutor_instruction.dart';
import '../../../core/realtime/realtime_webrtc_manager.dart';
import '../../../core/router/router.dart';
import '../logic/realtime_call_notifier.dart';

/// Use case для создания новой Realtime-сессии.
class StartRealtimeCallUseCase {
  const StartRealtimeCallUseCase({
    required this.gptService,
    required this.realtimeWebRTCConnection,
    required this.realtimeCallNotifier,
    required this.appRouter,
  });
  final GptService gptService;
  final RealtimeWebRTCConnection realtimeWebRTCConnection;
  final RealtimeCallNotifier realtimeCallNotifier;
  final AppRouter appRouter;

  Future<void> execute({
    required Language language,
    required DifficultyLevel level,
    required Language teacherLanguage,
  }) async {
    final currentState = realtimeCallNotifier.state;
    realtimeCallNotifier.setState(
      currentState.copyWith(
        status: RealtimeCallStatus.initial,
        error: null,
      ),
    );

    final instructions = TutorInstruction.repeatTutor(
      languageName: language.localizedName,
      levelName: level.localizedName,
      teacherLanguageName: teacherLanguage.localizedName,
    );

    final newSession = await gptService.createSession(instructions);
    await realtimeWebRTCConnection.connect(newSession.clientSecret);
    await appRouter.push(const RealtimeCallRoute());
    realtimeWebRTCConnection.disconnect();
  }
}
