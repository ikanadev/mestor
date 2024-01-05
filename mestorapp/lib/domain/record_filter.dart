enum RecordFilter {
  today,
  thisWeek,
  lastWeek,
  thisMonth,
  lastMonth,
  thisYear,
  lastYear,
  allTime,
}

String getRecordFilterLabel(RecordFilter filter) {
  switch (filter) {
    case RecordFilter.today:
      return "today";
    case RecordFilter.thisWeek:
      return "this week";
    case RecordFilter.lastWeek:
      return "last week";
    case RecordFilter.thisMonth:
      return "this month";
    case RecordFilter.lastMonth:
      return "last month";
    case RecordFilter.thisYear:
      return "this year";
    case RecordFilter.lastYear:
      return "last year";
    case RecordFilter.allTime:
      return "all time";
  }
}
