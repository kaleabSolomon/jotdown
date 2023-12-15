import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 240, 231, 202),
    primary: Color.fromARGB(255, 16, 19, 121),
    secondary: Color.fromARGB(255, 250, 150, 10),
    tertiary: Color.fromARGB(255, 247, 230, 214),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Color.fromARGB(255, 203, 157, 91),
    secondary: Colors.grey.shade700,
    tertiary: Color.fromARGB(255, 47, 47, 47),
  ),
);
