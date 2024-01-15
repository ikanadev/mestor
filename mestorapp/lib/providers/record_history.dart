import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mestorapp/domain/domain.dart';
import 'package:mestorapp/utils/utils.dart';

import 'app_repo.dart';
import 'stat_type.dart';

@immutable
class RecordHistoryArgs {
  final DateTime date;
  final String actId;
  const RecordHistoryArgs(this.date, this.actId);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RecordHistoryArgs &&
        other.actId == actId &&
        other.date == date;
  }

  @override
  int get hashCode => Object.hash(date, actId);

  @override
  String toString() {
    return "[$actId]$date";
  }
}

final recordHistoryProvider = FutureProvider.autoDispose
    .family<List<DayRecords>, RecordHistoryArgs>((ref, args) async {
  final statType = ref.watch(statTypeProvider);
  final appRepo = ref.watch(appRepoProvider);
  if (statType == StatType.weekly) {
    final range = getWeekRange(args.date);
    final records = await appRepo.recordRepo.getRecords(
      args.actId,
      range: range,
    );
    final List<DayRecords> data = [];
    for (var i = 0; i < 7; i++) {
      final day = range.start.add(Duration(days: i));
      final toAdd = records.filter((r) {
        final rDate = r.createAt;
        return rDate.year == day.year &&
            rDate.month == day.month &&
            rDate.day == day.day;
      }).toList();
      data.add(DayRecords(day: day, records: toAdd));
    }
    return data;
  }
  return [];
});
