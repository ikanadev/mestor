import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kount/domain/models/models.dart';
import 'package:kount/providers/providers.dart';

import 'day_provider.dart';

final recordsProvider =
    AsyncNotifierProvider.family<AsyncRecordsNotifier, List<Record>, String>(
        () {
  return AsyncRecordsNotifier();
});

class AsyncRecordsNotifier extends FamilyAsyncNotifier<List<Record>, String> {
  Future<void> addRecord({DateTime? date}) async {
    final appRepo = ref.read(appRepoProvider);
    final day = ref.read(dayProvider);
    final now = DateTime.now();
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await appRepo.recordRepo.addRecord(
        arg,
        date: now.copyWith(year: day.year, month: day.month, day: day.day),
      );
      return _getRecords();
    });
  }

  @override
  Future<List<Record>> build(arg) async {
    return _getRecords();
  }

  Future<void> removeLastRecord() async {
    final appRepo = ref.read(appRepoProvider);
    final day = ref.read(dayProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await appRepo.recordRepo.removeLastRecordFromDate(arg, day);
      return _getRecords();
    });
  }

  Future<List<Record>> _getRecords() async {
    final appRepo = ref.watch(appRepoProvider);
    final day = ref.watch(dayProvider);
    return appRepo.recordRepo.getRecords(
      arg,
      range: DateTimeRange(
        start: day.copyWith(hour: 0, minute: 0, second: 0),
        end: day.copyWith(hour: 23, minute: 59, second: 59),
      ),
    );
  }
}
