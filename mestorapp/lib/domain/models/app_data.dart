import 'package:freezed_annotation/freezed_annotation.dart';

import 'activity.dart';
import 'record.dart';

part 'app_data.freezed.dart';
part 'app_data.g.dart';

@freezed
class AppData with _$AppData {
  const factory AppData({
    required List<Activity> activities,
    required List<Record> records,
    DateTime? deletedAt,
  }) = _AppData;

  factory AppData.fromJson(Map<String, Object?> json) =>
      _$AppDataFromJson(json);
}
