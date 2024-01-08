import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mestorapp/domain/domain.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
class Activity with _$Activity {
  const factory Activity({
    required String id,
    required String name,
    required String emoji,
    required ActColor color,
    required DateTime createAt,
    DateTime? deletedAt,
    }) = _Activity;

  factory Activity.fromJson(Map<String, Object?> json) => _$ActivityFromJson(json);
}

class NewActivityData {
  final String name;
  final String emoji;
  final ActColor color;
  NewActivityData({
    required this.name,
    required this.emoji,
    required this.color,
  });
}

class EditActivityData {
  final String id;
  final String name;
  final String emoji;
  final ActColor color;
  EditActivityData({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
  });
}
