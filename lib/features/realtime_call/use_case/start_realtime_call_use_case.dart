import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums/difficulty_level.dart';
import '../../../core/domain/enums/language.dart';
import '../../../core/domain/models/realtime_session.dart';
import '../../../core/gpt/instructions/tutor_instruction.dart';
import '../../../infrastructure/core.dart';
import '../../../infrastructure/state_managers.dart';
import '../../../infrastructure/use_case.dart';
import '../logic/realtime_call_notifier.dart';

/// Use case для создания новой Realtime-сессии.
class StartRealtimeCallUseCase {
  const StartRealtimeCallUseCase({
    required this.ref,
  });
  final Ref ref;

  Future<void> start({
    required String topic,
    required Language language,
    required DifficultyLevel level,
    required Language teacherLanguage,
  }) async {
    final realtimeCallNotifier = ref.read(realtimeCallProvider);
    final sessionsDurationsDao = ref
        .read(databaseProvider)
        .sessionsDurationsDao;
    final realtimeWebRTCConnection = ref.read(realtimeWebRTCConnectionProvider);
    realtimeCallNotifier.setState(RealtimeCallState.initial());
    final gptService = ref.read(gptServiceProvider);
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
        callDuration: Duration.zero,
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
    final realtimeWebRTCConnection = ref.read(realtimeWebRTCConnectionProvider);
    final realtimeCallNotifier = ref.read(realtimeCallProvider);
    final profileSettingsNotifier = ref.read(profileSettingsUseCaseProvider);
    final sessionsDurationsDao = ref
        .read(databaseProvider)
        .sessionsDurationsDao;
    realtimeWebRTCConnection.disconnect();
    final sessionId = realtimeCallNotifier.state.sessionId;
    if (sessionId == null) return;
    await sessionsDurationsDao.finishSession(sessionId);
    await profileSettingsNotifier.refreshDurations();
  }

  Future<void> toggleMic() async {
    final realtimeWebRTCConnection = ref.read(realtimeWebRTCConnectionProvider);
    final realtimeCallNotifier = ref.read(realtimeCallProvider);
    final currentState = realtimeCallNotifier.state;
    await realtimeWebRTCConnection.setMicEnabled(!currentState.isMuted);
  }

  Future<void> addSecondCallDuration() async {
    final realtimeCallNotifier = ref.read(realtimeCallProvider);
    final state = realtimeCallNotifier.state;
    final callDuration = state.callDuration;
    if (state.status != RealtimeCallStatus.connected) return;
    if (state.isMuted) return;
    final newCallDuration = callDuration + const Duration(seconds: 1);
    realtimeCallNotifier.setState(
      realtimeCallNotifier.state.copyWith(
        callDuration: newCallDuration,
      ),
    );
    final sessionsDurationsDao = ref
        .read(databaseProvider)
        .sessionsDurationsDao;
    await sessionsDurationsDao.updateSessionDuration(
      state.sessionId!,
      newCallDuration,
    );
  }
}
