import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 38, 214, 226)),
  listTileTheme: const ListTileThemeData(
    textColor: Color.fromARGB(255, 25, 39, 48),
    iconColor: Color.fromARGB(255, 25, 39, 48),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: const Color.fromARGB(223, 212, 89, 100),
      foregroundColor: const Color(0xFFFFFFFF),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 25, 39, 48),
  appBarTheme: const AppBarTheme(color: Color.fromARGB(223, 212, 89, 100)),
  listTileTheme: const ListTileThemeData(
    textColor: Color.fromARGB(255, 38, 214, 226),
    iconColor: Color.fromARGB(255, 38, 214, 226),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: const Color.fromARGB(255, 38, 214, 226),
      foregroundColor: const Color.fromARGB(255, 25, 39, 48),
    ),
  ),
);
