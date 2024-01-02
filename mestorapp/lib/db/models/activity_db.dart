import 'package:drift/drift.dart';
import 'package:mestorapp/domain/models/models.dart';

class ActivityDb extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get iconName => text()();
  IntColumn get color => intEnum<ActColor>()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
