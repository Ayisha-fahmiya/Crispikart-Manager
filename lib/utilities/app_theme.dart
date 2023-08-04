import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC73047)),
  fontFamily: 'Poppins',
);

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC73047)),
  fontFamily: 'Poppins',
);
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme:
      ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
  fontFamily: 'Poppins',
);
