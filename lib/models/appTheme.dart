import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.blue,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    primaryColor: Colors.black,
    splashColor: Colors.white,
    buttonColor: Colors.blue,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey,
    appBarTheme: AppBarTheme(
      color: Colors.white10,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    primaryColor: Colors.black,
    splashColor: Colors.white,
    buttonColor: Colors.blue,
  );

}