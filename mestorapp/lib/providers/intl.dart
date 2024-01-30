import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateTimeFormatter {
  final dayAbbr = DateFormat.E();
}

class IntlFormatter {
  final DateTimeFormatter dateTime = DateTimeFormatter();
}

final intlProvider = Provider((ref) => IntlFormatter());
