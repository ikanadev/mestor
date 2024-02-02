import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/providers/providers.dart';

import 'line_chart_painter.dart';
import '../providers/providers.dart';

class LineChart extends ConsumerStatefulWidget {
  final String actId;
  const LineChart({super.key, required this.actId});

  @override
  ConsumerState<LineChart> createState() => _LineChartState();
}

class _LineChartState extends ConsumerState<LineChart> {
  double deltaX = 0.0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final activityProv = ref.watch(activityProvider(widget.actId));
    final recordsProv = ref.watch(recordsProvider(widget.actId));

    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(screenSize.width, 160)),
      child: Listener(
        onPointerMove: (event) {
          setState(() => deltaX = event.delta.dx);
        },
        child: recordsProv.maybeWhen(
          data: (recs) {
            return activityProv.maybeWhen(
              data: (act) {
                return CustomPaint(
                  painter: LineChartPainter(
                    dayRecords: recs,
                    activity: act,
                    deltaX: deltaX,
										canvasWidth: screenSize.width,
                  ),
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
