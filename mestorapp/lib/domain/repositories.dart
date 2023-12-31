import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/domain/types.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getActivities();
  Future<void> saveActivity(NewActivityData data);
}
