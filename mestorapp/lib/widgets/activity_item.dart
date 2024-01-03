import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/providers/providers.dart';

// iroh perhaps kevin

class ActivityItem extends ConsumerWidget {
  final Activity activity;
  const ActivityItem({super.key, required this.activity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final recordsProv = ref.watch(recordsNotifierProvider(activity.id));

    void handleAddRecord() {
      ref.read(recordsNotifierProvider(activity.id).notifier).addRecord();
    }

    void handleLongPress() {
      // TODO: implement this
    }

    return GestureDetector(
      onTap: handleAddRecord,
      onLongPress: handleLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white70, width: 1),
        ),
        child: Column(
          children: [
            Text(
              activity.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall,
            ),
            Text(activity.emoji, style: textTheme.displaySmall),
            recordsProv.maybeWhen(
              data: (rs) => Text('${rs.length}', style: textTheme.bodyMedium),
              orElse: () => Text('0', style: textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
