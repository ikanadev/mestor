import 'package:flutter/material.dart';
import 'package:mestorapp/domain/domain.dart';

import 'chart_state.dart';

class ChartData {
  Paint gridLinePaint;
  Rect square;
  List<double> coordsY;
  List<String> dataY;
  double dataUnitHeightY;
  int maxData;

  ChartData({
    required this.gridLinePaint,
    required this.square,
    required this.coordsY,
    required this.dataY,
    required this.dataUnitHeightY,
    required this.maxData,
  });

  factory ChartData.fromData(Size size, List<DayRecords> dayRecords) {
    final linePaint = Paint()
      ..color = Colors.grey.withOpacity(0.25)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final square = Rect.fromLTRB(
      ChartState.paddingX + ChartState.labelSpaceX,
      ChartState.paddingY,
      size.width - ChartState.paddingX,
      size.height - ChartState.paddingY - ChartState.labelSpaceY,
    );

    int maxData = 0;
    for (final dayRecord in dayRecords) {
      if (dayRecord.records.length > maxData) {
        maxData = dayRecord.records.length;
      }
    }

    int rows = 5;
    List<double> coordsY = [];
    final rowH = square.height / rows;
    for (var i = 0; i <= rows; i++) {
      coordsY.add(square.bottom - i * rowH);
    }

    List<String> dataY = [];
    var yDataStep = (maxData / rows).ceil();
    if (yDataStep == 0) {
      yDataStep = 1;
    }
    for (var i = 0; i <= rows; i++) {
      dataY.add("${i * yDataStep}");
    }
    double dataUnitHeightY = square.height / (yDataStep * rows);

    return ChartData(
      gridLinePaint: linePaint,
      square: square,
      coordsY: coordsY,
      dataY: dataY,
      dataUnitHeightY: dataUnitHeightY,
      maxData: maxData,
    );
  }
}
