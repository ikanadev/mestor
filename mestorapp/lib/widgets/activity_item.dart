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
    return GestureDetector(
      onTap: handleTap,
      onLongPress: handleLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black45, width: 2),
        ),
        child: Column(
          children: [
            Icon(Icons.square, size: 40, color: Colors.grey.shade600),
            Text(activity.name),
          ],
        ),
      ),
    );
  }
}
