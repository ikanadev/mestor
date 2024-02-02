import 'package:flutter/material.dart';
import 'package:kount/domain/models/models.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getActivities();
  Future<void> saveActivity(NewActivityData data);
  Future<void> editActivity(EditActivityData data);
  Future<void> deleteActivity(String actId);
}

abstract class RecordRepository {
  Future<void> addRecord(String actId, {DateTime? date});
  Future<void> removeLastRecordFromDate(String actId, DateTime date);
  Future<List<Record>> getRecords(String actId, {required DateTimeRange range});
}
