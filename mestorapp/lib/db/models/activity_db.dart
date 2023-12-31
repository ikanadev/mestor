import 'package:drift/drift.dart';
import 'package:mestorapp/domain/models/models.dart';

class ActivityDb extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get iconName => text()();
  IntColumn get color => intEnum<ActColor>()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
