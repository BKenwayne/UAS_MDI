import 'package:flutter/material.dart';
import '../data/local_storage_service.dart';
import '../models/user_profile.dart';
import '../data/dummy_data.dart';

class BadgesPage extends StatefulWidget {
  const BadgesPage({super.key});

  @override
  State<BadgesPage> createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  UserProfile? _profile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    setState(() {
      _profile = LocalStorageService.instance.getCurrentUser();
    });
  }

  // Calculate dynamic tiers based on unlocked count
  String _getNextTier(int unlockedCount) {
    if (unlockedCount < 2) return 'Ranger Muda';
    if (unlockedCount < 5) return 'Ranger Utama';
    if (unlockedCount < 6) return 'Legenda Rimba';
    return 'Penguasa Semesta Nusantara';
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
                          _loadUserProfile();
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

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF28542A);
    final earned = _profile?.earnedBadges ?? [];

    // Construct the actual dynamic badges list from quizzes with corresponding tiers and requirements
    final allBadges = DummyData.quizzes.map((q) {
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

    // Filter badges based on status
    final unlockedBadges = allBadges.where((b) => b['unlocked'] == true).toList();

    final totalBadges = allBadges.length;
    final unlockedCount = unlockedBadges.length;
    final percentProgress = totalBadges > 0 ? (unlockedCount / totalBadges) : 0.0;
    final remainingCount = totalBadges - unlockedCount;
    final nextTier = _getNextTier(unlockedCount);

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
                  backgroundColor: brandGreen.withValues(alpha: 0.1),
                  child: const Icon(Icons.person, color: brandGreen, size: 18),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    // 1. COLLECTION PROGRESS HEADER CARD (KEMAJUAN KOLEKSI)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 12, bottom: 28, left: 24, right: 24),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2E6F33), // Vibrant grass-green matching theme
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Kemajuan Koleksi',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B5E3C), // Earthy label brown
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Ratio + Percentage row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$unlockedCount/$totalBadges Lencana\nTerkumpul',
                                  style: const TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF212121),
                                    height: 1.2,
                                  ),
                                ),
                                Text(
                                  '${(percentProgress * 100).toInt()}%',
                                  style: const TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E6F33),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Progress bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: percentProgress,
                                minHeight: 8,
                                backgroundColor: const Color(0xFFECEFF1),
                                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2E6F33)),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Description text
                            Text(
                              remainingCount > 0 
                                ? 'Dapatkan $remainingCount lencana lagi untuk naik ke level $nextTier!'
                                : 'Selamat! Anda telah mengumpulkan seluruh lencana dan menjadi $nextTier!',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 11,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 2. ALL BADGES SECTION (GRID)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Daftar Lencana',
                                style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF212121),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '$unlockedCount/$totalBadges Terbuka',
                                  style: const TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E6F33),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // 2-Column Grid Layout for all dynamic badges
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 0.82,
                            ),
                            itemCount: allBadges.length,
                            itemBuilder: (context, index) {
                              final badge = allBadges[index];
                              final unlocked = badge['unlocked'] as bool;
                              final badgeColor = badge['tierColor'] as Color;

                              return GestureDetector(
                                onTap: () => _showBadgeDetailDialog(badge),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: badgeColor,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.04),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          badge['name'] as String,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Lexend',
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: unlocked 
                                                ? (badge['name'] == 'Pelindung Satwa' || badge['name'] == 'Pakar Burung' 
                                                    ? const Color(0xFF5D4037) 
                                                    : const Color(0xFF1E3A20))
                                                : const Color(0xFF546E7A),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.3),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          unlocked ? 'TERBUKA' : 'TERKUNCI',
                                          style: TextStyle(
                                            fontSize: 8.5,
                                            fontWeight: FontWeight.w800,
                                            color: unlocked 
                                                ? (badge['name'] == 'Pelindung Satwa' || badge['name'] == 'Pakar Burung' 
                                                    ? const Color(0xFF5D4037) 
                                                    : const Color(0xFF1E3A20))
                                                : const Color(0xFF546E7A),
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 3. INSTRUCTION INFORMATION CARD
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9), // Clean light green
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Color(0xFF2E6F33),
                              size: 24,
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ketuk lencana untuk melihat detail',
                                    style: TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2E6F33),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Setiap lencana memiliki tantangan unik. Selesaikan kuis dengan skor kelulusan untuk mendapatkannya!',
                                    style: TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 10.5,
                                      color: Colors.black54,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
    );
  }
}
