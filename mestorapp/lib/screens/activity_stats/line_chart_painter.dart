import 'package:flutter/material.dart';
import 'package:mestorapp/domain/domain.dart';
import 'package:mestorapp/domain/models/models.dart';

class Grid {
  Paint linePaint;
  Rect square;
  List<double> xCoords;
  List<double> yCoords;
  List<String> yData;
  double yDataH;
  List<String> xData = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<DayRecords> dayRecords;
  int maxData;
  int minData;

  Grid({
    required this.linePaint,
    required this.square,
    required this.xCoords,
    required this.yCoords,
    required this.yData,
    required this.yDataH,
    required this.dayRecords,
    required this.maxData,
    required this.minData,
  });

  factory Grid.fromData(Size size, List<DayRecords> dayRecords) {
    const squarePadding = 24.0;
    const xLabelSize = 14.0;
    const yLabelSize = 10.0;
    final linePaint = Paint()
      ..color = Colors.grey.withAlpha(50)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final square = Rect.fromPoints(
      const Offset(squarePadding + xLabelSize, squarePadding),
      Offset(
          size.width - squarePadding, size.height - squarePadding - yLabelSize),
    );

    List<double> xCoords = [];
    final colW = square.width / 6;
    for (var i = 0; i < 7; i++) {
      xCoords.add(square.left + i * colW);
    }

    int maxData = 0;
    for (final dayRecord in dayRecords) {
      if (dayRecord.records.length > maxData) {
        maxData = dayRecord.records.length;
      }
    }

    int rows = 1;
    const maxRows = 7;
    if (maxData > 0 && maxData <= maxRows) {
      rows = maxData;
    }
    if (maxData > maxRows) {
      rows = maxRows;
    }

    List<double> yCoords = [];
    final rowH = square.height / rows;
    for (var i = 0; i <= rows; i++) {
      yCoords.add(square.bottom - i * rowH);
    }

    List<String> yData = [];
    var yDataStep = (maxData / rows).ceil();
    if (yDataStep == 0) {
      yDataStep = 1;
    }
    for (var i = 0; i <= rows; i++) {
      yData.add("${i * yDataStep}");
    }
    double yDataH = square.height / (yDataStep * rows);

    return Grid(
      linePaint: linePaint,
      square: square,
      xCoords: xCoords,
      yCoords: yCoords,
      yData: yData,
      yDataH: yDataH,
      dayRecords: dayRecords,
      maxData: maxData,
      minData: 0,
    );
  }
}

class LineChartPainter extends CustomPainter {
  List<DayRecords> dayRecords;
  Activity activity;
  double xDelta;
  double xOffset = 0;
  ValueSetter<double> setXOffset;
  LineChartPainter({
    required this.dayRecords,
    required this.activity,
    required this.xDelta,
    required this.xOffset,
    required this.setXOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    print("Painting");
    drawContainer(canvas, size);
    final grid = Grid.fromData(size, dayRecords);
    drawGrid(canvas, grid);
    drawLabels(canvas, grid);
    drawRecords(canvas, grid);
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) {
    const maxXOffset = 100.0;
    const minXOffset = 0.0;
    if (xDelta == 0.0) return false;
    if (xOffset < maxXOffset && xDelta > 0.0) {
      setXOffset(xOffset + xDelta > maxXOffset ? maxXOffset : xOffset + xDelta);
    }
    if (xOffset > minXOffset && xDelta < 0.0) {
      setXOffset(xOffset + xDelta < minXOffset ? minXOffset : xOffset + xDelta);
    }
    return xOffset != oldDelegate.xOffset;
    /*
    if (dayRecords.length != oldDelegate.dayRecords.length) return true;
    for (var i = 0; i < dayRecords.length; i++) {
      final current = dayRecords[i];
      final old = oldDelegate.dayRecords[i];
      if (current.day != old.day ||
          current.records.length != old.records.length ||
          activity.id != oldDelegate.activity.id) {
        return true;
      }
    }
    return false;
		*/
  }

  void drawRecords(Canvas canvas, Grid grid) {
    final now = DateTime.now();
    final pathPaint = Paint()
      ..color = activity.color.color.withAlpha(80)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    final path = Path();
    for (int i = 0; i < grid.dayRecords.length; i++) {
      if (grid.dayRecords[i].day.isAfter(now)) continue;
      final qtty = grid.dayRecords[i].records.length;
      final xCoord = grid.xCoords[i];
      final yCoord = grid.square.bottom - qtty * grid.yDataH;
      if (i == 0) {
        path.moveTo(xCoord, yCoord);
      } else {
        path.lineTo(xCoord, yCoord);
      }
      canvas.drawCircle(
        Offset(xCoord, yCoord),
        4,
        Paint()
          ..color = activity.color.color
          ..style = PaintingStyle.fill,
      );
    }
    canvas.drawPath(path, pathPaint);
  }

  void drawLabels(Canvas canvas, Grid grid) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );
    for (int i = 0; i < grid.yData.length; i++) {
      final painter = TextPainter(
        text: TextSpan(text: grid.yData[i], style: textStyle),
        textDirection: TextDirection.ltr,
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(
          grid.square.left - painter.width - 6,
          grid.yCoords[i] - painter.height / 2,
        ),
      );
    }
    for (var i = 0; i < grid.xData.length; i++) {
      final painter = TextPainter(
        text: TextSpan(text: grid.xData[i], style: textStyle),
        textDirection: TextDirection.ltr,
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(
          grid.xCoords[i] - painter.width / 2,
          grid.square.bottom + 6,
        ),
      );
    }
  }

  void drawGrid(Canvas canvas, Grid grid) {
    for (final xCoord in grid.xCoords) {
      canvas.drawLine(
        Offset(xCoord, grid.square.top),
        Offset(xCoord, grid.square.bottom),
        grid.linePaint,
      );
    }
    for (final yCoord in grid.yCoords) {
      canvas.drawLine(
        Offset(grid.square.left, yCoord),
        Offset(grid.square.right, yCoord),
        grid.linePaint,
      );
    }
  }

  void drawContainer(Canvas canvas, Size size) {
    const double radius = 12;
    const double padding = 10;
    final linePaint = Paint()
      ..color = Colors.black.withAlpha(140)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.fill;
    // corners
    var topLeft = const Offset(padding, padding);
    var topRight = Offset(size.width - padding, padding);
    var botRight = Offset(size.width - padding, size.height - padding);
    var botLeft = Offset(padding, size.height - padding);
    final borderPath = Path()
      ..moveTo(topLeft.dx + radius, topLeft.dy)
      ..lineTo(topRight.dx - radius, topRight.dy)
      ..quadraticBezierTo(
          topRight.dx, topRight.dy, topRight.dx, topRight.dy + radius)
      ..lineTo(botRight.dx, botRight.dy - radius)
      ..quadraticBezierTo(
          botRight.dx, botRight.dy, botRight.dx - radius, botRight.dy)
      ..lineTo(botLeft.dx + radius, botLeft.dy)
      ..quadraticBezierTo(
          botLeft.dx, botLeft.dy, botLeft.dx, botLeft.dy - radius)
      ..lineTo(topLeft.dx, topLeft.dy + radius)
      ..quadraticBezierTo(
          topLeft.dx, topLeft.dy, topLeft.dx + radius, topLeft.dy)
      ..close();
    // canvas.drawRect(rect, linePaint);
    canvas.drawPath(borderPath, linePaint);
  }
}
