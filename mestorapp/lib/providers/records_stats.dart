import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/domain/domain.dart';
import 'package:mestorapp/domain/models/models.dart';

import 'app_repo.dart';
import 'record_filter.dart';
import 'stat_type.dart';

class RecordStatsArgs {
  DateTime date;
  String actId;
  RecordStatsArgs(this.date, this.actId);
}

final recordsStatsProvider = FutureProvider.autoDispose
    .family<List<Record>, RecordStatsArgs>((ref, args) async {
  final statType = ref.watch(statTypeProvider);
  final appRepo = ref.watch(appRepoProvider);
  if (statType == StatType.weekly) {
    final startDate = args.date
        .copyWith(hour: 0, minute: 0, second: 0)
        .subtract(Duration(days: args.date.weekday - 1));
    final endDate = args.date
        .copyWith(hour: 23, minute: 59, second: 59)
        .add(Duration(days: 7 - args.date.weekday));
    final records = await appRepo.recordRepo.getRecords(
      args.actId,
      range: DateTimeRange(start: startDate, end: endDate),
    );
  }
  return [];
});
