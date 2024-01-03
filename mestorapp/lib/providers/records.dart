import 'package:mestorapp/domain/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_repo.dart';

part 'records.g.dart';

@riverpod
class RecordsNotifier extends _$RecordsNotifier {
  @override
  Future<List<Record>> build(String actId) async {
    final appRepo = ref.watch(appRepoProvider);
    return await appRepo.activityRepo.getRecords(actId);
  }

  Future<void> addRecord() async {
    final appRepo = ref.watch(appRepoProvider);
    await appRepo.activityRepo.addRecord(actId);
    final newRecords = await appRepo.activityRepo.getRecords(actId);
    state = AsyncData(newRecords);
  }
}
