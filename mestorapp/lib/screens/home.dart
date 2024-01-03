import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/domain/types.dart';
import 'package:mestorapp/providers/providers.dart';
import 'package:mestorapp/widgets/widgests.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actsProv = ref.watch(activitiesNotifierProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Mestor")),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "What you did today?",
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lightbulb, size: 14),
                Text(
                  "Long press to see more options",
                  style: textTheme.bodySmall
                      ?.copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const SizedBox(height: 32),
            actsProv.when(
              error: (error, _) => Text('$error'),
              loading: () => const CircularProgressIndicator(),
              data: (acts) => Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 90,
                  ),
                  itemCount: acts.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == acts.length) {
                      return ElevatedButton(
                        child: const Text("Add"),
                        onPressed: () {
                          context.push("/new_activity");
                          return;
                          ref
                              .read(activitiesNotifierProvider.notifier)
                              .saveActivity(
                                NewActivityData(
                                  name: 'mmmmmmmmmmmmmmmmmmmM',
                                  emoji: 'icon name',
                                  color: ActColor.red,
                                ),
                              );
                        },
                      );
                    }
                    return ActivityItem(activity: acts[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
