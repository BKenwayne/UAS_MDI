import 'package:flutter/material.dart';
import '../data/local_storage_service.dart';
import 'home_page.dart';
import 'encyclopedia_page.dart';
import 'quiz_page.dart';
import 'profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => MainNavigationPageState();
}

class MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  final GlobalKey<ProfilePageState> _profileKey = GlobalKey<ProfilePageState>();
  final GlobalKey<EncyclopediaPageState> _encyclopediaKey = GlobalKey<EncyclopediaPageState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    LocalStorageService.instance.addListener(_onProfileUpdated);
    _pages = [
      const HomePage(),
      EncyclopediaPage(key: _encyclopediaKey),
      const QuizPage(),
      ProfilePage(key: _profileKey),
    ];
  }

  @override
  void dispose() {
    LocalStorageService.instance.removeListener(_onProfileUpdated);
    super.dispose();
  }

  void _onProfileUpdated() {
    if (mounted) {
      setState(() {});
    }
    _profileKey.currentState?.loadUserProfile();
  }

  void setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      _encyclopediaKey.currentState?.applyCategoryFromNavigation();
    }
    if (index == 3) {
      _profileKey.currentState?.loadUserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFECEFF1), // Solid off-white background in container for perfect rounded rendering
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent, // Set to transparent so rounded container handles the background
            elevation: 0,
            selectedIndex: _selectedIndex,
            onDestinationSelected: setSelectedIndex,
            indicatorColor: const Color(0xFFE8F5E9), // Soft green capsule indicator matching design
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: Colors.grey),
                selectedIcon: Icon(Icons.home_rounded, color: Color(0xFF28542A)),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Icon(Icons.pets_outlined, color: Colors.grey),
                selectedIcon: Icon(Icons.pets_rounded, color: Color(0xFF28542A)),
                label: 'Satwa',
              ),
              NavigationDestination(
                icon: Icon(Icons.quiz_outlined, color: Colors.grey),
                selectedIcon: Icon(Icons.quiz_rounded, color: Color(0xFF28542A)),
                label: 'Kuis',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded, color: Colors.grey),
                selectedIcon: Icon(Icons.person_rounded, color: Color(0xFF28542A)),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
