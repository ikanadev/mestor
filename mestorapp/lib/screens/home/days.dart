import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/providers.dart';

class Day extends StatelessWidget {
  final DateTime date;
  final bool active;
  final ValueSetter<DateTime> setDate;
  const Day({
    required this.date,
    required this.active,
    required this.setDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: FilledButton(
        onPressed: () {
          if (active) return;
          setDate(date);
        },
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.all(4)),
          backgroundColor: MaterialStatePropertyAll(
            colorScheme.primary.withOpacity(active ? 1.0 : 0.15),
          ),
          elevation: MaterialStatePropertyAll(active ? 2.0 : 0.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: Text(
                "Mon",
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onPrimary.withOpacity(active ? 1.0 : 0.6),
                ),
              ),
            ),
            Text(
              "${date.day}",
              style: textTheme.titleLarge?.copyWith(
                fontWeight: active ? FontWeight.w400 : FontWeight.w300,
                color: colorScheme.onPrimary.withOpacity(active ? 1.0 : 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Days extends ConsumerWidget {
  const Days({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = ref.watch(dayProvider);
    final days = ref.watch(daysProvider);

    void setDate(DateTime date) {
      ref.read(dayProvider.notifier).state = date;
    }

    return SizedBox(
      height: 55,
      child: ListView(
        scrollDirection: Axis.horizontal,
        itemExtent: 50,
        reverse: true,
        children: [
          for (final d in days)
            Day(
              date: d,
              active: day.year == d.year &&
                  day.month == d.month &&
                  day.day == d.day,
              setDate: setDate,
            ),
        ],
      ),
    );
  }
}
