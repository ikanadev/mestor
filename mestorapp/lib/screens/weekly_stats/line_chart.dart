import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/providers/providers.dart';
import 'package:mestorapp/utils/utils.dart';

import 'line_chart_painter.dart';

const monthNames = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

class LineChart extends ConsumerStatefulWidget {
  final String actId;
  const LineChart({super.key, required this.actId});

  @override
  ConsumerState<LineChart> createState() => _LineChartState();
}

class _LineChartState extends ConsumerState<LineChart> {
  late DateTime _date;

  @override
  void initState() {
    _date = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final activityProv = ref.watch(activityProvider(widget.actId));
    final recordsProv = ref.watch(
      recordHistoryProvider(RecordHistoryArgs(_date, widget.actId)),
    );
    final range = getWeekRange(_date);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${monthNames[range.start.month - 1]} ${range.start.day}  -  ${monthNames[range.end.month - 1]} ${range.end.day}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.02,
                    wordSpacing: 0.4,
                  ),
                ),
              ),
              IconButton.filledTonal(
                icon: const Icon(Icons.chevron_left, size: 30),
                onPressed: () => setState(() {
                  _date = _date.add(const Duration(days: -7));
                }),
              ),
              const SizedBox(width: 6),
              IconButton.filledTonal(
                icon: const Icon(Icons.chevron_right, size: 30),
                onPressed: () => setState(() {
                  _date = _date.add(const Duration(days: 7));
                }),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            height: 200,
            width: min(screenSize.width, screenSize.height),
            color: Colors.red.withAlpha(5),
            child: recordsProv.maybeWhen(
              data: (recs) {
                return activityProv.maybeWhen(
                  data: (act) {
                    return CustomPaint(painter: LineChartPainter(recs, act));
                  },
                  orElse: () => Container(),
                );
              },
              orElse: () => Container(),
            ),
          ),
        ),
      ],
    );
  }
}
