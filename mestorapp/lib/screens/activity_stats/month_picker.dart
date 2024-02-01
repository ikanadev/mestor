import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/providers/providers.dart';

import 'providers/providers.dart';

class MonthPicker extends ConsumerWidget {
  final String actId;
  const MonthPicker({super.key, required this.actId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final intl = ref.watch(intlProvider);
    final date = ref.watch(dateProvider);
    final textTheme = Theme.of(context).textTheme;

    void prevMonth() {
      final changeYear = date.month == 1;
      ref.read(dateProvider.notifier).state = date.copyWith(
        year: changeYear ? date.year - 1 : date.year,
        month: changeYear ? 12 : date.month - 1,
      );
    }

    void nextMonth() {
      final changeYear = date.month == 12;
      ref.read(dateProvider.notifier).state = date.copyWith(
        year: changeYear ? date.year + 1 : date.year,
        month: changeYear ? 1 : date.month + 1,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${intl.dateTime.month.format(date)}${now.year != date.year ? ' - ${date.year}' : ''}"
                  .toUpperCase(),
              style: textTheme.titleLarge,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 30),
            onPressed: prevMonth,
          ),
          const SizedBox(width: 6),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 30),
            onPressed: nextMonth,
          ),
        ],
      ),
    );
  }
}
