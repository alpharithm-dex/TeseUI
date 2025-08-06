import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(
    // Wrap the app in a ChangeNotifierProvider to manage the theme state
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const TeseApp(),
    ),
  );
}

class TeseApp extends StatelessWidget {
  const TeseApp({super.key});

  @override
  Widget build(BuildContext context) {
    // The Consumer widget listens for changes in the ThemeProvider
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Tese',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          // Set the theme mode based on the provider's state
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
    );
  }
}
