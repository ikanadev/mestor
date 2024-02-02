import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kount/domain/domain.dart';

final recordFilterProvider =
    NotifierProvider<RecordFilterNotifier, RecordFilter>(() {
  return RecordFilterNotifier();
});

class RecordFilterNotifier extends Notifier<RecordFilter> {
  @override
  RecordFilter build() {
    return RecordFilter.today;
  }

  void setRecordFilter(RecordFilter filter) {
    state = filter;
  }
}
