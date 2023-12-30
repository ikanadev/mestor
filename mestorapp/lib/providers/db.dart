import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/db/db.dart';

final dbProvider = Provider((ref) => AppDatabase());
