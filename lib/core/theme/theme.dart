import 'package:expense_tracker/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final colorScheme = ColorScheme.fromSeed(seedColor: AppColors.primary);
  static final colorSchemeDark = ColorScheme.fromSeed(
      brightness: Brightness.dark, seedColor: AppColors.primaryDark);

  static final darkTheme = ThemeData.dark().copyWith(
    colorScheme: colorSchemeDark,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: colorSchemeDark.onPrimaryContainer,
      foregroundColor: colorSchemeDark.primaryContainer,
    ),
    cardTheme: const CardThemeData().copyWith(
      color: colorSchemeDark.secondaryContainer,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: colorSchemeDark.primaryContainer)),
    textTheme: GoogleFonts.protestStrikeTextTheme(Typography.whiteRedmond),
  );

  static final lightTheme = ThemeData().copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: colorScheme.onPrimaryContainer,
      foregroundColor: colorScheme.primaryContainer,
    ),
    cardTheme: const CardThemeData().copyWith(
      color: colorScheme.secondaryContainer,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer)),
    textTheme: GoogleFonts.protestStrikeTextTheme(),
  );
}
