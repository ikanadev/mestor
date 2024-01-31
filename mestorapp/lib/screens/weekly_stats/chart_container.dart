import 'package:flutter/material.dart';
import 'package:mestorapp/utils/utils.dart';

import 'line_chart.dart';

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

class ChartContainer extends StatefulWidget {
  final String actId;
  const ChartContainer({super.key, required this.actId});

  @override
  State<ChartContainer> createState() => _CharContainerState();
}

class _CharContainerState extends State<ChartContainer> {
  late DateTime _date;

  @override
  void initState() {
    _date = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: LineChart(actId: widget.actId, date: _date),
        ),
      ],
    );
  }
}
