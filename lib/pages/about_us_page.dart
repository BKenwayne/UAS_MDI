import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
              'Tentang Kami',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    // 1. HERO FOREST SUNRISE IMAGE WITH FLOATING APP CARD
                    Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        // Jungle Forest Image
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/lanskap/hutan_kalimantan.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.white,
                                  Colors.white.withValues(alpha: 0.1),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                            ),
                          ),
                        ),
                        // Floating white rounded card containing Logo & Version
                        Positioned(
                          bottom: -40,
                          child: Container(
                            width: 320,
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                              border: Border.all(
                                color: const Color(0xFFF0F0F0),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 40,
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
                                const SizedBox(height: 12),
                                const Text(
                                  'VERSI 1.0 (STABIL)',
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 64),

                    // 2. MISI KAMI SECTION
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Pill Badge "Misi Kami"
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFECEB), // Light coral/peach
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Misi Kami',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD84315),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'Melestarikan Warisan Alam Nusantara',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 16.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Nusafauna lahir dari keinginan mendalam untuk menjembatani kesenjangan antara teknologi modern dan pelestarian alam tradisional. Kami berkomitmen untuk menjadi platform edukasi satwa liar terdepan di Indonesia, membantu setiap individu mengenal, mencintai, dan ikut serta menjaga biodiversitas unik tanah air kita.',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 13,
                              color: Colors.black54,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 3. TWO FEATURE INFO PANELS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          // Panel 1: Edukasi Digital
                          _buildFeatureInfoPanel(
                            icon: Icons.menu_book_rounded,
                            title: 'Edukasi Digital',
                            desc: 'Menyediakan akses informasi akurat mengenai spesies langka Indonesia.',
                          ),
                          const SizedBox(height: 14),
                          // Panel 2: Aksi Konservasi
                          _buildFeatureInfoPanel(
                            icon: Icons.volunteer_activism_outlined,
                            title: 'Aksi Konservasi',
                            desc: 'Mendukung program rehabilitasi satwa melalui jaringan mitra terpercaya.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 4. FOLLOW & CONTACT SECTION (HUBUNGI & IKUTI KAMI)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hubungi & Ikuti Kami',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF212121),
                            ),
                          ),
                          const SizedBox(height: 14),
                          
                          // Web Card
                          _buildContactListTile(
                            icon: Icons.language_rounded,
                            title: 'Website Resmi',
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          // Instagram Card
                          _buildContactListTile(
                            icon: Icons.share_outlined,
                            title: 'Instagram @nusafauna.id',
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          // Email Card
                          _buildContactListTile(
                            icon: Icons.mail_outline_rounded,
                            title: 'Email Dukungan',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    // 5. COPYRIGHT FOOTER
                    const Center(
                      child: Text(
                        '© 2024 Nusafauna Foundation. Seluruh hak\ncipta dilindungi.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 11,
                          color: Colors.grey,
                          height: 1.3,
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

  // Reusable card panel component for features
  Widget _buildFeatureInfoPanel({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2), // Warm soft cream
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF2EFE9),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF2E6F33),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E6F33),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
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
    );
  }

  // Reusable list tile component for follow & contacts
  Widget _buildContactListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6), // Light milk cream
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      icon,
                      color: const Color(0xFF2E6F33),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey,
                    size: 18,
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
