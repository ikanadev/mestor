import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'app_repo.dart';

final recordsProvider =
    AsyncNotifierProvider.family<AsyncRecordsNotifier, List<Record>, String>(
        () {
  return AsyncRecordsNotifier();
});

class AsyncRecordsNotifier extends FamilyAsyncNotifier<List<Record>, String> {
  @override
  Future<List<Record>> build(arg) async {
    final appRepo = ref.watch(appRepoProvider);
    return await appRepo.activityRepo.getRecords(arg);
  }

  Future<void> addRecord() async {
    final appRepo = ref.watch(appRepoProvider);
    await appRepo.activityRepo.addRecord(arg);
    final newRecords = await appRepo.activityRepo.getRecords(arg);
    state = AsyncData(newRecords);
  }

  Future<void> removeLastRecord() async {
    final appRepo = ref.watch(appRepoProvider);
    await appRepo.activityRepo.removeLastRecord(arg);
    final newRecords = await appRepo.activityRepo.getRecords(arg);
    state = AsyncData(newRecords);
  }
}
