import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/providers/providers.dart';

import 'line_chart_painter.dart';

class LineChart extends ConsumerStatefulWidget {
  final String actId;
  final DateTime date;
  const LineChart({super.key, required this.actId, required this.date});

  @override
  ConsumerState<LineChart> createState() => _LineChartState();
}

class _LineChartState extends ConsumerState<LineChart> {
  double xDelta = 0.0;
  double xOffset = 0.0;

  void setXOffset(double value) {
    setState(() {
      xOffset = value;
      xDelta = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final activityProv = ref.watch(activityProvider(widget.actId));
    final recordsProv = ref.watch(
      recordHistoryProvider(RecordHistoryArgs(widget.date, widget.actId)),
    );
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(screenSize.width, 200)),
      child: Listener(
        onPointerMove: (event) {
          setState(() => xDelta = event.delta.dx);
        },
        child: recordsProv.maybeWhen(
          data: (recs) {
            return activityProv.maybeWhen(
              data: (act) {
                return CustomPaint(
                  painter: LineChartPainter(
                    dayRecords: recs,
                    activity: act,
                    xDelta: xDelta,
                    xOffset: xOffset,
                    setXOffset: setXOffset,
                  ),
                  child: Text("$xOffset"),
                );
              },
              orElse: () => Container(),
            );
          },
          orElse: () => Container(),
        ),
      ),
    );
  }
}
