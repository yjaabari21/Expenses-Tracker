import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:expenes_tracker/widget/expenses.dart';

var kColorscheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 255, 200, 0),
);

var kDarkMode = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkMode,
        cardTheme: const CardTheme().copyWith(
          color: kDarkMode.primaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkMode.primaryContainer,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorscheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 0, 106, 255),
          foregroundColor: kColorscheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorscheme.primaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorscheme.primaryContainer,
            foregroundColor: Colors.black,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kColorscheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
  //});
}
