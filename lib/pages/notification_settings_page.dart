import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // Notification states
  bool _dailyReminders = true;
  bool _newAnimalDiscoveries = true;
  bool _quizResults = false;
  bool _newsletter = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationPreferences();
  }

  // Load preferences from SharedPreferences
  Future<void> _loadNotificationPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _dailyReminders = prefs.getBool('notify_daily') ?? true;
      _newAnimalDiscoveries = prefs.getBool('notify_discoveries') ?? true;
      _quizResults = prefs.getBool('notify_quiz') ?? false;
      _newsletter = prefs.getBool('notify_newsletter') ?? true;
    });
  }

  // Save specific notification channel state
  Future<void> _savePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Preferensi notifikasi berhasil diperbarui!',
            style: TextStyle(fontFamily: 'Lexend', color: Colors.white),
          ),
          backgroundColor: const Color(0xFF2E6F33),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF28542A);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: brandGreen, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pengaturan Notifikasi',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: brandGreen,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: brandGreen,
                    width: 1.5,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    // 1. TROPICAL JUNGLE BANNER CARD (TETAP TERHUBUNG)
                    Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/lanskap/hutan_sumatera.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              Colors.black.withValues(alpha: 0.7),
                              brandGreen.withValues(alpha: 0.65),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tetap Terhubung',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Atur bagaimana Nusafauna memberikan kabar terbaru tentang satwa nusantara.',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.87), // High readability white-grey
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 2. TOGGLE OPTIONS STACK
                    // Toggle 1: Daily Reminders
                    _buildNotificationToggleCard(
                      icon: Icons.alarm_rounded,
                      iconColor: const Color(0xFF2E6F33),
                      bgColor: const Color(0xFFE8F5E9),
                      title: 'Daily Reminders',
                      subtitle: 'Pengingat harian untuk belajar satwa baru.',
                      value: _dailyReminders,
                      onChanged: (val) {
                        setState(() => _dailyReminders = val);
                        _savePreference('notify_daily', val);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Toggle 2: New Animal Discoveries
                    _buildNotificationToggleCard(
                      icon: Icons.pets_rounded,
                      iconColor: const Color(0xFFD84315),
                      bgColor: const Color(0xFFFBE9E7),
                      title: 'New Animal Discoveries',
                      subtitle: 'Kabar saat spesies baru ditambahkan ke ensiklopedia.',
                      value: _newAnimalDiscoveries,
                      onChanged: (val) {
                        setState(() => _newAnimalDiscoveries = val);
                        _savePreference('notify_discoveries', val);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Toggle 3: Quiz Results
                    _buildNotificationToggleCard(
                      icon: Icons.assignment_turned_in_outlined,
                      iconColor: const Color(0xFF1976D2),
                      bgColor: const Color(0xFFE3F2FD),
                      title: 'Quiz Results',
                      subtitle: 'Notifikasi skor kuis dan pencapaian baru.',
                      value: _quizResults,
                      onChanged: (val) {
                        setState(() => _quizResults = val);
                        _savePreference('notify_quiz', val);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Toggle 4: Newsletter
                    _buildNotificationToggleCard(
                      icon: Icons.mail_outline_rounded,
                      iconColor: Colors.black87,
                      bgColor: const Color(0xFFF5F5F5),
                      title: 'Newsletter',
                      subtitle: 'Artikel mingguan tentang konservasi alam.',
                      value: _newsletter,
                      onChanged: (val) {
                        setState(() => _newsletter = val);
                        _savePreference('notify_newsletter', val);
                      },
                    ),
                    const SizedBox(height: 24),

                    // 3. BOTTOM PRIVACY TIP PANEL
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFECEB), // Light peach pink
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: Color(0xFFC62828),
                            size: 22,
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              'Kami menghormati privasi Anda. Pengaturan ini hanya akan berlaku untuk aplikasi Nusafauna di perangkat ini.',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 11.5,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Green Wave shape
            Container(
              height: 24,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable card component for notification settings toggles
  Widget _buildNotificationToggleCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFF5F5F5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon circular container
            CircleAvatar(
              radius: 22,
              backgroundColor: bgColor,
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 11,
                      color: Colors.black54,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            // Switch
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: const Color(0xFF1E3A20),
              activeTrackColor: const Color(0xFFE8F5E9),
              inactiveThumbColor: Colors.grey.shade400,
              inactiveTrackColor: Colors.grey.shade200,
            ),
          ],
        ),
      ),
    );
  }
}
