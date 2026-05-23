import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../data/local_storage_service.dart';
import '../models/user_profile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserProfile _profile;
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();

  ImageProvider _getAvatarProvider() {
    if (_profile.avatarBase64 != null && _profile.avatarBase64!.isNotEmpty) {
      try {
        return MemoryImage(base64Decode(_profile.avatarBase64!));
      } catch (e) {
        return const AssetImage('assets/images/logo.png');
      }
    }
    return const AssetImage('assets/images/logo.png');
  }

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    final user = LocalStorageService.instance.getCurrentUser();
    if (user != null) {
      _profile = user;
      _nameController.text = user.fullName.isNotEmpty ? user.fullName : "Budi Santoso";
      _bioController.text = user.bio.isNotEmpty ? user.bio : "Sangat mencintai keanekaragaman hayati Indonesia. Berharap bisa terus belajar dan berkontribusi untuk";
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // Handle saving the user profile details
  void _saveProfile() async {
    final newName = _nameController.text.trim();
    final newBio = _bioController.text.trim();

    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama lengkap tidak boleh kosong!', style: TextStyle(fontFamily: 'Lexend')),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final updated = _profile.copyWith(
      fullName: newName,
      bio: newBio,
    );

    await LocalStorageService.instance.saveCurrentUser(updated);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil Anda berhasil diperbarui!', style: TextStyle(fontFamily: 'Lexend')),
          backgroundColor: Color(0xFF2E6F33),
        ),
      );
      Navigator.of(context).pop(true); // Return true to trigger reload
    }
  }

  // Pick / change avatar image dialog
  Future<void> _changeAvatar() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500, // Reasonable max width for avatar
        maxHeight: 500, // Reasonable max height
        imageQuality: 70, // Compress to save storage size
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        final base64String = base64Encode(bytes);

        setState(() {
          _profile = _profile.copyWith(avatarBase64: base64String);
        });

        // Save it immediately so it persists
        await LocalStorageService.instance.saveCurrentUser(_profile);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto profil berhasil diubah!', style: TextStyle(fontFamily: 'Lexend')),
              backgroundColor: Color(0xFF2E6F33),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi kesalahan saat memilih foto.', style: TextStyle(fontFamily: 'Lexend')),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
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
              'Edit Profil',
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
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: _getAvatarProvider(),
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
                    
                    // 1. AVATAR WITH CAMERA OVERLAY IN THE CENTER
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFF5F5F5),
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 64,
                              backgroundImage: _getAvatarProvider(),
                            ),
                          ),
                          // Camera overlap green button
                          InkWell(
                            onTap: _changeAvatar,
                            customBorder: const CircleBorder(),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: brandGreen,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // "Ubah Foto Profil" text button
                    Center(
                      child: TextButton(
                        onPressed: _changeAvatar,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        ),
                        child: const Text(
                          'Ubah Foto Profil',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E6F33),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 2. FORM FIELDS
                    // Label: Nama Lengkap
                    const Text(
                      'Nama Lengkap',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 13.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Textfield: Nama Lengkap
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F2), // Warm cream background
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _nameController,
                        style: const TextStyle(fontFamily: 'Lexend', fontSize: 14),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.grey, size: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Label: Bio
                    const Text(
                      'Bio',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 13.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Textfield: Bio
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _bioController,
                        maxLines: 4,
                        minLines: 3,
                        style: const TextStyle(fontFamily: 'Lexend', fontSize: 13.5, height: 1.4),
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(bottom: 40), // Align icon with top of multiline
                            child: Icon(Icons.description_outlined, color: Colors.grey, size: 20),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 3. SOLID GREEN SAVE BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E6F33),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _saveProfile,
                        child: const Text(
                          'Simpan Perubahan',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 4. SECURITY DATA INFO CARD
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFECEB), // Soft peach card
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.verified_user_outlined,
                              color: brandGreen.withValues(alpha: 0.8),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Keamanan Data',
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Informasi profil Anda akan digunakan untuk meningkatkan pengalaman personalisasi konten satwa.',
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 11.5,
                                    color: Colors.black54,
                                    height: 1.35,
                                  ),
                                ),
                              ],
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
}
