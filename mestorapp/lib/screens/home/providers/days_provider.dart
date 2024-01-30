import 'package:flutter_riverpod/flutter_riverpod.dart';

final daysProvider = Provider((ref) {
  final List<DateTime> days = [];
  final today = DateTime.now();
  for (var i = 0; i < 30; i++) {
    days.add(today.subtract(Duration(days: i)));
  }
  return days;
});
