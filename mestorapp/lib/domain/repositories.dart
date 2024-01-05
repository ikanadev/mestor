import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/domain/types.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getActivities();
  Future<void> saveActivity(NewActivityData data);
  Future<void> editActivity(EditActivityData data);
  Future<void> addRecord(String actId);
  Future<void> removeLastRecord(String actId);
  Future<List<Record>> getRecords(String actId);
}
