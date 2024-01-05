import 'package:mestorapp/domain/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'record_filter.g.dart';

@riverpod
class RecordFilterNotifier extends _$RecordFilterNotifier {
  @override
  RecordFilter build() {
    return RecordFilter.today;
  }

  void setRecordFilter(RecordFilter filter) {
    state = filter;
  }
}
