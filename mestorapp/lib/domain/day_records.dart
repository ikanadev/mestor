import 'package:kount/domain/models/models.dart';

class DayRecords {
  DateTime day;
  List<Record> records;
  DayRecords({required this.day, required this.records});

  @override
  String toString() {
    return "$day $records";
  }
}
