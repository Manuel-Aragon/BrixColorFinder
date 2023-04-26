import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color.fromRGBO(247, 247, 247, 1),
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
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 79, 76, 76),
  appBarTheme: const AppBarTheme(color: Color.fromARGB(223, 67, 64, 65)),
  listTileTheme: const ListTileThemeData(
    textColor: Color.fromARGB(255, 255, 255, 255),
    iconColor: Color.fromARGB(255, 255, 255, 255),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: const Color.fromARGB(223, 212, 89, 100),
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Color.fromARGB(255, 69, 68, 68),
  ),
);
