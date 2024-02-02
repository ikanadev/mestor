import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kount/domain/domain.dart';

final statTypeProvider = NotifierProvider<_StateTypeNotifier, StatType>(() {
  return _StateTypeNotifier();
});

class _StateTypeNotifier extends Notifier<StatType> {
  @override
  StatType build() {
    return StatType.weekly;
  }

  void setStatType(StatType type) {
    state = type;
  }
}
