import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kount/domain/domain.dart';
import 'package:kount/domain/models/models.dart';

import 'providers/providers.dart';

class ActivityItem extends ConsumerWidget {
  final Activity activity;
  final void Function(Activity) openActivityMenu;
  const ActivityItem({
    super.key,
    required this.activity,
    required this.openActivityMenu,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final recordsProv = ref.watch(recordsProvider(activity.id));

    void handleAddRecord() {
      ref.read(recordsProvider(activity.id).notifier).addRecord();
    }

    void goToActivityStats() {
      context.push("/activity/${activity.id}/stats");
    }

    return GestureDetector(
			onTap: goToActivityStats,
      onDoubleTap: handleAddRecord,
      onLongPress: () => openActivityMenu(activity),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: activity.color.backgroundColor,
          border: Border.all(color: activity.color.borderColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              activity.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(activity.emoji, style: textTheme.displaySmall),
                Text(
                  recordsProv.maybeWhen(
                    data: (rs) => rs.length.toString(),
                    orElse: () => '-',
                  ),
                  style: textTheme.displaySmall?.copyWith(fontFamily: "monospace"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
