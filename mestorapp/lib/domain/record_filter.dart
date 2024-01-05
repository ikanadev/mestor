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
}
