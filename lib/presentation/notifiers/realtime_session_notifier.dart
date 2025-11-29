import 'package:flutter/foundation.dart';

import '../../domain/models/realtime_session.dart';
import '../../domain/models/session_settings.dart';
import '../../domain/usecases/create_realtime_session_usecase.dart';
import '../../domain/usecases/delete_realtime_session_usecase.dart';
import '../../domain/usecases/get_all_realtime_sessions_usecase.dart';

/// Нотатор для управления списком сессий Realtime API
class RealtimeSessionListNotifier extends ChangeNotifier {
  RealtimeSessionListNotifier({
    required this.getAllSessionsUseCase,
    required this.createSessionUseCase,
    required this.deleteSessionUseCase,
  });
  final GetAllRealtimeSessionsUseCase getAllSessionsUseCase;
  final CreateRealtimeSessionUseCase createSessionUseCase;
  final DeleteRealtimeSessionUseCase deleteSessionUseCase;

  List<RealtimeSession> _sessions = [];
  bool _isLoading = false;
  String? _error;

  List<RealtimeSession> get sessions => _sessions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Загрузить все сессии
  Future<void> loadSessions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _sessions = await getAllSessionsUseCase.execute();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Создать новую сессию
  Future<RealtimeSession?> createSession(SessionSettings settings) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final session = await createSessionUseCase.execute(settings);
      _sessions.insert(0, session);
      _error = null;
      return session;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Удалить сессию
  Future<void> deleteSession(RealtimeSession session) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await deleteSessionUseCase.execute(session);
      _sessions.removeWhere((s) => s.id == session.id);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
