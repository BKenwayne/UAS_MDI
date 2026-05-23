import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/animal.dart';
import '../widgets/profile_avatar_button.dart';
import 'animal_detail_page.dart';

class EncyclopediaPage extends StatefulWidget {
  const EncyclopediaPage({super.key});

  static String activeCategoryFilter = 'Semua';

  @override
  State<EncyclopediaPage> createState() => EncyclopediaPageState();
}

class EncyclopediaPageState extends State<EncyclopediaPage> {
  final _searchController = TextEditingController();
  final ScrollController _categoryScrollController = ScrollController();
  String _selectedCategory = 'Semua';
  List<Animal> _filteredAnimals = [];

  final List<String> _categories = const ['Semua', 'Mamalia', 'Burung', 'Reptil', 'Satwa Laut'];

  static const _stickyHeaderHeight = 150.0;

  @override
  void initState() {
    super.initState();
    _selectedCategory = EncyclopediaPage.activeCategoryFilter;
    _filterAnimals();
    _searchController.addListener(_filterAnimals);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _categoryScrollController.dispose();
    super.dispose();
  }

  void _filterAnimals() {
    final query = _searchController.text.toLowerCase().trim();
    final allAnimals = DummyData.animals;

    setState(() {
      _filteredAnimals = allAnimals.where((animal) {
        final matchesSearch = animal.name.toLowerCase().contains(query) ||
            animal.latinName.toLowerCase().contains(query) ||
            animal.habitat.toLowerCase().contains(query);
        final matchesCategory = _selectedCategory == 'Semua' ||
            animal.category == _selectedCategory;

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  /// Dipanggil saat kategori dipilih dari Beranda (IndexedStack tidak memanggil initState ulang).
  void applyCategoryFromNavigation() {
    final target = EncyclopediaPage.activeCategoryFilter;
    if (_selectedCategory == target) return;

    _selectedCategory = target;
    _filterAnimals();
  }

  String _getRegionLabel(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('harimau') || lower.contains('gajah') || lower.contains('orangutan')) {
      return 'SUMATRA';
    } else if (lower.contains('anoa') || lower.contains('maleo')) {
      return 'SULAWESI';
    } else if (lower.contains('komodo')) {
      return 'NUSA TENGGARA';
    } else if (lower.contains('badak')) {
      return 'BANTEN';
    } else if (lower.contains('cenderawasih')) {
      return 'PAPUA';
    } else if (lower.contains('penyu')) {
      return 'SUMATRA';
    } else if (lower.contains('enggang')) {
      return 'KALIMANTAN BARAT';
    } else if (lower.contains('jalak')) {
      return 'BALI';
    } else if (lower.contains('elang')) {
      return 'JAWA';
    } else if (lower.contains('hiu')) {
      return 'PERAIRAN INDONESIA';
    }
    return 'INDONESIA';
  }

  Widget _buildStatusBadge(String status) {
    String label = 'Dilindungi';
    Color bgColor = const Color(0xFF2E7D32);

    final lower = status.toLowerCase();
    if (lower.contains('kritis')) {
      label = 'Kritis';
      bgColor = const Color(0xFFD32F2F);
    } else if (lower.contains('terancam')) {
      label = 'Terancam';
      bgColor = const Color(0xFFE64A19);
    } else if (lower.contains('rentan')) {
      label = 'Rentan';
      bgColor = const Color(0xFFF57C00);
    } else if (lower.contains('hampir')) {
      label = 'Hampir Terancam';
      bgColor = const Color(0xFFFBC02D);
    } else if (lower.contains('rendah') || lower.contains('least')) {
      label = 'Risiko Rendah';
      bgColor = const Color(0xFF1976D2);
    } else if (lower.contains('punah')) {
      label = 'Punah';
      bgColor = const Color(0xFF616161);
    } else if (lower.contains('dilindungi') || lower.contains('protected')) {
      label = 'Dilindungi';
      bgColor = const Color(0xFF2E7D32);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lexend',
        ),
      ),
    );
  }

  String _getCategoryIcon(String cat) {
    switch (cat) {
      case 'Mamalia':
        return 'assets/images/Ic_mamalia.png';
      case 'Burung':
        return 'assets/images/Ic_burung.png';
      case 'Reptil':
        return 'assets/images/Ic_reptil.png';
      case 'Satwa Laut':
        return 'assets/images/Ic_laut.png';
      default:
        return '';
    }
  }

  Widget _buildSearchAndCategories() {
    return Column(
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(fontFamily: 'Lexend', color: Colors.black87, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Cari nama satwa atau daerah...',
              hintStyle: TextStyle(fontFamily: 'Lexend', color: Colors.grey.shade500),
              prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade600),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear_rounded, color: Colors.grey.shade600),
                      onPressed: _searchController.clear,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (_categoryScrollController.hasClients) {
                    _categoryScrollController.animateTo(
                      (_categoryScrollController.offset - 120).clamp(0.0, _categoryScrollController.position.maxScrollExtent),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: ListView.builder(
                    controller: _categoryScrollController,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      final isSelected = _selectedCategory == cat;
                      final iconAsset = _getCategoryIcon(cat);

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedCategory = cat;
                              EncyclopediaPage.activeCategoryFilter = cat;
                              _filterAnimals();
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFC8E6C9) : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF28542A) : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                if (cat == 'Semua')
                                  Icon(
                                    Icons.grid_view_rounded,
                                    size: 16,
                                    color: isSelected ? const Color(0xFF28542A) : Colors.grey.shade700,
                                  )
                                else if (iconAsset.isNotEmpty)
                                  Image.asset(
                                    iconAsset,
                                    height: 16,
                                    width: 16,
                                    color: isSelected ? const Color(0xFF28542A) : Colors.grey.shade700,
                                  ),
                                const SizedBox(width: 8),
                                Text(
                                  cat,
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? const Color(0xFF28542A) : Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_categoryScrollController.hasClients) {
                    _categoryScrollController.animateTo(
                      (_categoryScrollController.offset + 120).clamp(0.0, _categoryScrollController.position.maxScrollExtent),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF28542A);
    const bodyBgGreen = Color(0xFF2E6F33);

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
      body: ColoredBox(
        color: bodyBgGreen,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jelajahi Satwa',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'LilitaOne',
                        color: brandGreen,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Temukan keajaiban fauna Indonesia dari sabang sampai merauke dalam satu genggaman.',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Lexend',
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchCategoryHeaderDelegate(
                height: _stickyHeaderHeight,
                backgroundColor: bodyBgGreen,
                child: _buildSearchAndCategories(),
              ),
            ),
            if (_filteredAnimals.isEmpty)
              SliverFillRemaining(
                child: _buildEmptyState(),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final animal = _filteredAnimals[index];
                      return Container(
                        height: 140,
                        margin: const EdgeInsets.only(bottom: 16),
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
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 130,
                                    height: double.infinity,
                                    child: Image.asset(
                                      animal.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.broken_image_rounded, color: Colors.grey, size: 30),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.grey.shade600,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 2),
                                              Expanded(
                                                child: Text(
                                                  _getRegionLabel(animal.name),
                                                  style: TextStyle(
                                                    fontFamily: 'Lexend',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              _buildStatusBadge(animal.status),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            animal.name,
                                            style: const TextStyle(
                                              fontFamily: 'Lexend',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFF212121),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            animal.description,
                                            style: TextStyle(
                                              fontFamily: 'Lexend',
                                              fontSize: 11,
                                              color: Colors.grey.shade600,
                                              height: 1.4,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
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
                    childCount: _filteredAnimals.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.white60,
          ),
          const SizedBox(height: 16),
          const Text(
            'Satwa tidak ditemukan',
            style: TextStyle(
              fontFamily: 'LilitaOne',
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba ketik kata kunci pencarian yang lain.',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchCategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Color backgroundColor;
  final Widget child;

  _SearchCategoryHeaderDelegate({
    required this.height,
    required this.backgroundColor,
    required this.child,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: backgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _SearchCategoryHeaderDelegate oldDelegate) {
    return oldDelegate.height != height ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.child != child;
  }
}
