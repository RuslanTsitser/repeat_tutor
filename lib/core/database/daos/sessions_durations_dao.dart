import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'sessions_durations_dao.g.dart';

/// DAO для работы с сессиями Realtime API
@DriftAccessor(tables: [SessionsDurations])
class SessionsDurationsDao extends DatabaseAccessor<AppDatabase>
    with _$SessionsDurationsDaoMixin {
  SessionsDurationsDao(super.db);

  Future<int> startSession() async {
    final now = DateTime.now();
    final sessionId = now.millisecondsSinceEpoch;
    await into(sessionsDurations).insert(
      SessionsDurationsCompanion(
        sessionId: Value(sessionId),
        createdAt: Value(now),
      ),
    );
    return sessionId;
  }

  Future<void> finishSession(int sessionId) async {
    final now = DateTime.now();
    final record = await (select(
      sessionsDurations,
    )..where((tbl) => tbl.sessionId.equals(sessionId))).getSingleOrNull();
    if (record == null) {
      return;
    }
    final durationInMilliseconds = now
        .difference(record.createdAt)
        .inMilliseconds;
    await (update(
      sessionsDurations,
    )..where((tbl) => tbl.sessionId.equals(sessionId))).write(
      SessionsDurationsCompanion(
        durationInMilliseconds: Value(durationInMilliseconds),
      ),
    );
  }

  Future<Duration> getAllSessionsDurations() async {
    final totalDurationExpression = sessionsDurations.durationInMilliseconds
        .sum();
    final totalDuration =
        await (selectOnly(sessionsDurations)
              ..addColumns([totalDurationExpression]))
            .map((row) => row.read(totalDurationExpression) ?? 0)
            .getSingle();
    return Duration(milliseconds: totalDuration);
  }

  Future<Duration> getTodaySessionsDuration() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final todaySessions =
        await (select(sessionsDurations)..where(
              (tbl) =>
                  (tbl.createdAt.isBiggerOrEqualValue(startOfDay)) &
                  (tbl.createdAt.isSmallerThanValue(endOfDay)),
            ))
            .get();

    final totalMilliseconds = todaySessions.fold<int>(
      0,
      (sum, session) => sum + session.durationInMilliseconds,
    );

    return Duration(milliseconds: totalMilliseconds);
  }
}
