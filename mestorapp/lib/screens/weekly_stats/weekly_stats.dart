import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'line_chart.dart';
import 'heading.dart';

class WeeklyStats extends ConsumerWidget {
  final String actId;
  const WeeklyStats({super.key, required this.actId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weekly stats")),
      body: ListView(
        children: [
          Heading(actId: actId),
          const SizedBox(height: 12),
          LineChart(actId: actId),
        ],
      ),
    );
  }
}
