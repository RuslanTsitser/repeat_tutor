import '../models/realtime_session.dart';
import '../repositories/realtime_session_repository.dart';

/// Use Case для удаления сессии Realtime API
class DeleteRealtimeSessionUseCase {
  const DeleteRealtimeSessionUseCase({required this.repository});
  final RealtimeSessionRepository repository;

  Future<void> execute(RealtimeSession session) async {
    await repository.deleteSession(session);
  }
}
