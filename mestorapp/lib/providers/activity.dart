import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mestorapp/providers/providers.dart';

final activityProvider = FutureProvider.family((ref, String actId) async {
  final acts = await ref.watch(activitiesProvider.future);
  return acts.firstWhere((a) => a.id == actId);
});
