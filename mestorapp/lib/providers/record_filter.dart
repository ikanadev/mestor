import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/domain/models/models.dart';

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
