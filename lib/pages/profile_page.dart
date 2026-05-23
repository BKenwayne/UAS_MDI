import 'package:flutter/material.dart';
import 'dart:convert';
import '../data/local_storage_service.dart';
import '../mixins/profile_listener_mixin.dart';
import '../data/dummy_data.dart';
import '../models/user_profile.dart';
import 'login_page.dart';
import 'badges_page.dart';
import 'account_settings_page.dart';
import 'help_center_page.dart';
import 'about_us_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> with ProfileListenerMixin {
  UserProfile? _profile;

  @override
  void onProfileChanged() => loadUserProfile();

  ImageProvider _getAvatarProvider() {
    if (_profile != null && _profile!.avatarBase64 != null && _profile!.avatarBase64!.isNotEmpty) {
      try {
        return MemoryImage(base64Decode(_profile!.avatarBase64!));
      } catch (e) {
        return const AssetImage('assets/images/logo.png');
      }
    }
    return const AssetImage('assets/images/logo.png');
  }

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  void loadUserProfile() {
    setState(() {
      _profile = LocalStorageService.instance.getCurrentUser();
    });
  }

  void _handleLogout() async {
    _showConfirmDialog(
      title: 'Keluar Akun',
      content: 'Apakah Anda yakin ingin keluar dari akun NusaFauna saat ini?',
      confirmText: 'Keluar',
      isDestructive: true,
      onConfirm: () async {
        await LocalStorageService.instance.logout();
        _navigateToLogin();
      },
    );
  }

  void _navigateToLogin() {
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void _showConfirmDialog({
    required String title,
    required String content,
    required String confirmText,
    required bool isDestructive,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(title, style: const TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold)),
          content: Text(content, style: const TextStyle(fontFamily: 'Lexend')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(
                confirmText,
                style: TextStyle(
                  color: isDestructive ? const Color(0xFFC62828) : const Color(0xFF2E6F33),
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

  Color _getBadgeBgColor(String badgeName) {
    switch (badgeName) {
      case 'Ahli Sumatra':
      case 'Penjelajah Harian':
        return const Color(0xFFB08968); // Tier Mudah: Coklat / Bronze
      case 'Pakar Jawa':
      case 'Ksatria Kalimantan':
        return const Color(0xFFB0BEC5); // Tier Sedang: Silver
      case 'Pelindung Satwa':
      case 'Pakar Burung':
        return const Color(0xFFFFD54F); // Tier Sulit: Emas / Gold
      default:
        return const Color(0xFF005691); // Default Rank
    }
  }

  Color _getBadgeTextColor(String badgeName) {
    switch (badgeName) {
      case 'Pelindung Satwa':
      case 'Pakar Burung':
        return const Color(0xFF5D4037); // Dark brown text for Gold badge
      default:
        return Colors.white;
    }
  }

  void _showBadgeDetailDialog(Map<String, dynamic> badge) {
    final unlocked = badge['unlocked'] as bool;
    final badgeName = badge['name'] as String;
    final tierColor = badge['tierColor'] as Color;
    final tierName = badge['tierName'] as String;
    final requirement = badge['requirement'] as String;
    final icon = badge['icon'] as IconData;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Badge Tier Colored Container in Dialog
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: tierColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: tierColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(
                      unlocked ? icon : Icons.lock_rounded,
                      size: 38,
                      color: unlocked 
                          ? (badgeName == 'Pelindung Satwa' || badgeName == 'Pakar Burung' 
                              ? const Color(0xFF5D4037) 
                              : const Color(0xFF1E3A20))
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Badge Title
              Text(
                badgeName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'LilitaOne',
                  fontSize: 22,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 6),
              // Badge Tier Info Chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: tierColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: tierColor.withValues(alpha: 0.5), width: 1),
                ),
                child: Text(
                  'Tier: $tierName',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: badgeName == 'Pelindung Satwa' || badgeName == 'Pakar Burung' 
                        ? const Color(0xFF5D4037) 
                        : (badgeName == 'Pakar Jawa' || badgeName == 'Ksatria Kalimantan' ? const Color(0xFF37474F) : const Color(0xFF5D4037)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Lock / Unlock Status Text Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: unlocked ? const Color(0xFFE8F5E9) : const Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      unlocked ? Icons.check_circle_rounded : Icons.lock_outline_rounded,
                      color: unlocked ? const Color(0xFF2E6F33) : Colors.grey.shade600,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        unlocked ? 'Lencana Terbuka' : 'Lencana Terkunci',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: unlocked ? const Color(0xFF2E6F33) : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Persyaratan Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Persyaratan Mendapatkan:',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  requirement,
                  style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 13,
                    color: Color(0xFF424242),
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Tutup',
                        style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  if (unlocked) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E6F33),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () async {
                          if (_profile == null) return;
                          final dialogContext = context;
                          final messenger = ScaffoldMessenger.of(dialogContext);
                          final updated = _profile!.copyWith(activeBadge: badgeName);
                          await LocalStorageService.instance.saveCurrentUser(updated);
                          if (!dialogContext.mounted) return;
                          Navigator.of(dialogContext).pop();
                          loadUserProfile();
                          messenger.showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xFF2E6F33),
                              content: Text(
                                'Lencana "$badgeName" berhasil dipasang!',
                                style: const TextStyle(fontFamily: 'Lexend', color: Colors.white),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text(
                          'Gunakan',
                          style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showChangeBadgeBottomSheet() {
    if (_profile == null) return;
    
    final earned = _profile!.earnedBadges;
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pilih Lencana Aktif',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Lencana terpilih akan ditampilkan di bawah foto profil Anda.',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              if (earned.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: const [
                      Icon(Icons.lock_outline_rounded, size: 48, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                        'Belum Ada Lencana Terbuka',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Selesaikan kuis untuk memenangkan lencana!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: earned.length + 1, // +1 for default rank option
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        final isSelected = _profile!.activeBadge == null;
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFECEFF1),
                            child: Icon(Icons.remove_circle_outline_rounded, color: Colors.grey),
                          ),
                          title: const Text(
                            'Gunakan Gelar Bawaan (Pecinta Alam)',
                            style: TextStyle(fontFamily: 'Lexend', fontSize: 13.5, fontWeight: FontWeight.bold),
                          ),
                          trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: Color(0xFF2E6F33)) : null,
                          onTap: () async {
                            final sheetContext = context;
                            final updated = _profile!.copyWith(clearActiveBadge: true);
                            await LocalStorageService.instance.saveCurrentUser(updated);
                            if (!sheetContext.mounted) return;
                            Navigator.of(sheetContext).pop();
                            loadUserProfile();
                          },
                        );
                      }

                      final badgeName = earned[index - 1];
                      final isSelected = _profile!.activeBadge == badgeName;
                      final bgColor = _getBadgeBgColor(badgeName);
                      final textColor = _getBadgeTextColor(badgeName);

                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFF1F8E9) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: bgColor,
                            child: Icon(
                              Icons.workspace_premium_outlined,
                              color: textColor,
                            ),
                          ),
                          title: Text(
                            badgeName,
                            style: const TextStyle(fontFamily: 'Lexend', fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: Color(0xFF2E6F33)) : null,
                          onTap: () async {
                            final sheetContext = context;
                            final updated = _profile!.copyWith(activeBadge: badgeName);
                            await LocalStorageService.instance.saveCurrentUser(updated);
                            if (!sheetContext.mounted) return;
                            Navigator.of(sheetContext).pop();
                            loadUserProfile();
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF28542A);
    
    // Live refresh user profile from LocalStorage
    _profile = LocalStorageService.instance.getCurrentUser();

    final displayFullName = (_profile?.fullName != null && _profile!.fullName.isNotEmpty) 
        ? _profile!.fullName 
        : 'Ikbal NusaFauna';
    
    // Dynamic Stats Calculations
    final completedCount = _profile?.completedQuizzes.length ?? 0;
    final totalScore = _profile?.quizScores.values.fold<int>(0, (sum, val) => sum + val) ?? 0;
    final pointCount = totalScore * 10;
    final satwaSeen = _profile?.viewedAnimalIds.length ?? 0;

    final earned = _profile?.earnedBadges ?? [];
    
    // Construct the actual dynamic badges list from quizzes with corresponding tiers and requirements
    final badgesList = DummyData.quizzes.map((q) {
      final unlocked = earned.contains(q.badgeName);
      final isGold = q.badgeName == 'Pelindung Satwa' || q.badgeName == 'Pakar Burung';
      final isSilver = q.badgeName == 'Pakar Jawa' || q.badgeName == 'Ksatria Kalimantan';
      
      Color tierColor;
      String tierName;
      if (isGold) {
        tierColor = const Color(0xFFFFD54F); // Gold
        tierName = 'Sulit';
      } else if (isSilver) {
        tierColor = const Color(0xFFB0BEC5); // Silver
        tierName = 'Sedang';
      } else {
        tierColor = const Color(0xFFB08968); // Bronze/Coklat
        tierName = 'Mudah';
      }
      
      IconData icon;
      String requirement;
      switch (q.id) {
        case 'sumatra': 
          icon = Icons.explore_outlined; 
          requirement = 'Selesaikan Kuis "Penjelajah Sumatra" dengan skor minimal 75% untuk membuktikan pemahamanmu tentang satwa pulau sumatra.';
          break;
        case 'jawa': 
          icon = Icons.nature_people_outlined; 
          requirement = 'Selesaikan Kuis "Mamalia Jawa" dengan skor minimal 75% untuk membuktikan pemahamanmu tentang mamalia dan fauna pulau jawa.';
          break;
        case 'kalimantan': 
          icon = Icons.park_outlined; 
          requirement = 'Selesaikan Kuis "Pepohonan Kalimantan" dengan skor minimal 75% untuk membuktikan pemahamanmu tentang pepohonan dan satwa eksotis kalimantan.';
          break;
        case 'bahaya': 
          icon = Icons.warning_amber_rounded; 
          requirement = 'Selesaikan Kuis "Dalam Bahaya" dengan skor minimal 75% untuk membuktikan dedikasimu terhadap perlindungan spesies kritis.';
          break;
        case 'burung': 
          icon = Icons.egg_outlined; 
          requirement = 'Selesaikan Kuis "Bulu Indah Nusantara" dengan skor minimal 75% untuk membuktikan pengetahuanmu tentang spesies unggas eksotis Indonesia.';
          break;
        default: 
          icon = Icons.calendar_today_outlined; 
          requirement = 'Selesaikan Kuis "Kuis Harian: Misteri Rimba" dengan skor minimal 60% untuk menguji wawasan acak fauna nusantara.';
          break;
      }
      
      return {
        'id': q.id,
        'name': q.badgeName,
        'icon': icon,
        'unlocked': unlocked,
        'tierColor': tierColor,
        'tierName': tierName,
        'requirement': requirement,
      };
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 24,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 24,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Text(
                'NUSA FAUNA',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'LilitaOne',
                  color: brandGreen,
                ),
              ),
            ),
            Container(
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
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: brandGreen,
          onRefresh: () async {
            loadUserProfile();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                
                // 1. HUGE CURVED GREEN PROFILE CARD HEADER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 16, bottom: 32, left: 24, right: 24),
                  decoration: const BoxDecoration(
                     color: Color(0xFF2E6F33),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      // White circular bordered profile photo
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              key: ValueKey(_profile?.avatarBase64 ?? 'default'),
                              radius: 46,
                              backgroundImage: _getAvatarProvider(),
                            ),
                          ),
                          // Center positioned Rank Badge (solves lateral cropping)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: GestureDetector(
                                onTap: _showChangeBadgeBottomSheet,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _getBadgeBgColor(_profile?.activeBadge ?? ''),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white, width: 1.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.12),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    _profile?.activeBadge ?? 'Pecinta Alam',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _getBadgeTextColor(_profile?.activeBadge ?? ''),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lexend',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Username Full Name
                      Text(
                        displayFullName,
                        style: const TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Bio di bawah nama
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          (_profile?.bio != null && _profile!.bio.isNotEmpty)
                              ? _profile!.bio
                              : 'Belajar & Lindungi Keanekaragaman Hayati Indonesia! 🌿',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 12.5,
                            color: Colors.white.withValues(alpha: 0.92),
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Join Date
                      Text(
                        'Bergabung sejak ${_profile?.joinedAt ?? 'Mei 2026'}',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 11.5,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 2. STUDY STATISTICS TRIO CARD ROW
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Statistik Belajar',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          // Stat 1: Satwa Dilihat
                          Expanded(
                            child: _buildTrioStatCard(
                              icon: Icons.pets_rounded,
                              iconColor: const Color(0xFF2E6F33),
                              value: "$satwaSeen",
                              subtitle: "SATWA\nDILIHAT",
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Stat 2: Kuis Selesai
                          Expanded(
                            child: _buildTrioStatCard(
                              icon: Icons.assignment_turned_in_rounded,
                              iconColor: const Color(0xFF1976D2),
                              value: "$completedCount",
                              subtitle: "KUIS\nSELESAI",
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Stat 3: Poin Terkumpul
                          Expanded(
                            child: _buildTrioStatCard(
                              icon: Icons.military_tech_outlined,
                              iconColor: const Color(0xFFD84315),
                              value: "$pointCount",
                              subtitle: "POIN\nTERKUMPUL",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // 3. MY BADGES HORIZONTAL SLIDER (LENCANA SAYA)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Lencana Saya',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF212121),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const BadgesPage(),
                                ),
                              ).then((_) => loadUserProfile());
                            },
                            child: const Text(
                              'Lihat Semua',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E6F33),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // Horizontal Slider List
                      SizedBox(
                        height: 155,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: badgesList.length,
                          itemBuilder: (context, index) {
                            final badge = badgesList[index];
                            final unlocked = badge['unlocked'] as bool;
                            final badgeColor = badge['tierColor'] as Color;

                            return GestureDetector(
                              onTap: () => _showBadgeDetailDialog(badge),
                              child: Container(
                                width: 120,
                                margin: const EdgeInsets.only(right: 14, bottom: 4),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: badgeColor,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.04),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Badge Circular container
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        unlocked ? badge['icon'] as IconData : Icons.lock_rounded,
                                        color: unlocked 
                                            ? (badge['name'] == 'Pelindung Satwa' || badge['name'] == 'Pakar Burung' 
                                                ? const Color(0xFF5D4037) 
                                                : const Color(0xFF1E3A20))
                                            : Colors.grey.shade400,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    // Badge Title
                                    Text(
                                      badge['name'] as String,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Lexend',
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.bold,
                                        color: unlocked 
                                            ? (badge['name'] == 'Pelindung Satwa' || badge['name'] == 'Pakar Burung' 
                                                ? const Color(0xFF5D4037) 
                                                : const Color(0xFF1E3A20))
                                            : const Color(0xFF546E7A),
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // 4. NAVIGATION MENU CARD (PENGATURAN MENU LIST)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF9F6), // Soft warm cream
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.01),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Menu 1: Pengaturan Akun
                        _buildMenuListTile(
                          icon: Icons.settings_outlined,
                          title: "Pengaturan Akun",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AccountSettingsPage(),
                              ),
                            ).then((_) => loadUserProfile());
                          },
                        ),
                        const Divider(height: 1, color: Color(0xFFEEEEEE)),
                        // Menu 2: Bantuan
                        _buildMenuListTile(
                          icon: Icons.help_outline_rounded,
                          title: "Bantuan",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HelpCenterPage(),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 1, color: Color(0xFFEEEEEE)),
                        // Menu 3: Tentang Kami
                        _buildMenuListTile(
                          icon: Icons.info_outline_rounded,
                          title: "Tentang Kami",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AboutUsPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // 5. RED LOGOUT BUTTON
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFECEB), // Soft light red
                        foregroundColor: const Color(0xFFC62828), // Bold dark red text
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: _handleLogout,
                      icon: const Icon(Icons.logout_rounded, size: 18),
                      label: const Text(
                        'Keluar',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Application version label
                const Center(
                  child: Text(
                    'Versi Aplikasi 1.0 (Stable)',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Bottom curve wave
                Container(
                  height: 24,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E6F33),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Trio Stat Item Box Builder
  Widget _buildTrioStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6), // Warm cream tint matching cards
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(value,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'LilitaOne',
              color: Color(0xFF1E3A20),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 9,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Navigation Menu List Tile with dynamic red dot indicator option
  Widget _buildMenuListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showRedDot = false,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Icon(icon, color: Colors.black87, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Lexend',
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: SizedBox(
        width: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (showRedDot)
              Container(
                margin: const EdgeInsets.only(right: 8),
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFFC62828), // Notification alert red dot!
                  shape: BoxShape.circle,
                ),
              ),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
