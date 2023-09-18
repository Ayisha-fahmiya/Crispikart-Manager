import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    background: Color(0xfff5f5f5),
    onBackground: Color.fromARGB(255, 22, 0, 0),
    primary: Color(0xFFC73047),
    onPrimary: Colors.white,
    secondary: Colors.black,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    brightness: Brightness.light,
    error: Color(0xffb00020),
    onError: Colors.white,
    outline: Color(0xff801515),
    primaryContainer: Color.fromARGB(255, 255, 225, 225),
    onPrimaryContainer: Colors.white,
  ),
  fontFamily: 'Poppins',
);

class AppTheme {
  AppTheme._();
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC73047)),
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xfff5f5f5),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black54,
      ),
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    fontFamily: 'Poppins',
  );
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC73047)),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white70,
      ),
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white70,
      ),
    ),
    dialogTheme: DialogTheme(
      surfaceTintColor: Colors.black,
      backgroundColor: Colors.grey[900],
      titleTextStyle: TextStyle(
        color: Colors.white70,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
      textColor: Colors.white70,
    ),
    fontFamily: 'Poppins',
  );
}
