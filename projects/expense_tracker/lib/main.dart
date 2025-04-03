import 'package:expense_tracker/expenses_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: Color(0xff2196F3));
ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 44, 73, 233),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kDarkColorScheme.onSecondaryContainer,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        // scaffoldBackgroundColor: const Color(0xffFAFAFA),
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),

        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
          ),
        ),
      ),
      home: const ExpensesController(),
    );
  }
}
