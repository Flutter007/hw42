import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.greenAccent.shade400,
);
final defaultTheme = ThemeData.light();
final lightTheme = defaultTheme.copyWith(
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: lightColorScheme.inversePrimary,
    foregroundColor: lightColorScheme.onPrimaryContainer,
  ),
  cardTheme: CardTheme().copyWith(color: lightColorScheme.inversePrimary),
  inputDecorationTheme: InputDecorationTheme().copyWith(
    focusColor: lightColorScheme.inversePrimary,
    hoverColor: lightColorScheme.inversePrimary,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorScheme.onPrimaryContainer),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorScheme.primary, width: 2.0),
    ),
    labelStyle: TextStyle(color: lightColorScheme.onPrimaryContainer),
  ),
  scaffoldBackgroundColor: lightColorScheme.secondaryContainer,
);
