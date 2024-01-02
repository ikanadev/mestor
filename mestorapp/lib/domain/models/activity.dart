import 'package:freezed_annotation/freezed_annotation.dart';
import 'colors.dart';

part 'activity.freezed.dart';

@freezed
class Activity with _$Activity {
  const factory Activity({
    required String id,
    required String name,
    required String iconName,
    required ActColor color,
    required DateTime createAt,
    DateTime? deletedAt,
    }) = _Activity;
}
