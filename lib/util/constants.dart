part of 'util.dart';

const _primaryColor = Color(0xFFc7dbf9);
const _primaryColorDark = Color(0xFF2A3B5F);

class App {
  const App();

  static const print = _appPrint;
  static const color = _Colors();
  static final colorScheme = ColorScheme.fromSeed(seedColor: _primaryColor);
  static final colorSchemeDark = ColorScheme.fromSeed(
      brightness:Brightness.dark,seedColor: _primaryColorDark);
}

class _Colors {
  const _Colors();
  final Color primary = _primaryColor;
  final Color secondary = const Color(0xFFB5C9D3);
  final Color background = const Color(0xFFF3F4F4);
}

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: App.colorSchemeDark,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: App.colorSchemeDark.onPrimaryContainer,
    foregroundColor: App.colorSchemeDark.primaryContainer,
  ),
  cardTheme: const CardTheme().copyWith(
    color: App.colorSchemeDark.secondaryContainer,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: App.colorSchemeDark.primaryContainer)),
  textTheme: GoogleFonts.protestStrikeTextTheme(Typography.whiteRedmond),
);

final lightTheme = ThemeData().copyWith(
  colorScheme: App.colorScheme,
  scaffoldBackgroundColor: App.color.background,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: App.colorScheme.onPrimaryContainer,
    foregroundColor: App.colorScheme.primaryContainer,
  ),
  cardTheme: const CardTheme().copyWith(
    color: App.colorScheme.secondaryContainer,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: App.colorScheme.primaryContainer)),
  textTheme: GoogleFonts.protestStrikeTextTheme(),
);