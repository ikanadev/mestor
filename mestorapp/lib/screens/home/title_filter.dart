import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/domain/domain.dart';
import 'package:mestorapp/providers/providers.dart';

class TitleFilter extends ConsumerWidget {
  const TitleFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordFilter = ref.watch(recordFilterProvider);
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withAlpha(150),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (build) => _RecordFilterOptions(),
            );
          },
          child: Text(
            "${recordFilter.label.toLowerCase()}?",
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium?.copyWith(height: 0),
          ),
        ),
      ),
    );
  }
}

class _RecordFilterOptions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: const Text("Filter"),
      children: [
        for (final filter in RecordFilter.values)
          SimpleDialogOption(
            child: Text(filter.label),
            onPressed: () {
              ref.read(recordFilterProvider.notifier).setRecordFilter(filter);
              Navigator.of(context).pop();
            },
          ),
      ],
    );
  }
}
