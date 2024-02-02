import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mestorapp/domain/domain.dart';
import 'package:mestorapp/domain/models/models.dart';

import 'chart_state.dart';
import 'chart_data.dart';

class LineChartPainter extends CustomPainter {
  List<DayRecords> dayRecords;
  Activity activity;
  double deltaX;
  double canvasWidth;
  LineChartPainter({
    required this.dayRecords,
    required this.activity,
    required this.deltaX,
    required this.canvasWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final grid = ChartData.fromData(size, dayRecords);
    drawStaticGrid(canvas, grid);
    drawLabels(canvas, grid);
    drawRecords(canvas, grid, size);
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) {
    if (deltaX == 0.0) return false;
    final chartState = ChartState.instance;
    final gridWidth =
        canvasWidth - ChartState.paddingX * 2 - ChartState.labelSpaceX;
    var maxXOffset = canvasWidth;
    maxXOffset = (dayRecords.length - 1) * ChartState.colWidth - gridWidth;
    maxXOffset = maxXOffset / ChartState.scrollXFactor;

    const minXOffset = 0.0;
    if (chartState.xOffset < maxXOffset && deltaX < 0.0) {
      chartState.xOffset = chartState.xOffset - deltaX > maxXOffset
          ? maxXOffset
          : chartState.xOffset - deltaX;
      return true;
    }
    if (chartState.xOffset > minXOffset && deltaX > 0.0) {
      chartState.xOffset = chartState.xOffset - deltaX < minXOffset
          ? minXOffset
          : chartState.xOffset - deltaX;
      return true;
    }
    return false;
  }

  void drawRecords(Canvas canvas, ChartData chartData, Size size) {
    final now = DateTime.now();
    final pathPaint = Paint()
      ..color = activity.color.color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    final path = Path();

    canvas.save();
    canvas.clipRRect(RRect.fromRectXY(chartData.square, 5, 5));
    for (int i = 0; i < dayRecords.length; i++) {
      // original position
      var xCoord = chartData.square.left + i * ChartState.colWidth;
      // substract the offset
      xCoord = xCoord - ChartState.instance.xOffset * ChartState.scrollXFactor;
      canvas.drawLine(
        Offset(xCoord, chartData.square.top),
        Offset(xCoord, chartData.square.bottom),
        chartData.gridLinePaint,
      );
      if (dayRecords[i].day.isAfter(now)) continue;
      final qtty = dayRecords[i].records.length;
      final yCoord = chartData.square.bottom - qtty * chartData.dataUnitHeightY;
      if (i == 0) {
        path.moveTo(xCoord, yCoord);
      } else {
        path.lineTo(xCoord, yCoord);
      }
      /*
      canvas.drawCircle(
        Offset(xCoord, yCoord),
        4,
        Paint()
          ..color = activity.color.color
          ..style = PaintingStyle.fill,
      );
			*/
    }
    canvas.drawPath(path, pathPaint);
    canvas.restore();
  }

  void drawLabels(Canvas canvas, ChartData chartData) {
    final textStyle = TextStyle(
      color: Colors.white.withOpacity(0.7),
      fontSize: 9,
      fontWeight: FontWeight.w300,
    );
    final painter = TextPainter(textDirection: TextDirection.ltr);
    // y labels
    for (int i = 0; i < chartData.dataY.length; i++) {
      painter.text = TextSpan(text: chartData.dataY[i], style: textStyle);
      painter.layout();
      painter.paint(
        canvas,
        Offset(
          chartData.square.left - painter.width - 6,
          chartData.coordsY[i] - painter.height / 2,
        ),
      );
    }
    // X labels
    canvas.save();
    canvas.clipRect(Rect.fromLTRB(
      chartData.square.left - 4,
      chartData.square.bottom,
      chartData.square.right + 4,
      chartData.square.bottom + 14,
    ));
    for (int i = 0; i < dayRecords.length; i++) {
      final xCoord = chartData.square.left +
          i * ChartState.colWidth -
          ChartState.instance.xOffset * 2;
      painter.text = TextSpan(
        text: "${dayRecords[i].day.day}",
        style: textStyle,
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(
          xCoord - painter.width / 2,
          chartData.square.bottom + 5,
        ),
      );
    }
    canvas.restore();
    // X label
    painter.text = TextSpan(text: "Date", style: textStyle);
    painter.layout();
    painter.paint(
      canvas,
      Offset(
        chartData.square.left + chartData.square.width / 2 - painter.width / 2,
        chartData.square.bottom + 15,
      ),
    );
    // Y label
    canvas.save();
    canvas.translate(2, (160 + canvasWidth) / 2);
    canvas.rotate(-pi / 2);
    painter.text = TextSpan(text: "Count", style: textStyle);
    painter.layout();
    painter.paint(
      canvas,
      Offset(
        chartData.square.left + chartData.square.width / 2 - painter.width / 2,
        0,
      ),
    );
    canvas.restore();
  }

  void drawStaticGrid(Canvas canvas, ChartData chartData) {
    canvas.drawRRect(
      RRect.fromRectXY(chartData.square, 5, 5),
      chartData.gridLinePaint,
    );
    for (var i = 1; i < chartData.coordsY.length - 1; i++) {
      final yCoord = chartData.coordsY[i];
      canvas.drawLine(
        Offset(chartData.square.left, yCoord),
        Offset(chartData.square.right, yCoord),
        chartData.gridLinePaint,
      );
    }
  }
}
