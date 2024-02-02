import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kount/providers/providers.dart';

import '../providers/providers.dart';
import 'month_calendar_painter.dart';

class MonthCalendar extends ConsumerWidget {
  final String actId;
  const MonthCalendar({super.key, required this.actId});

  List<String> getWeekDays(IntlFormatter formatter) {
    final List<String> weekdays = [];
    final now = DateTime.now();
    for (int i = DateTime.monday; i <= DateTime.sunday; i++) {
      final day = now.add(Duration(days: (i - now.weekday + 7) % 7));
      weekdays.add(formatter.dateTime.dayAbbr.format(day));
    }
    return weekdays;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final actProv = ref.watch(activityProvider(actId));
    final recordsProv = ref.watch(recordsProvider(actId));
    final intl = ref.watch(intlProvider);

    return ConstrainedBox(
      constraints: BoxConstraints.tight(
        Size(screenSize.width, 250),
      ),
      child: actProv.maybeWhen(
        data: (act) => recordsProv.maybeWhen(
          data: (recs) => CustomPaint(
            painter: MonthCalendarPainter(
              act: act,
              dayRecords: recs,
              weekdays: getWeekDays(intl),
            ),
          ),
          orElse: () => Container(),
        ),
        orElse: () => Container(),
      ),
    );
  }
}
