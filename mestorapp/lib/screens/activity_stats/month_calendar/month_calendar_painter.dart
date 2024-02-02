import 'package:flutter/material.dart';
import 'package:kount/domain/domain.dart';
import 'package:kount/domain/models/models.dart';

const paddingX = 16.0;

class MonthCalendarPainter extends CustomPainter {
  final Activity act;
  final List<DayRecords> dayRecords;
  final List<String> weekdays;

  const MonthCalendarPainter({
    required this.act,
    required this.dayRecords,
    required this.weekdays,
  });

  @override
  void paint(Canvas canvas, Size size) {
		/// the rect without padding
    final rect = Rect.fromLTRB(paddingX, 0, size.width - paddingX, size.height);
    final itemSize = Size(rect.width / 7, rect.height / 7);
    // draw week days
    var textStyle = TextStyle(
      color: Colors.white.withOpacity(0.7),
      fontSize: 11,
      fontWeight: FontWeight.w500,
    );
    final painter = TextPainter(textDirection: TextDirection.ltr);
    for (var i = 0; i < weekdays.length; i++) {
      painter.text =
          TextSpan(text: weekdays[i].toUpperCase(), style: textStyle);
      painter.layout();
      painter.paint(
        canvas,
        Offset(
          rect.left +
              itemSize.width / 2 +
              i * itemSize.width -
              painter.width / 2,
          itemSize.height / 2,
        ),
      );
    }
    // draw dates
    int row = 1;
    textStyle = TextStyle(
      color: Colors.white.withOpacity(0.8),
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
    final recordTextStyle = TextStyle(
      color: Colors.white.withOpacity(0.9),
      fontSize: 8,
      fontWeight: FontWeight.w500,
    );
    int max = 0;
    for (final dr in dayRecords) {
      if (dr.records.length > max) {
        max = dr.records.length;
      }
    }
    for (var i = 0; i < dayRecords.length; i++) {
      final date = dayRecords[i].day;
      final records = dayRecords[i].records;
      final left = rect.left + itemSize.width * (date.weekday - 1);
      final top = itemSize.height * row;
      // square
      if (records.isNotEmpty) {
        const paddingY = 3;
        final paddingX = (itemSize.width - itemSize.height) / 2;
        canvas.drawRRect(
          RRect.fromLTRBXY(
            left + paddingX,
            top + paddingY,
            left + itemSize.width - paddingX,
            top + itemSize.height - paddingY,
            5.0,
            5.0,
          ),
          Paint()
            ..color = act.color.withOpacity(records.length, max)
            ..style = PaintingStyle.fill,
        );
      }
      // date day
      painter.text = TextSpan(text: date.day.toString(), style: textStyle);
      painter.layout();
      painter.paint(
        canvas,
        Offset(
          left + itemSize.width / 2 - painter.width / 2,
          top + itemSize.height / 2 - painter.height + 4,
        ),
      );
      // date records
      if (records.isNotEmpty) {
        painter.text = TextSpan(
          text: records.length.toString(),
          style: recordTextStyle,
        );
        painter.layout();
        painter.paint(
          canvas,
          Offset(
            left + itemSize.width / 2 - painter.width / 2,
            top + itemSize.height / 2 + 4,
          ),
        );
      }
      if (date.weekday == DateTime.sunday) {
        row++;
      }
    }
  }

  @override
  bool shouldRepaint(covariant MonthCalendarPainter oldDelegate) {
    return false;
  }
}
