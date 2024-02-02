import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kount/providers/providers.dart';

import 'month_picker.dart';
import 'line_chart/line_chart.dart';
import 'month_calendar/month_calendar.dart';

class ActivityStats extends ConsumerWidget {
  final String actId;
  const ActivityStats({super.key, required this.actId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityProv = ref.watch(activityProvider(actId));
    return Scaffold(
      backgroundColor: const Color(0xFF060606),
      appBar: AppBar(
        title: Text(activityProv.maybeWhen(
          data: (act) => "${act.emoji} ${act.name}",
          orElse: () => "",
        )),
        centerTitle: true,
        backgroundColor: const Color(0xFF060606),
      ),
      body: ListView(
        children: [
          MonthPicker(actId: actId),
          LineChart(actId: actId),
					const SizedBox(height: 16),
					MonthCalendar(actId: actId),
        ],
      ),
    );
  }
}
