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
  Future<void> addRecord({DateTime? date}) async {
    final appRepo = ref.watch(appRepoProvider);
    final recordFilter = ref.watch(recordFilterProvider);
    await appRepo.recordRepo.addRecord(arg, date: date);
    final newRecords = await appRepo.recordRepo.getRecords(
      arg,
      range: recordFilter.dateTimeRange,
    );
    state = AsyncData(newRecords);
  }

  @override
  Future<List<Record>> build(arg) async {
    final appRepo = ref.watch(appRepoProvider);
    final recordFilter = ref.watch(recordFilterProvider);
    return await appRepo.recordRepo.getRecords(
      arg,
      range: recordFilter.dateTimeRange,
    );
  }

  Future<void> removeLastRecord() async {
    final appRepo = ref.watch(appRepoProvider);
    final recordFilter = ref.watch(recordFilterProvider);
    await appRepo.recordRepo.removeLastRecordFromDate(arg, DateTime.now());
    final newRecords = await appRepo.recordRepo.getRecords(
      arg,
      range: recordFilter.dateTimeRange,
    );
    state = AsyncData(newRecords);
  }
}
