import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/domain/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_repo.dart';

part 'activities.g.dart';

@riverpod
class ActivitiesNotifier extends _$ActivitiesNotifier {
  @override
  Future<List<Activity>> build() async {
    final appRepo = ref.watch(appRepoProvider);
    return await appRepo.activityRepo.getActivities();
  }

  Future<void> saveActivity(NewActivityData data) async {
    final appRepo = ref.watch(appRepoProvider);
    await appRepo.activityRepo.saveActivity(data);
    final newActivities = await appRepo.activityRepo.getActivities();
    state = AsyncValue.data(newActivities);
  }
}
