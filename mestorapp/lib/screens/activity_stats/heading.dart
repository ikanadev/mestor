import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/providers/providers.dart';

import 'stat_type_dropdown.dart';

class Heading extends ConsumerWidget {
  final String actId;
  const Heading({super.key, required this.actId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final activityProv = ref.watch(activityProvider(actId));
    return Container(
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
    );
  }
}
