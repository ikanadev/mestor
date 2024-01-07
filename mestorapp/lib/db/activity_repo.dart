import 'package:drift/drift.dart';
import 'package:mestorapp/db/models/models.dart';
import 'package:mestorapp/domain/domain.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:nanoid2/nanoid2.dart';

class ActivityDbRepository extends ActivityRepository {
  final AppDatabase appDb;

  ActivityDbRepository({required this.appDb});

  @override
  Future<void> deleteActivity(String actId) async {
    final toDelete = appDb.update(appDb.activityDb)
      ..where((a) => a.id.equals(actId));
    await toDelete.write(ActivityDbCompanion(
      deletedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> editActivity(data) async {
    final toUpdate = appDb.update(appDb.activityDb)
      ..where((a) => a.id.equals(data.id));
    await toUpdate.write(ActivityDbCompanion(
      name: Value(data.name),
      emoji: Value(data.emoji),
      color: Value(data.color),
    ));
  }

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
  Future<void> saveActivity(data) async {
    await appDb.into(appDb.activityDb).insert(ActivityDbCompanion.insert(
          id: nanoid(),
          name: data.name,
          color: data.color,
          emoji: data.emoji,
          createdAt: DateTime.now(),
        ));
  }
}
