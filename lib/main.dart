import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/widgets.dart';

const _primaryColor = Color(0xFFc7dbf9);

class App {
  const App();
  static const color = _Colors();
  static final text = _Text();
  static final colorScheme = ColorScheme.fromSeed(seedColor: _primaryColor);
}

class _Text {
  _Text();

  final TextStyle text1 = GoogleFonts.protestStrike();
}

class _Colors {
  const _Colors();
  // final Color primary = const Color(0xFF66A5C8);
  final Color primary = _primaryColor;
  final Color secondary = const Color(0xFFB5C9D3);

 final Color background = const Color(0xFFF3F4F4);
  final Color lineWork = const Color(0xFFF3F4F4);
  final Color heading = const Color(0xFFF3F4F4);
  final Color text = const Color(0xFFF3F4F4);



}

void main() {
  return runApp(

    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: App.colorScheme,
        scaffoldBackgroundColor: App.color.background,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: App.colorScheme.onPrimaryContainer,
            foregroundColor: App.colorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: App.colorScheme.primaryContainer
            )
          ),
        // outlinedButtonTheme: OutlinedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //       foregroundColor : App.colorScheme.primaryContainer
        //   )
        // ),


      ),
        debugShowCheckedModeBanner: false,
      home: const Expenses(),
    ),
  );
}
// elevatedButtonTheme: ElevatedButtonThemeData(
// style: ElevatedButton.styleFrom(
// backgroundColor: kColorScheme.primaryContainer,
// ),
// ),
// textTheme: ThemeData().textTheme.copyWith(
// titleLarge: TextStyle(
// fontWeight: FontWeight.normal,
// color: kColorScheme.onSecondaryContainer,
// fontSize: 14,
// ),
// ),