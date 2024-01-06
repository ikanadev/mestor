import 'package:mestorapp/domain/models/models.dart';
import 'datetime_range.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getActivities();
  Future<void> saveActivity(NewActivityData data);
  Future<void> editActivity(EditActivityData data);
  Future<void> deleteActivity(String actId);
}

abstract class RecordRepository {
  Future<void> addRecord(String actId, {DateTime? date});
  Future<void> removeLastRecord(String actId);
  Future<List<Record>> getRecords(String actId, {required DateTimeRange range});
}
