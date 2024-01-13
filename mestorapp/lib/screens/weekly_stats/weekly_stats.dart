import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/providers/providers.dart';

import 'stat_type_dropdown.dart';
import 'line_chart.dart';

class WeeklyStats extends ConsumerWidget {
  final String actId;
  const WeeklyStats({super.key, required this.actId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final activityProv = ref.watch(activityProvider(actId));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Week report"),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                activityProv.maybeWhen(
                  data: (act) => Text(
                    "${act.emoji} ${act.name}",
                    style: textTheme.titleLarge,
                  ),
                  orElse: () => Container(),
                ),
                const StatTypeDropdown(),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LineChart()],
          ),
        ],
      ),
    );
  }
}
