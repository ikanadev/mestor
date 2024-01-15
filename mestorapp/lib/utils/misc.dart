import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission() async {
  if (!Platform.isAndroid) {
    throw Exception("Export data only available in Android devices");
  }
  final status = await Permission.storage.status;
  // if (status == PermissionStatus.granted) return true;
  if (status == PermissionStatus.permanentlyDenied) {
    throw Exception(
      "Permission permanently denied, grant storage permissions in Settings",
    );
  }
  final result = await Permission.manageExternalStorage.request();
  return result == PermissionStatus.granted;
}

DateTimeRange getWeekRange(DateTime date) {
  final startDate = date
      .copyWith(hour: 0, minute: 0, second: 0)
      .subtract(Duration(days: date.weekday - 1));
  final endDate = date
      .copyWith(hour: 23, minute: 59, second: 59)
      .add(Duration(days: 7 - date.weekday));
  return DateTimeRange(start: startDate, end: endDate);
}
