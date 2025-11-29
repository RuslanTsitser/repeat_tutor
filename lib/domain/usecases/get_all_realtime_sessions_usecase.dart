import '../models/realtime_session.dart';
import '../repositories/realtime_session_repository.dart';

/// Use Case для получения всех сессий Realtime API
class GetAllRealtimeSessionsUseCase {
  const GetAllRealtimeSessionsUseCase({required this.repository});
  final RealtimeSessionRepository repository;

  Future<List<RealtimeSession>> execute() async {
    return await repository.getAllSessions();
  }
}
