import 'package:drift/drift.dart';
import 'package:kount/db/models/models.dart';
import 'package:kount/domain/domain.dart';
import 'package:kount/domain/models/models.dart';
import 'package:nanoid2/nanoid2.dart';

class RecordDbRepository extends RecordRepository {
  final AppDatabase appDb;

  RecordDbRepository({required this.appDb});

  @override
  Future<void> addRecord(actId, {date}) async {
    await appDb.into(appDb.recordDb).insert(RecordDbCompanion.insert(
          id: nanoid(),
          activityId: actId,
          createdAt: date ?? DateTime.now(),
        ));
  }

  @override
  Future<List<Record>> getRecords(actId, {required range}) async {
    final query = appDb.select(appDb.recordDb);
    query.where(
      (r) =>
          r.activityId.equals(actId) &
          r.createdAt.isBetweenValues(range.start, range.end),
    );

    final recordsDb = await query.get();
    final records = recordsDb.map((r) {
      return Record(id: r.id, createAt: r.createdAt);
    }).toList();
    return records;
  }

  @override
  Future<void> removeLastRecordFromDate(String actId, DateTime date) async {
    final dateRecords = await (appDb.select(appDb.recordDb)
          ..where(
            (r) =>
                r.activityId.equals(actId) &
                r.createdAt.isBetweenValues(
                  date.copyWith(hour: 0, minute: 0, second: 0),
                  date.copyWith(hour: 23, minute: 59, second: 59),
                ),
          )
          ..orderBy(
            [(r) => OrderingTerm(expression: r.createdAt)],
          ))
        .get();
    if (dateRecords.isEmpty) return;
    final toDelete = appDb.delete(appDb.recordDb)
      ..where((r) => r.id.equals(dateRecords.last.id));
    await toDelete.go();
  }
}
