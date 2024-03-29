import 'package:go_router/go_router.dart';
import 'package:kount/screens/screens.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: "/new_activity",
      builder: (_, __) => const NewActivity(),
    ),
    GoRoute(
      path: "/edit_activity/:id",
      builder: (_, state) => EditActivity(actId: state.pathParameters["id"]!),
    ),
    GoRoute(
      path: "/history/:id",
      builder: (_, state) => History(actId: state.pathParameters["id"]!),
    ),
    GoRoute(
      path: "/settings",
      builder: (_, __) => const SettingsScreen(),
    ),
    GoRoute(
      path: "/activity/:id/stats",
      builder: (_, state) => ActivityStats(actId: state.pathParameters["id"]!),
    ),
  ],
);
