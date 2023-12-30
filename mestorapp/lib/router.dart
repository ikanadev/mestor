import 'package:go_router/go_router.dart';
import 'package:mestorapp/screens/screens.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (ctx, state) => const HomeScreen(),
    ),
  ],
);
