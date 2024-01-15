import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/providers/providers.dart';

import 'line_chart_painter.dart';

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
    final recordsProv = ref.watch(
      recordHistoryProvider(RecordHistoryArgs(_date, widget.actId)),
    );
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text("${_date.year}/${_date.month}/${_date.day}"),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(() {
                  _date = _date.add(const Duration(days: -7));
                }),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
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
                print(recs);
                return CustomPaint(
                  painter: LineChartPainter(),
                  child: const Center(child: Text("Hello there")),
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
