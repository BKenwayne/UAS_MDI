import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/profile_avatar_button.dart';
import 'animal_detail_page.dart';
import 'encyclopedia_page.dart';
import 'main_navigation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _featuredScrollController = ScrollController();

  @override
  void dispose() {
    _featuredScrollController.dispose();
    super.dispose();
  }

  void _scrollFeatured(double offset) {
    if (!_featuredScrollController.hasClients) return;
    final target = _featuredScrollController.offset + offset;
    _featuredScrollController.animateTo(
      target.clamp(0.0, _featuredScrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Parse custom badge text and color based on status
  Widget _buildStatusBadge(String status) {
    String shortStatus = 'Dilindungi';
    Color badgeColor = const Color(0xFF2E7D32); // Default green

    final lower = status.toLowerCase();
    if (lower.contains('kritis')) {
      shortStatus = 'Kritis';
      badgeColor = const Color(0xFFD32F2F); // Red
    } else if (lower.contains('terancam')) {
      shortStatus = 'Terancam';
      badgeColor = const Color(0xFFE64A19); // Orange-Red
    } else if (lower.contains('rentan')) {
      shortStatus = 'Rentan';
      badgeColor = const Color(0xFFF57C00); // Orange
    } else if (lower.contains('hampir')) {
      shortStatus = 'Hampir Terancam';
      badgeColor = const Color(0xFFFBC02D); // Yellow
    } else if (lower.contains('rendah') || lower.contains('least')) {
      shortStatus = 'Risiko Rendah';
      badgeColor = const Color(0xFF1976D2); // Indigo Blue
    } else if (lower.contains('punah')) {
      shortStatus = 'Punah';
      badgeColor = const Color(0xFF616161); // Grey
    } else if (lower.contains('dilindungi') || lower.contains('protected')) {
      shortStatus = 'Dilindungi';
      badgeColor = const Color(0xFF2E7D32); // Green
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        shortStatus,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lexend',
        ),
      ),
    );
  }

  // Map location accurately like Sumatra for Tiger/Elephant
  String _mapLocation(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('harimau') || lower.contains('gajah') || lower.contains('orangutan')) {
      return 'Sumatera, Indonesia';
    } else if (lower.contains('anoa') || lower.contains('maleo')) {
      return 'Sulawesi, Indonesia';
    } else if (lower.contains('komodo')) {
      return 'Nusa Tenggara, Indonesia';
    } else if (lower.contains('badak')) {
      return 'Banten, Indonesia';
    } else if (lower.contains('cenderawasih')) {
      return 'Papua, Indonesia';
    }
    return 'Indonesia';
  }

  void _navigateToCategory(String categoryName) {
    EncyclopediaPage.activeCategoryFilter = categoryName;
    context.findAncestorStateOfType<MainNavigationPageState>()?.setSelectedIndex(1);
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF28542A);
    const bodyBgGreen = Color(0xFF2E6F33);
    const labelColor = Color(0xFF8B5E3C);

    // Get premium featured animals
    final featuredAnimals = DummyData.animals;

    return Scaffold(
      backgroundColor: bodyBgGreen,
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
                  fontSize: 22,
                  fontFamily: 'LilitaOne',
                  color: brandGreen,
                  letterSpacing: 1,
                ),
              ),
            ),
            const ProfileAvatarButton(),
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. FORESTS FEATURED BANNER CARD
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.85),
                          Colors.black.withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jelajahi Kekayaan Alam Nusantara',
                          style: TextStyle(
                            fontFamily: 'LilitaOne',
                            color: Colors.white,
                            fontSize: 20,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Temukan keajaiban satwa endemik Indonesia dalam satu platform edukasi interaktif.',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1BE427), // Vibrant green matching mockup
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => _navigateToCategory('Semua'),
                          child: const Text(
                            'JELAJAHI SATWA',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // 2. KATEGORI SATWA TITLE
                const Text(
                  'Kategori Satwa',
                  style: TextStyle(
                    fontFamily: 'LilitaOne',
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),

                // 2x2 CATEGORIES GRID
                Row(
                  children: [
                    _buildCategoryCard(
                      title: 'Mamalia',
                      imageAsset: 'assets/images/Ic_mamalia.png',
                      iconBgColor: const Color(0xFF8B5E3C), // Brownish
                      onTap: () => _navigateToCategory('Mamalia'),
                    ),
                    _buildCategoryCard(
                      title: 'Burung',
                      imageAsset: 'assets/images/Ic_burung.png',
                      iconBgColor: const Color(0xFF5D9CEC), // Blue
                      onTap: () => _navigateToCategory('Burung'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildCategoryCard(
                      title: 'Reptil',
                      imageAsset: 'assets/images/Ic_reptil.png',
                      iconBgColor: const Color(0xFF4CAF50), // Green
                      onTap: () => _navigateToCategory('Reptil'),
                    ),
                    _buildCategoryCard(
                      title: 'Satwa Laut',
                      imageAsset: 'assets/images/Ic_laut.png',
                      iconBgColor: const Color(0xFF1F4E79), // Dark Blue
                      onTap: () => _navigateToCategory('Satwa Laut'),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // 3. SATWA UNGGULAN TITLE & NAV ARROWS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Satwa Unggulan',
                      style: TextStyle(
                        fontFamily: 'LilitaOne',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        _buildNavArrow(Icons.chevron_left_rounded, () => _scrollFeatured(-240)),
                        const SizedBox(width: 8),
                        _buildNavArrow(Icons.chevron_right_rounded, () => _scrollFeatured(240)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // HORIZONTAL CAROUSEL OF FEATURED ANIMALS
                SizedBox(
                  height: 340,
                  child: ListView.builder(
                    controller: _featuredScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredAnimals.length,
                    itemBuilder: (context, index) {
                      final animal = featuredAnimals[index];
                      return Container(
                        width: 240,
                        margin: const EdgeInsets.only(right: 16, bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => AnimalDetailPage(animal: animal),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Animal Image + Status Badge Overlay
                                  Expanded(
                                    flex: 3,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.asset(
                                          animal.imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            color: Colors.grey.shade200,
                                            child: const Icon(Icons.broken_image_rounded, size: 40, color: Colors.grey),
                                          ),
                                        ),
                                        Positioned(
                                          top: 12,
                                          right: 12,
                                          child: _buildStatusBadge(animal.status),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Animal description details
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            animal.name,
                                            style: const TextStyle(
                                              fontFamily: 'Lexend',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: brandGreen,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            animal.latinName,
                                            style: TextStyle(
                                              fontFamily: 'Lexend',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13,
                                              color: Colors.grey.shade600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                color: labelColor,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  _mapLocation(animal.name),
                                                  style: TextStyle(
                                                    fontFamily: 'Lexend',
                                                    fontSize: 12,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Category card builder helper
  Widget _buildCategoryCard({
    required String title,
    required String imageAsset,
    required Color iconBgColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: iconBgColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        imageAsset,
                        color: Colors.white, // Ensure the icon asset color matches the mockup design
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.pets_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Nav Arrow helper
  Widget _buildNavArrow(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: const Color(0xFF28542A),
          size: 20,
        ),
      ),
    );
  }
}
