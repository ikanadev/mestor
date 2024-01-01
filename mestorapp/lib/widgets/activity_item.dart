import 'package:flutter/material.dart';
import 'package:mestorapp/domain/models/models.dart';

// iroh perhaps kevin

class ActivityItem extends StatelessWidget {
  final Activity activity;

  const ActivityItem({super.key, required this.activity});

  void handleTap() {
    print("single tap");
  }

  void handleLongPress() {
    print("double tap");
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: handleTap,
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
              style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
            ),
            Icon(Icons.square, size: 42, color: Colors.grey.shade600),
            Text(
              '8',
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
