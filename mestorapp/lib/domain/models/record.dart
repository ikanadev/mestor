import 'package:freezed_annotation/freezed_annotation.dart';

part 'record.freezed.dart';
part 'record.g.dart';

@freezed
class Record with _$Record {
  const factory Record({
    required String id,
    required DateTime createAt,
    }) = _Record;
  factory Record.fromJson(Map<String, Object?> json) => _$RecordFromJson(json);
}
