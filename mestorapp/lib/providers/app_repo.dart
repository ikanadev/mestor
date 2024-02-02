import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kount/db/db.dart';
import 'package:kount/db/models/database.dart';
import 'package:kount/domain/repositories.dart';

class AppRepo {
  static final AppDatabase db = AppDatabase();
  final ActivityRepository activityRepo;
  final RecordRepository recordRepo;

  AppRepo()
      : activityRepo = ActivityDbRepository(appDb: db),
        recordRepo = RecordDbRepository(appDb: db);
}

final appRepoProvider = Provider((ref) {
  return AppRepo();
});
