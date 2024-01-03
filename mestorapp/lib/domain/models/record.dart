import 'package:freezed_annotation/freezed_annotation.dart';

part 'record.freezed.dart';

@freezed
class Record with _$Record {
  const factory Record({
    required String id,
    required DateTime createAt,
    }) = _Record;
}
