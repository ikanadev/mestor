import 'package:flutter_snowflake/flutter_snowflake.dart';
import 'package:mestorapp/db/models/models.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/domain/repositories.dart';
import 'package:mestorapp/domain/types.dart';

class ActivityDbRepository extends ActivityRepository {
  final Snowflake idBuilder;
  final AppDatabase appDb;

  ActivityDbRepository({required this.idBuilder, required this.appDb});

  @override
  Future<List<Activity>> getActivities() async {
    /*
    final query = appDb.select(appDb.activityDb);
    query.where((a) => a.deletedAt.isNotNull());
    final dbActs = await query.get(); */
    final dbActs = await (appDb.select(appDb.activityDb)).get();
    print("ListDB: $dbActs");
    final acts = dbActs.map((act) {
      return Activity(
        id: act.id,
        name: act.name,
        color: act.color,
        iconName: act.iconName,
        createAt: act.createdAt,
        deletedAt: act.deletedAt,
      );
    }).toList();
    print("List: $acts");
    return Future.value(acts);
  }

  @override
  Future<void> saveActivity(NewActivityData data) async {
    print("Data: $data");
    final id = await appDb.into(appDb.activityDb).insert(ActivityDbCompanion.insert(
          id: idBuilder.getId(),
          name: data.name,
          color: data.color,
          iconName: data.iconName,
          createdAt: DateTime.now(),
        ));
    print("ID: $id");
  }
}
