import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity.g.dart';

@riverpod
Future<Activity> activity(ActivityRef ref, String actId) async {
  final acts = await ref.watch(activitiesNotifierProvider.future);
  return acts.firstWhere((a) => a.id == actId);
}
