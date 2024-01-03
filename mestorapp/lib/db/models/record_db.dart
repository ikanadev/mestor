import 'package:drift/drift.dart';

import 'activity_db.dart';

class RecordDb extends Table {
  TextColumn get id => text()();
  TextColumn get activity => text().references(ActivityDb, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
