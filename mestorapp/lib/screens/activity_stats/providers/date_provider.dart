import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateProvider = AutoDisposeStateProvider((_) => DateTime.now());
