import 'record_filter.dart';

class DateTimeRange {
  final DateTime start;
  final DateTime end;

  DateTimeRange({required this.start, required this.end});

  factory DateTimeRange.fromRecordFilter(RecordFilter filter) {
    final end = DateTime.now();
    final now = DateTime.now();
    late DateTime start;
    switch (filter) {
      case RecordFilter.today:
        start = DateTime(now.year, now.month, now.day, 0, 0, 0);
      case RecordFilter.thisWeek:
        // mon = 1
        int daysAfterMonday = now.weekday - DateTime.monday;
        start = DateTime(
          now.year,
          now.month,
          now.day - daysAfterMonday,
          0,
          0,
          0,
        );
      case RecordFilter.thisMonth:
        start = DateTime(now.year, now.month, 1, 0, 0, 0);
      case RecordFilter.thisYear:
        start = DateTime(now.year, 1, 1, 0, 0, 0);
      case RecordFilter.allTime:
        start = DateTime(2024);
    }
    return DateTimeRange(start: start, end: end);
  }
}
