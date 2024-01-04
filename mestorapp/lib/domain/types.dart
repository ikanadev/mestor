import 'package:fpdart/fpdart.dart';
import 'package:mestorapp/domain/models/models.dart';

typedef OptionErr = Option<String>;
typedef EitherActivities = Either<String, List<Activity>>;

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
