import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/providers/providers.dart';
import 'package:mestorapp/widgets/widgets.dart';
import 'package:mestorapp/providers/records.dart';

class History extends ConsumerWidget {
  final String actId;
  const History({super.key, required this.actId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final actProv = ref.watch(activityProvider(actId));
    final recordsProv = ref.watch(recordsProvider(actId));
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
      ),
      body: actProv.when(
        data: (act) => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Text(act.emoji,
                textAlign: TextAlign.center, style: textTheme.displayMedium),
            Text(act.name,
                textAlign: TextAlign.center, style: textTheme.titleLarge),
            const Text("Records"),
            recordsProv.when(
              data: (records) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final rec in records)
                    Text(
                      "${rec.createAt.year}-${rec.createAt.month}-${rec.createAt.day}",
                    ),
                ],
              ),
              loading: () => const Spin(),
              error: (e, _) => Text("Error: ${e.toString()}"),
            )
          ],
        ),
        loading: () => const Spin(),
        error: (e, _) => Text("Error: ${e.toString()}"),
      ),
    );
  }
}
