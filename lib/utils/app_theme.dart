import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify all listening widgets to rebuild
  }
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green.shade800,
    scaffoldBackgroundColor: Colors.grey.shade100,
    colorScheme: ColorScheme.light(
      primary: Colors.green.shade800,
      secondary: Colors.green.shade600,
      background: Colors.grey.shade100,
      onPrimary: Colors.white,
      onBackground: Colors.black87,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.green.shade800,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey.shade500),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green.shade700,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: ColorScheme.dark(
      primary: Colors.green.shade700,
      secondary: Colors.green.shade500,
      background: const Color(0xFF121212),
      onPrimary: Colors.black,
      onBackground: Colors.white70,
    ),
    appBarTheme: AppBarTheme(
      color: const Color(0xFF1F1F1F),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1F1F1F),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey.shade600),
    ),
  );
}
