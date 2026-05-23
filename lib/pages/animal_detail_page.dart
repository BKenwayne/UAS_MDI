import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../data/local_storage_service.dart';
import '../widgets/profile_avatar_button.dart';

class AnimalDetailPage extends StatefulWidget {
  final Animal animal;

  const AnimalDetailPage({
    super.key,
    required this.animal,
  });

  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  @override
  void initState() {
    super.initState();
    _markAsViewed();
  }

  void _markAsViewed() async {
    final profile = LocalStorageService.instance.getCurrentUser();
    if (profile != null) {
      if (!profile.viewedAnimalIds.contains(widget.animal.id)) {
        final updatedList = List<String>.from(profile.viewedAnimalIds)..add(widget.animal.id);
        final updatedProfile = profile.copyWith(viewedAnimalIds: updatedList);
        await LocalStorageService.instance.saveCurrentUser(updatedProfile);
      }
    }
  }

  // Helper for quick info: habitat types
  String _getHabitatType(String habitat) {
    final lower = habitat.toLowerCase();
    if (lower.contains('savana') || lower.contains('sabana')) return 'Savana';
    if (lower.contains('laut') || lower.contains('pantai') || lower.contains('terumbu')) return 'Perairan';
    if (lower.contains('pegunungan') || lower.contains('dataran tinggi')) return 'Pegunungan';
    if (lower.contains('musim')) return 'Hutan Musim';
    return 'Hutan Tropis';
  }

  // Helper for quick info: diet types
  String _getDietType(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('harimau') || lower.contains('komodo') || lower.contains('elang')) return 'Karnivora';
    if (lower.contains('gajah') || lower.contains('anoa') || lower.contains('badak')) return 'Herbivora';
    if (lower.contains('orangutan') || lower.contains('maleo') || lower.contains('jalak') || lower.contains('cenderawasih') || lower.contains('enggang')) return 'Omnivora';
    if (lower.contains('penyu')) return 'Herbivora';
    if (lower.contains('hiu')) return 'Planktonivora';
    return 'Omnivora';
  }

  // Helper for quick info: region origins
  String _getOriginAbbreviation(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('harimau') || lower.contains('gajah') || lower.contains('orangutan') || lower.contains('penyu')) return 'Sumatra';
    if (lower.contains('anoa') || lower.contains('maleo')) return 'Sulawesi';
    if (lower.contains('komodo')) return 'NTT';
    if (lower.contains('badak')) return 'Banten';
    if (lower.contains('cenderawasih')) return 'Papua';
    if (lower.contains('enggang')) return 'Kalimantan';
    if (lower.contains('jalak')) return 'Bali';
    if (lower.contains('elang')) return 'Jawa';
    if (lower.contains('hiu')) return 'Perairan RI';
    return 'Indonesia';
  }

  String _getCleanStatus(String status) {
    final lower = status.toLowerCase();
    if (lower.contains('kritis')) return 'Kritis';
    if (lower.contains('terancam')) return 'Terancam';
    if (lower.contains('rentan')) return 'Rentan';
    if (lower.contains('hampir')) return 'Hampir Terancam';
    if (lower.contains('rendah') || lower.contains('least')) return 'Risiko Rendah';
    if (lower.contains('punah')) return 'Punah';
    return 'Dilindungi';
  }

  // Map image helper based on animal origin
  String _getMapImageUrl(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('komodo')) return 'assets/images/map/map_komodo.png';
    if (lower.contains('harimau')) return 'assets/images/map/map_harimausumatera.png';
    if (lower.contains('gajah')) return 'assets/images/map/map_gajahsumatera.png';
    if (lower.contains('orangutan')) return 'assets/images/map/map_orangutansumatera.png';
    if (lower.contains('badak')) return 'assets/images/map/map_badakjawa.png';
    if (lower.contains('cenderawasih') || lower.contains('cendrawasih')) return 'assets/images/map/map_cendrawasih.png';
    if (lower.contains('anoa')) return 'assets/images/map/map_anoa.png';
    if (lower.contains('maleo')) return 'assets/images/map/map_maleo.png';
    if (lower.contains('penyu')) return 'assets/images/map/map_penyuhijau.png';
    if (lower.contains('enggang')) return 'assets/images/map/map_engganggading.png';
    if (lower.contains('jalak')) return 'assets/images/map/map_jalakbali.png';
    if (lower.contains('elang')) return 'assets/images/map/map_elangjawa.png';
    if (lower.contains('hiu')) return 'assets/images/map/map_hiupaus.png';
    
    return 'assets/images/map/map_komodo.png'; // Fallback
  }

  // Tailored Fact Cards mapping exactly to mockup & database
  List<Map<String, dynamic>> _getFaktaMenarikList(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('komodo')) {
      return [
        {
          'title': 'Air Liur Berbisa',
          'desc': 'Gigitan komodo mengandung kelenjar racun yang mencegah pembekuan darah mangsanya, menyebabkan syok dan pendarahan hebat.',
          'icon': Icons.science_outlined,
          'color': const Color(0xFFC62828), // Red
        },
        {
          'title': 'Indra Penciuman',
          'desc': 'Mereka menggunakan lidah bercabang untuk mendeteksi rasa dan mencium bau bangkai hingga sejauh 9,5 kilometer.',
          'icon': Icons.visibility_outlined,
          'color': const Color(0xFF1976D2), // Blue
        }
      ];
    } else if (lower.contains('harimau')) {
      return [
        {
          'title': 'Belang Layaknya Sidik Jari',
          'desc': 'Setiap harimau memiliki pola garis belang unik yang berbeda satu sama lain, mirip seperti sidik jari manusia.',
          'icon': Icons.fingerprint_rounded,
          'color': const Color(0xFFE65100), // Orange
        },
        {
          'title': 'Perenang yang Tangguh',
          'desc': 'Sangat bertolak belakang dengan kucing biasa, harimau sumatera sangat menyukai air dan merupakan perenang yang sangat andal.',
          'icon': Icons.pool_rounded,
          'color': const Color(0xFF1976D2), // Blue
        }
      ];
    } else if (lower.contains('gajah')) {
      return [
        {
          'title': 'Komunikasi Infrasonik',
          'desc': 'Mampu berkomunikasi dalam jarak bermil-mil menggunakan gelombang suara infrasonik frekuensi rendah yang tidak terdengar manusia.',
          'icon': Icons.hearing_rounded,
          'color': const Color(0xFF00796B), // Teal
        },
        {
          'title': 'Belalai Serbaguna',
          'desc': 'Belalai gajah memiliki lebih dari 40.000 otot yang sangat kuat dan presisi untuk bernapas, minum, memetik dahan, hingga menggenggam.',
          'icon': Icons.fitness_center_rounded,
          'color': const Color(0xFFE65100),
        }
      ];
    } else if (lower.contains('cenderawasih')) {
      return [
        {
          'title': 'Tarian Akrobatik Memikat',
          'desc': 'Burung jantan memamerkan keindahan bulu surgawinya lewat tarian akrobatik yang spektakuler demi memikat burung betina.',
          'icon': Icons.music_note_outlined,
          'color': const Color(0xFF8E24AA), // Purple
        },
        {
          'title': 'Bulu Surgawi yang Indah',
          'desc': 'Dijuluki sebagai Bird of Paradise karena keindahan warnanya yang tiada tara di belahan bumi manapun.',
          'icon': Icons.workspace_premium_outlined,
          'color': const Color(0xFFE65100),
        }
      ];
    } else if (lower.contains('hiu')) {
      return [
        {
          'title': 'Raksasa Ramah & Jinak',
          'desc': 'Meskipun merupakan ikan terbesar di dunia, Hiu Paus sangat jinak dan bersahabat dengan penyelam karena hanya memakan plankton.',
          'icon': Icons.emoji_nature_outlined,
          'color': const Color(0xFF00796B),
        },
        {
          'title': 'Sidik Bintik Unik',
          'desc': 'Pola bintik-bintik putih di punggung Hiu Paus bersifat unik dan tidak akan berubah sepanjang hidupnya.',
          'icon': Icons.grid_on_outlined,
          'color': const Color(0xFF1976D2),
        }
      ];
    } else {
      // Fallback for other animals
      return [
        {
          'title': 'Keunikan Adaptasi',
          'desc': 'Spesies ini dibekali kemampuan luar biasa untuk bertahan hidup dan menyesuaikan diri dengan habitat aslinya di kepulauan Indonesia.',
          'icon': Icons.auto_awesome_outlined,
          'color': const Color(0xFF00796B),
        },
        {
          'title': 'Peran Ekosistem Penting',
          'desc': 'Kehadirannya di alam liar sangat krusial untuk menjaga keseimbangan rantai makanan serta kelestarian hutan hujan nusantara.',
          'icon': Icons.shield_outlined,
          'color': const Color(0xFF1976D2),
        }
      ];
    }
  }

  // Premium Quick Info Card Builder
  Widget _buildQuickInfoCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required Color cardBgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Capsule
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 16,
            ),
          ),
          const SizedBox(height: 10),
          // Title
          Text(
            title,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.7),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          // Value
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lexend',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Fact Card Builder
  Widget _buildFaktaMenarikCard({
    required String title,
    required String desc,
    required IconData icon,
    required Color themeColor,
  }) {
    final bgColor = themeColor.withValues(alpha: 0.05);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: themeColor.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: themeColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 12,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF28542A);
    const bodyBgGreen = Color(0xFF2E6F33);
    final animal = widget.animal;

    final facts = _getFaktaMenarikList(animal.name);

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
              height: 32,
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
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: ProfileAvatarButton(radius: 16, borderWidth: 1.5),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. TOP CURVED HERO IMAGE SECTION
            Container(
              height: 380,
              decoration: const BoxDecoration(
                color: bodyBgGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // The Image
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 120, // Leave space for green curved text container
                      child: Image.asset(
                        animal.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.broken_image_rounded, size: 80, color: Colors.grey),
                        ),
                      ),
                    ),
                    
                    // Gradient Fade
                    Positioned(
                      top: 160,
                      left: 0,
                      right: 0,
                      height: 110,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              bodyBgGreen.withValues(alpha: 0.8),
                              bodyBgGreen,
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Curved overlays and titles
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 160,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Status Badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD54F), // Amber/Yellow
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                _getCleanStatus(animal.status).toUpperCase(),
                                style: const TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF5D4037),
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Animal Name
                            Text(
                              animal.name,
                              style: const TextStyle(
                                fontFamily: 'LilitaOne',
                                fontSize: 32,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Latin name
                            Text(
                              animal.latinName,
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // 2. PREMIUM GRID OF 4 QUICK-INFO CAPSULE CARDS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.72,
                children: [
                  // Info 1: Habitat
                  _buildQuickInfoCard(
                    title: 'HABITAT',
                    value: _getHabitatType(animal.habitat),
                    icon: Icons.forest_outlined,
                    iconColor: const Color(0xFF2E6F33),
                    iconBgColor: const Color(0xFFE8F5E9),
                    cardBgColor: const Color(0xFFF1F8E9),
                    textColor: const Color(0xFF33691E),
                  ),
                  // Info 2: Makanan
                  _buildQuickInfoCard(
                    title: 'MAKANAN',
                    value: _getDietType(animal.name),
                    icon: Icons.restaurant_menu_rounded,
                    iconColor: const Color(0xFFE65100),
                    iconBgColor: const Color(0xFFFFF3E0),
                    cardBgColor: const Color(0xFFFFFDE7),
                    textColor: const Color(0xFFE65100),
                  ),
                  // Info 3: Wilayah
                  _buildQuickInfoCard(
                    title: 'ASAL',
                    value: _getOriginAbbreviation(animal.name),
                    icon: Icons.location_on_outlined,
                    iconColor: const Color(0xFF1976D2),
                    iconBgColor: const Color(0xFFE3F2FD),
                    cardBgColor: const Color(0xFFE3F2FD),
                    textColor: const Color(0xFF0D47A1),
                  ),
                  // Info 4: Kelas
                  _buildQuickInfoCard(
                    title: 'KELAS',
                    value: animal.category,
                    icon: Icons.category_outlined,
                    iconColor: const Color(0xFF8E24AA),
                    iconBgColor: const Color(0xFFF3E5F5),
                    cardBgColor: const Color(0xFFFAFAFA),
                    textColor: const Color(0xFF4A148C),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 3. TENTANG SATWA SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tentang Satwa',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    animal.description,
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 13,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                  
                  // Quote / Fun Fact Highlight Box
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5F2),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      border: Border(
                        left: BorderSide(
                          color: bodyBgGreen,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Text(
                      '"${animal.funFact}"',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12.5,
                        fontFamily: 'Lexend',
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 4. PETA SEBARAN SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF7F2),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFEFEBE9),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Peta Sebaran',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF212121),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Habitat asli tersebar di wilayah ${animal.habitat}',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding: const EdgeInsets.all(16),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  InteractiveViewer(
                                    panEnabled: true,
                                    minScale: 0.5,
                                    maxScale: 4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        _getMapImageUrl(animal.name),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.close, color: Colors.white, size: 30),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Image.asset(
                                _getMapImageUrl(animal.name),
                                fit: BoxFit.fitWidth,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 150,
                                  color: Colors.grey.shade200,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.map_outlined, color: Colors.grey),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.65),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.zoom_out_map_rounded, color: Colors.white, size: 14),
                                    SizedBox(width: 6),
                                    Text(
                                      'Ketuk untuk Lihat',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Lexend',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 5. FAKTA MENARIK SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fakta Menarik',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Render facts from the mapping helper
                  ...facts.map((fact) {
                    return _buildFaktaMenarikCard(
                      title: fact['title'] as String,
                      desc: fact['desc'] as String,
                      icon: fact['icon'] as IconData,
                      themeColor: fact['color'] as Color,
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
