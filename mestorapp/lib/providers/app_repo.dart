import 'package:flutter_snowflake/snowflake.dart';
import 'package:mestorapp/db/db.dart';
import 'package:mestorapp/db/models/database.dart';
import 'package:mestorapp/domain/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_repo.g.dart';

class AppRepo {
  static final AppDatabase db = AppDatabase();
  static final Snowflake idBuilder = Snowflake(0, 0);
  final ActivityRepository activityRepo;

  AppRepo()
      : activityRepo = ActivityDbRepository(appDb: db, idBuilder: idBuilder);
}

@riverpod
AppRepo appRepo(AppRepoRef ref) {
  return AppRepo();
}
