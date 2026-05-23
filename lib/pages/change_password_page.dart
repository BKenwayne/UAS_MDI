import 'package:flutter/material.dart';
import '../data/local_storage_service.dart';
import '../models/user_profile.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late UserProfile _profile;
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  int _passwordStrength = 0; // 0 to 4 based on criteria

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _newPasswordController.addListener(_calculatePasswordStrength);
  }

  void _loadUserProfile() {
    final user = LocalStorageService.instance.getCurrentUser();
    if (user != null) {
      _profile = user;
    }
  }

  // Calculate password strength dynamically as user types
  void _calculatePasswordStrength() {
    final pwd = _newPasswordController.text;
    int strength = 0;
    if (pwd.isEmpty) {
      strength = 0;
    } else {
      if (pwd.length >= 6) strength++;
      if (pwd.contains(RegExp(r'[A-Z]')) || pwd.contains(RegExp(r'[a-z]'))) strength++;
      if (pwd.contains(RegExp(r'[0-9]'))) strength++;
      if (pwd.contains(RegExp(r'[!@#\$&*~]'))) strength++;
    }
    setState(() {
      _passwordStrength = strength;
    });
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Save the updated password
  void _updatePassword() async {
    final oldPwd = _oldPasswordController.text;
    final newPwd = _newPasswordController.text;
    final confirmPwd = _confirmPasswordController.text;

    if (oldPwd.isEmpty || newPwd.isEmpty || confirmPwd.isEmpty) {
      _showErrorSnackBar('Semua kolom kata sandi wajib diisi!');
      return;
    }

    if (oldPwd != _profile.password) {
      _showErrorSnackBar('Kata sandi lama yang Anda masukkan salah!');
      return;
    }

    if (newPwd.length < 6) {
      _showErrorSnackBar('Kata sandi baru minimal harus 6 karakter!');
      return;
    }

    if (newPwd != confirmPwd) {
      _showErrorSnackBar('Konfirmasi kata sandi baru tidak cocok!');
      return;
    }

    // Save
    final updated = _profile.copyWith(password: newPwd);
    await LocalStorageService.instance.saveCurrentUser(updated);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kata sandi berhasil diperbarui!', style: TextStyle(fontFamily: 'Lexend')),
          backgroundColor: Color(0xFF2E6F33),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  void _showErrorSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontFamily: 'Lexend')),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  // Shows helpful dialog for forgot password link
  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Row(
            children: [
              Icon(Icons.help_outline_rounded, color: Color(0xFF2E6F33)),
              SizedBox(width: 10),
              Text(
                'Lupa Kata Sandi?',
                style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            'Demi menjaga keamanan data, Anda dapat menggunakan kata sandi bawaan "password123" untuk masuk atau melakukan reset penyimpanan lokal melalui opsi Hapus Akun di tab Pengaturan Akun.',
            style: TextStyle(fontFamily: 'Lexend', fontSize: 13, height: 1.45),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Mengerti', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold)),
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
              'Ubah Kata Sandi',
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    // 1. REFRESH SECURITY ICON
                    Center(
                      child: Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC7F3C7), // Light clean warm green
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.published_with_changes_rounded,
                          color: Color(0xFF2E6F33),
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Caption
                    const Text(
                      'Kata sandi baru Anda harus unik untuk menjaga keamanan akun. Pastikan menggunakan kombinasi karakter yang kuat.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 2. FORM FIELDS
                    // Label: Kata Sandi Saat Ini
                    const Text(
                      'Kata Sandi Saat Ini',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 13.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // TF: Kata Sandi Saat Ini
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F2), // Warm soft cream
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _oldPasswordController,
                        obscureText: _obscureOld,
                        style: const TextStyle(fontFamily: 'Lexend', fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Masukkan kata sandi lama',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13.5),
                          prefixIcon: const Icon(Icons.lock_outline_rounded, color: Colors.grey, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureOld ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _obscureOld = !_obscureOld),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Label: Kata Sandi Baru
                    const Text(
                      'Kata Sandi Baru',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 13.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // TF: Kata Sandi Baru
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _newPasswordController,
                        obscureText: _obscureNew,
                        style: const TextStyle(fontFamily: 'Lexend', fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Buat kata sandi baru',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13.5),
                          prefixIcon: const Icon(Icons.key_rounded, color: Colors.grey, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureNew ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _obscureNew = !_obscureNew),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Password strength indicator horizontal lines
                    Row(
                      children: List.generate(4, (index) {
                        Color barColor = const Color(0xFFE0E0E0); // Grey default
                        if (_passwordStrength > index) {
                          if (_passwordStrength == 1) {
                            barColor = const Color(0xFFE57373); // Red
                          } else if (_passwordStrength == 2) {
                            barColor = const Color(0xFFFFB74D); // Orange
                          } else if (_passwordStrength == 3) {
                            barColor = const Color(0xFFFFF176); // Yellow
                          } else {
                            barColor = const Color(0xFF81C784); // Green matching mockup
                          }
                        }
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: EdgeInsets.only(
                              left: index == 0 ? 0 : 6,
                              right: index == 3 ? 0 : 6,
                            ),
                            decoration: BoxDecoration(
                              color: barColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // Label: Konfirmasi Kata Sandi Baru
                    const Text(
                      'Konfirmasi Kata Sandi Baru',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 13.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // TF: Konfirmasi Kata Sandi Baru
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirm,
                        style: const TextStyle(fontFamily: 'Lexend', fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Ulangi kata sandi baru',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13.5),
                          prefixIcon: const Icon(Icons.verified_user_outlined, color: Colors.grey, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 3. ACTION BUTTON WITH CHECK ICON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E6F33), // Deep forest green
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _updatePassword,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Perbarui Kata Sandi',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.check_circle_outline_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 4. FORGOT PASSWORD LINK
                    Center(
                      child: TextButton(
                        onPressed: _showForgotPasswordDialog,
                        child: const Text(
                          'Lupa kata sandi? >',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8D6E63), // Warm brown
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
}
