import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'heading.dart';
import 'chart_container.dart';

class ActivityStats extends ConsumerWidget {
  final String actId;
  const ActivityStats({super.key, required this.actId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weekly stats")),
      body: ListView(
        children: [
          Heading(actId: actId),
          const SizedBox(height: 12),
					ChartContainer(actId: actId),
        ],
      ),
    );
  }
}
