import 'package:fpdart/fpdart.dart';
import 'package:mestorapp/domain/models/models.dart';

typedef OptionErr = Option<String>;
typedef EitherActivities = Either<String, List<Activity>>;

class NewActivityData {
  final String name;
  final String iconName;
  final ActColor color;
  NewActivityData({
    required this.name,
    required this.iconName,
    required this.color,
  });
}
