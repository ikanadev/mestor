import 'package:flutter/material.dart';

enum RecordFilter {
  today,
  thisWeek,
  thisMonth,
  thisYear,
  allTime,
}

extension RecordFilterExtension on RecordFilter {
  String get label {
    switch (this) {
      case RecordFilter.today:
        return "Today";
      case RecordFilter.thisWeek:
        return "This week";
      case RecordFilter.thisMonth:
        return "This month";
      case RecordFilter.thisYear:
        return "This year";
      case RecordFilter.allTime:
        return "All time";
    }
  }

  DateTimeRange get dateTimeRange {
    final end = DateTime.now();
    final now = DateTime.now();
    late DateTime start;
    switch (this) {
      case RecordFilter.today:
        start = DateTime(now.year, now.month, now.day, 0, 0, 0);
      case RecordFilter.thisWeek:
        // mon = 1
        int daysAfterMonday = now.weekday - DateTime.monday;
        start = DateTime(now.year, now.month, now.day - daysAfterMonday);
      case RecordFilter.thisMonth:
        start = DateTime(now.year, now.month);
      case RecordFilter.thisYear:
        start = DateTime(now.year);
      case RecordFilter.allTime:
        start = DateTime(2024);
    }
    return DateTimeRange(start: start, end: end);
  }
}
