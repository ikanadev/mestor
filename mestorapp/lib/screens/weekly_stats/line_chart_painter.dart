import 'package:flutter/material.dart';
import 'package:mestorapp/domain/domain.dart';

class Grid {
  Paint linePaint;
  Rect square;
  List<double> xCoords;
  List<double> yCoords;
  List<int> yData;
  List<DayRecords> dayRecords;
  int maxData;
  int minData;

  Grid({
    required this.linePaint,
    required this.square,
    required this.xCoords,
    required this.yCoords,
    required this.yData,
    required this.dayRecords,
    required this.maxData,
    required this.minData,
  });

  factory Grid.fromData(Size size, List<DayRecords> dayRecords) {
    const squarePadding = 20.0;
    const xLabelSize = 12.0;
    const yLabelSize = 8.0;
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

    List<int> yData = [];
    final yDataStep = (maxData / rows).ceil();
    for (var i = 0; i <= rows; i++) {
      yData.add(i * yDataStep);
    }

    return Grid(
      linePaint: linePaint,
      square: square,
      xCoords: xCoords,
      yCoords: yCoords,
      yData: yData,
      dayRecords: dayRecords,
      maxData: maxData,
      minData: 0,
    );
  }
}

class LineChartPainter extends CustomPainter {
  List<DayRecords> dayRecords;
  LineChartPainter(this.dayRecords);

  @override
  void paint(Canvas canvas, Size size) {
    drawContainer(canvas, size);
    final grid = Grid.fromData(size, dayRecords);
    drawGrid(canvas, grid);
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) {
    if (dayRecords.length != oldDelegate.dayRecords.length) return true;
    for (var i = 0; i < dayRecords.length; i++) {
      final current = dayRecords[i];
      final old = oldDelegate.dayRecords[i];
      if (current.day != old.day ||
          current.records.length != old.records.length) {
        return true;
      }
    }
    return false;
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
