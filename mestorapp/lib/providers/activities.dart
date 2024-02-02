import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kount/domain/models/models.dart';

import 'app_repo.dart';

final activitiesProvider =
    AsyncNotifierProvider<AsyncActivitiesNotifier, List<Activity>>(() {
  return AsyncActivitiesNotifier();
});

class AsyncActivitiesNotifier extends AsyncNotifier<List<Activity>> {
  @override
  Future<List<Activity>> build() async {
    final appRepo = ref.watch(appRepoProvider);
    return await appRepo.activityRepo.getActivities();
  }

  Future<void> deleteActivity(String actId) async {
    final appRepo = ref.watch(appRepoProvider);
    await appRepo.activityRepo.deleteActivity(actId);
    final newActivities = await appRepo.activityRepo.getActivities();
    state = AsyncData(newActivities);
  }

  Future<void> editActivity(EditActivityData data) async {
    final appRepo = ref.watch(appRepoProvider);
    await appRepo.activityRepo.editActivity(data);
    final newActivities = await appRepo.activityRepo.getActivities();
    state = AsyncData(newActivities);
  }

  Future<void> saveActivity(NewActivityData data) async {
    final appRepo = ref.watch(appRepoProvider);
    await appRepo.activityRepo.saveActivity(data);
    final newActivities = await appRepo.activityRepo.getActivities();
    state = AsyncData(newActivities);
  }
}
