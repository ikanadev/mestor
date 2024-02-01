import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/domain/domain.dart';
import 'package:mestorapp/providers/providers.dart';

import 'date_provider.dart';

final recordsProvider =
    AutoDisposeFutureProviderFamily<List<DayRecords>, String>(
        (ref, actId) async {
  final appRepo = ref.watch(appRepoProvider);
  final date = ref.watch(dateProvider);
  final start = DateTime(date.year, date.month);
  final nextMonth = DateTime(
    date.year + (date.month < 12 ? 0 : 1),
    (date.month % 12) + 1,
  );
  final end = nextMonth.subtract(const Duration(milliseconds: 1));
  final totalDays = nextMonth.difference(start).inDays;
  print("Total days: $totalDays");
  final dbRecords = await appRepo.recordRepo.getRecords(
    actId,
    range: DateTimeRange(start: start, end: end),
  );
  final List<DayRecords> dayRecords = [];
  for (var i = 0; i < totalDays; i++) {
    final day = start.add(Duration(days: i));
    final records = dbRecords.where((r) => r.createAt.day == day.day).toList();
    dayRecords.add(DayRecords(day: day, records: records));
  }
  return dayRecords;
});
