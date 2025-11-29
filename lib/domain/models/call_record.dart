import 'package:equatable/equatable.dart';

/// Доменная модель записи о звонке
class CallRecord extends Equatable {
  // Длительность в минутах

  const CallRecord({
    required this.id,
    required this.sessionId,
    required this.date,
    required this.startTime,
    this.endTime,
    this.durationMinutes = 0,
  });
  final String id;
  final String sessionId;
  final DateTime date; // Дата звонка (только дата, без времени)
  final DateTime startTime; // Время начала звонка
  final DateTime? endTime; // Время окончания звонка
  final int durationMinutes;

  @override
  List<Object?> get props => [
    id,
    sessionId,
    date,
    startTime,
    endTime,
    durationMinutes,
  ];
}
