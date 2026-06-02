import 'package:flutter/material.dart';
import '../data/local_storage_service.dart';
import 'login_page.dart';
import 'main_navigation_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 1300));

    if (!mounted) return;

    final storage = LocalStorageService.instance;
    final destination = storage.isLoggedIn() ? const MainNavigationPage() : const LoginPage();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF28542A);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 64,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              const Text(
                'Selamat datang di NusaFauna',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3.5,
                  color: brandGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
