import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  final lightTheme = ThemeData.light();
  return lightTheme;
}

// https://coolors.co/045057-0b747b-033d40-072c34-021316
ThemeData getDarkTheme() {
  final darkTheme = ThemeData.dark();
  return darkTheme.copyWith(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: const Color(0xFF0B747B),
      onPrimary: Colors.white,
      // Color? primaryContainer,
      // Color? onPrimaryContainer,
      secondary: const Color(0xFF045057),
      onSecondary: Colors.white,
      // Color? secondaryContainer,
      // Color? onSecondaryContainer,
      tertiary: const Color(0xFF033D40),
      onTertiary: Colors.white,
      // Color? tertiaryContainer,
      // Color? onTertiaryContainer,
      error: darkTheme.colorScheme.error,
      onError: darkTheme.colorScheme.onError,
      // Color? errorContainer,
      // Color? onErrorContainer,
      background: darkTheme.colorScheme.background,
      onBackground: darkTheme.colorScheme.onBackground,
      surface: darkTheme.colorScheme.surface,
      onSurface: darkTheme.colorScheme.onSurface,
      // Color? surfaceVariant,
      // Color? onSurfaceVariant,
      // Color? outline,
      // Color? outlineVariant,
      // Color? shadow,
      // Color? scrim,
      // Color? inverseSurface,
      // Color? onInverseSurface,
      // Color? inversePrimary,
      // Color? surfaceTint,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    ),
  );
}
