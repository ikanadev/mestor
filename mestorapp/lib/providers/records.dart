import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/domain/domain.dart';
import 'package:mestorapp/domain/models/models.dart';

import 'app_repo.dart';
import 'record_filter.dart';

final recordsProvider =
    AsyncNotifierProvider.family<AsyncRecordsNotifier, List<Record>, String>(
        () {
  return AsyncRecordsNotifier();
});

class AsyncRecordsNotifier extends FamilyAsyncNotifier<List<Record>, String> {
  Future<void> addRecord() async {
    final appRepo = ref.watch(appRepoProvider);
    final recordFilter = ref.watch(recordFilterProvider);
    await appRepo.activityRepo.addRecord(arg);
    final newRecords = await appRepo.activityRepo.getRecords(
      arg,
      range: DateTimeRange.fromRecordFilter(recordFilter),
    );
    state = AsyncData(newRecords);
  }

  @override
  Future<List<Record>> build(arg) async {
    final appRepo = ref.watch(appRepoProvider);
    final recordFilter = ref.watch(recordFilterProvider);
    return await appRepo.activityRepo.getRecords(
      arg,
      range: DateTimeRange.fromRecordFilter(recordFilter),
    );
  }

  Future<void> removeLastRecord() async {
    final appRepo = ref.watch(appRepoProvider);
    final recordFilter = ref.watch(recordFilterProvider);
    await appRepo.activityRepo.removeLastRecord(arg);
    final newRecords = await appRepo.activityRepo.getRecords(
      arg,
      range: DateTimeRange.fromRecordFilter(recordFilter),
    );
    state = AsyncData(newRecords);
  }
}
