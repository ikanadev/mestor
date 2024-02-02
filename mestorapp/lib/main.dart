import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kount/router.dart';

import 'themes.dart';

void main() {
  Intl.defaultLocale = "en_US";
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mestor',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      themeMode: ThemeMode.dark,
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
    );
  }
}
