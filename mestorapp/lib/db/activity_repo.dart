import 'package:drift/drift.dart';
import 'package:mestorapp/db/models/models.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/domain/repositories.dart';
import 'package:mestorapp/domain/types.dart';
import 'package:nanoid2/nanoid2.dart';

class ActivityDbRepository extends ActivityRepository {
  final AppDatabase appDb;

  ActivityDbRepository({required this.appDb});

  @override
  Future<List<Activity>> getActivities() async {
    final query = appDb.select(appDb.activityDb);
    query.where((a) => a.deletedAt.isNull());

    final dbActs = await query.get();
    final acts = dbActs.map((act) {
      return Activity(
        id: act.id,
        name: act.name,
        color: act.color,
        emoji: act.emoji,
        createAt: act.createdAt,
        deletedAt: act.deletedAt,
      );
    }).toList();
    return acts;
  }

  @override
  Future<void> saveActivity(NewActivityData data) async {
    await appDb.into(appDb.activityDb).insert(ActivityDbCompanion.insert(
          id: nanoid(),
          name: data.name,
          color: data.color,
          emoji: data.emoji,
          createdAt: DateTime.now(),
        ));
  }

  @override
  Future<void> editActivity(EditActivityData data) async {
    final toUpdate = appDb.update(appDb.activityDb)
      ..where((a) => a.id.equals(data.id));
    await toUpdate.write(ActivityDbCompanion(
      name: Value(data.name),
      emoji: Value(data.emoji),
      color: Value(data.color),
    ));
  }

  @override
  Future<List<Record>> getRecords(String actId) async {
    final query = appDb.select(appDb.recordDb);
    query.where((r) => r.activityId.equals(actId));

    final recordsDb = await query.get();
    final records = recordsDb.map((r) {
      return Record(id: r.id, createAt: r.createdAt);
    }).toList();
    return records;
  }

  @override
  Future<void> addRecord(String actId) async {
    await appDb.into(appDb.recordDb).insert(RecordDbCompanion.insert(
          id: nanoid(),
          activityId: actId,
          createdAt: DateTime.now(),
        ));
  }
}
