import 'package:flutter/material.dart';
import '../data/local_storage_service.dart';
import 'login_page.dart';
import 'edit_profile_page.dart';
import 'change_password_page.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  // Interactive permanent account deletion dialog
  void _handleDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Color(0xFFC62828)),
              SizedBox(width: 10),
              Text(
                'Hapus Akun Permanen?',
                style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            'Tindakan ini akan menghapus akun Anda beserta seluruh pencapaian, skor kuis, dan lencana secara permanen dari perangkat ini. Tindakan ini tidak dapat dibatalkan.',
            style: TextStyle(fontFamily: 'Lexend'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                navigator.pop();
                await LocalStorageService.instance.clearAllData();
                if (!mounted) return;
                navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Text(
                'Hapus Akun',
                style: TextStyle(
                  color: Color(0xFFC62828),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
            ),
          ],
        );
      },
    );
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
              'Pengaturan Akun',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: brandGreen,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // 1. KEAMANAN & IDENTITAS HEADER
                    const Text(
                      'Keamanan & Identitas',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A20),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Kelola informasi akun dan preferensi keamanan Anda untuk pengalaman Nusafauna yang lebih baik.',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 2. ACCOUNT ACTION TILES (EDIT PROFIL & UBAH KATA SANDI)
                    // Card 1: Edit Profil
                    _buildSettingActionCard(
                      icon: Icons.person_outline_rounded,
                      title: 'Edit Profil',
                      subtitle: 'Nama, foto, dan bio Anda',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Card 2: Ubah Kata Sandi
                    _buildSettingActionCard(
                      icon: Icons.lock_outline_rounded,
                      title: 'Ubah Kata Sandi',
                      subtitle: 'Perbarui keamanan akun Anda',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    // Divider
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 24),

                    // 3. DANGER ZONE SECTION (ZONA BERBAHAYA)
                    const Text(
                      'Zona Berbahaya',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC62828), // Bold red
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Hapus Akun Permanen Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFFFCDD2), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _handleDeleteAccount,
                        icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFC62828), size: 20),
                        label: const Text(
                          'Hapus Akun Permanen',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFFC62828),
                          ),
                        ),
                      ),
                    ),
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

  // Reusable card component for account settings options
  Widget _buildSettingActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  // Icon circular container
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFFE8F5E9), // Light green circle
                    child: Icon(
                      icon,
                      color: const Color(0xFF2E6F33),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
