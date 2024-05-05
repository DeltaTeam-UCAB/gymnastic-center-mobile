import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  const AppTheme({this.isDarkMode = false});

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: Colors.deepPurple,

    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.deepPurple,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60),
        ),
      ),
    ),

    drawerTheme: const DrawerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(100),
        ),
      ),
    ),

  );

  AppTheme copyWith({bool? isDarkMode}) => AppTheme(
    isDarkMode: isDarkMode ?? this.isDarkMode,
  );
}