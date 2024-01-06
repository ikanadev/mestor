import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/providers/providers.dart';

class ActivityOptionsDialog extends ConsumerWidget {
  final Activity act;

  const ActivityOptionsDialog({super.key, required this.act});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: Column(
        children: [
          Text(
            act.emoji,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Text(act.name, textAlign: TextAlign.center),
        ],
      ),
      children: [
        SimpleDialogOption(
          child: const Text("Delete last record",
              style: TextStyle(color: Colors.redAccent)),
          onPressed: () {
            ref
                .read(recordsProvider(act.id).notifier)
                .removeLastRecord()
                .then((_) {
              context.pop();
            });
          },
        ),
        SimpleDialogOption(
          child: const Text("Edit"),
          onPressed: () {
            context.pop();
            context.push("/edit_activity/${act.id}");
          },
        ),
        SimpleDialogOption(
          child: const Text("Close"),
          onPressed: () {
            context.pop();
          },
        ),
      ],
    );
  }
}
