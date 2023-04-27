import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
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
  dividerTheme: const DividerThemeData(
    thickness: 1,
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(color: Colors.black, fontSize: 18.0),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
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
    thickness: 1,
    color: Color.fromARGB(255, 69, 68, 68),
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(color: Colors.white, fontSize: 18.0),
  ),
);
