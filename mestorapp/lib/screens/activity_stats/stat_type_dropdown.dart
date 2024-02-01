import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/domain/domain.dart';
import 'package:mestorapp/providers/providers.dart';

class StatTypeDropdown extends ConsumerWidget {
  const StatTypeDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statType = ref.watch(statTypeProvider);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(140),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: DropdownButton<StatType>(
        value: statType,
        padding: EdgeInsets.zero,
        underline: const SizedBox(),
        items: StatType.values.map((type) {
          return DropdownMenuItem<StatType>(
            value: type,
            child: Text(type.label),
          );
        }).toList(),
        onChanged: (val) {
          if (val == null) return;
          ref.read(statTypeProvider.notifier).setStatType(val);
        },
      ),
    );
  }
}
