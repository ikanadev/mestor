import 'package:drift/drift.dart';
import 'package:mestorapp/domain/domain.dart';

class ActivityDb extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get emoji => text()();
  IntColumn get color => intEnum<ActColor>()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
