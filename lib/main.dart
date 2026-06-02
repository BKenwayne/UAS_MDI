import 'package:flutter/material.dart';
import 'data/local_storage_service.dart';
import 'pages/splash_screen_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize LocalStorageService
  await LocalStorageService.init();
  
  runApp(const NusaFaunaApp());
}

class NusaFaunaApp extends StatelessWidget {
  const NusaFaunaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaFauna',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Lexend',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal.shade700,
          secondary: Colors.green.shade700,
        ),
        scaffoldBackgroundColor: const Color(0xFFF9FBF9), // Premium soft off-white/light-green background
        cardTheme: const CardThemeData(
          color: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const SplashScreenPage(),
    );
  }
}
