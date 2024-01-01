import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/domain/types.dart';
import 'package:mestorapp/providers/providers.dart';
import 'package:mestorapp/widgets/widgests.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actsProv = ref.watch(activitiesNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Mestor")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Home screen"),
          actsProv.when(
            error: (error, _) => Text('$error'),
            loading: () => const CircularProgressIndicator(),
            data: (acts) => Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 120,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.6,
                ),
                itemCount: acts.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == acts.length) {
                    return ElevatedButton(
                      child: const Text("Add"),
                      onPressed: () {
                        ref
                            .read(activitiesNotifierProvider.notifier)
                            .saveActivity(
                              NewActivityData(
                                name: 'some name',
                                iconName: 'icon name',
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
    );
  }
}
