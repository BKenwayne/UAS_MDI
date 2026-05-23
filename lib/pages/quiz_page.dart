import 'package:flutter/material.dart';
import '../data/local_storage_service.dart';
import '../data/dummy_data.dart';
import '../mixins/profile_listener_mixin.dart';
import '../models/user_profile.dart';
import '../widgets/profile_avatar_button.dart';
import 'quiz_play_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with ProfileListenerMixin {
  UserProfile? _profile;

  @override
  void onProfileChanged() => _loadUserProfile();

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

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF28542A);
    const quizBgGreen = Color(0xFF2E6F33);

    // Live refresh user profile from LocalStorage
    _profile = LocalStorageService.instance.getCurrentUser();

    // Filter out 'harian' from completed count for the 5 primary quizzes progress
    final completedPrimary = _profile?.completedQuizzes.where((id) => id != 'harian').toList() ?? [];
    final completedCount = completedPrimary.length;
    
    final completedQuizzesText = "$completedCount/5 Kuis Selesai";

    final totalScore = _profile?.quizScores.values.fold<int>(0, (sum, val) => sum + val) ?? 0;
    final totalPointsText = "${totalScore * 10}";

    final progressValue = completedCount / 5.0;

    // Get the dynamic completed state of quizzes to map to cards
    final isSumatraDone = _profile?.completedQuizzes.contains('sumatra') ?? false;
    final isJawaDone = _profile?.completedQuizzes.contains('jawa') ?? false;
    final isKalimantanDone = _profile?.completedQuizzes.contains('kalimantan') ?? false;
    final isBahayaDone = _profile?.completedQuizzes.contains('bahaya') ?? false;
    final isBurungDone = _profile?.completedQuizzes.contains('burung') ?? false;

    // Individual scores retrieved dynamically
    final sumatraScore = isSumatraDone ? _profile?.quizScores['sumatra'] : null;
    final jawaScore = isJawaDone ? _profile?.quizScores['jawa'] : null;
    final kalimantanScore = isKalimantanDone ? _profile?.quizScores['kalimantan'] : null;
    final bahayaScore = isBahayaDone ? _profile?.quizScores['bahaya'] : null;
    final burungScore = isBurungDone ? _profile?.quizScores['burung'] : null;
    final harianScore = _profile?.completedQuizzes.contains('harian') == true ? _profile?.quizScores['harian'] : null;

    // Fetch dynamic question counts for high-fidelity subtitle mapping
    final sumatraLength = DummyData.quizzes.firstWhere((element) => element.id == 'sumatra').questions.length;
    final jawaLength = DummyData.quizzes.firstWhere((element) => element.id == 'jawa').questions.length;
    final kalimantanLength = DummyData.quizzes.firstWhere((element) => element.id == 'kalimantan').questions.length;
    final bahayaLength = DummyData.quizzes.firstWhere((element) => element.id == 'bahaya').questions.length;
    final burungLength = DummyData.quizzes.firstWhere((element) => element.id == 'burung').questions.length;

    return Scaffold(
      backgroundColor: quizBgGreen,
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
          onRefresh: () async {
            _loadUserProfile();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              const SizedBox(height: 16),

              // 1. PROGRESS BELAJAR CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Progress Title Badge & Text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2E6F33),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Progress Belajar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  fontFamily: 'Lexend',
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              completedQuizzesText,
                              style: const TextStyle(
                                fontSize: 24,
                                fontFamily: 'LilitaOne',
                                color: Color(0xFF212121),
                              ),
                            ),
                          ],
                        ),

                        // Right: Poin Terkumpul Info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.stars_rounded,
                                  color: Color(0xFF2E6F33),
                                  size: 24,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  totalPointsText,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'LilitaOne',
                                    color: Color(0xFF212121),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Poin Terkumpul',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Lexend',
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF90CAF9)), // Light blue progress
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. DAILY CHALLENGE BANNER CARD
              Container(
                height: 170,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Forest Image background
                      Image.asset(
                        'assets/images/lanskap/hutan_kalimantan.jpg',
                        fit: BoxFit.cover,
                      ),
                      // Dark Overlay
                      Container(
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                      // Overlaid elements
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Left Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Challenge Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0D47A1), // Deep blue
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'TANTANGAN HARI INI',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9,
                                        fontFamily: 'Lexend',
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Title
                                  const Text(
                                    'Kuis Harian:\nMisteri Rimba',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'LilitaOne',
                                      height: 1.2,
                                    ),
                                  ),
                                  if (harianScore != null) ...[
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white30, width: 0.5),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.stars_rounded, color: Colors.amber, size: 12),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Skor: $harianScore% (+${harianScore * 10} Poin)',
                                            style: const TextStyle(
                                              fontFamily: 'Lexend',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 9.5,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 6),
                                  // Metadata Row

                                ],
                              ),
                            ),

                            // Right: Mului Kuis Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF2E6F33),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                elevation: 0,
                              ),
                              onPressed: () {
                                final harianQuiz = DummyData.quizzes.firstWhere((q) => q.id == 'harian');
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => QuizPlayPage(category: harianQuiz),
                                  ),
                                ).then((_) => _loadUserProfile());
                              },
                              child: const Text(
                                'Mulai Kuis',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'Lexend',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // 3. PILIH WILAYAH HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Pilih Wilayah',
                      style: TextStyle(
                        fontFamily: 'LilitaOne',
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 4. REGIONS/CATEGORIES LIST CARDS
              // 4.1. Penjelajah Sumatra
              _buildRegionCard(
                title: 'Penjelajah Sumatra',
                subtitle: isSumatraDone ? '$sumatraLength/$sumatraLength Selesai' : '0/$sumatraLength Selesai',
                imageUrl: 'assets/images/satwa/harimau_sumatera.jpeg', // Tiger
                progress: isSumatraDone ? 1.0 : 0.0,
                progressColor: isSumatraDone ? const Color(0xFF2196F3) : const Color(0xFF2E6F33),
                score: sumatraScore,
                onTap: () {
                  final q = DummyData.quizzes.firstWhere((element) => element.id == 'sumatra');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuizPlayPage(category: q),
                    ),
                  ).then((_) => _loadUserProfile());
                },
              ),

              // 4.2. Mamalia Jawa
              _buildRegionCard(
                title: 'Mamalia Jawa',
                subtitle: isJawaDone ? '$jawaLength/$jawaLength Selesai' : '0/$jawaLength Selesai',
                imageUrl: 'assets/images/satwa/badak_jawa.jpeg', // Rhino
                progress: isJawaDone ? 1.0 : 0.0,
                progressColor: isJawaDone ? const Color(0xFF2196F3) : const Color(0xFF2E6F33),
                score: jawaScore,
                onTap: () {
                  final q = DummyData.quizzes.firstWhere((element) => element.id == 'jawa');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuizPlayPage(category: q),
                    ),
                  ).then((_) => _loadUserProfile());
                },
              ),

              // 4.3. Pepohonan Kalimantan
              _buildRegionCard(
                title: 'Pepohonan Kalimantan',
                subtitle: isKalimantanDone ? '$kalimantanLength/$kalimantanLength Selesai' : '0/$kalimantanLength Selesai',
                imageUrl: 'assets/images/satwa/orangutan_sumatera.jpg', // Orangutan
                progress: isKalimantanDone ? 1.0 : 0.0,
                progressColor: isKalimantanDone ? const Color(0xFF2196F3) : const Color(0xFF2E6F33),
                score: kalimantanScore,
                onTap: () {
                  final q = DummyData.quizzes.firstWhere((element) => element.id == 'kalimantan');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuizPlayPage(category: q),
                    ),
                  ).then((_) => _loadUserProfile());
                },
              ),

              // 4.4. Dalam Bahaya
              _buildRegionCard(
                title: 'Dalam Bahaya',
                subtitle: isBahayaDone ? '$bahayaLength/$bahayaLength Selesai' : '0/$bahayaLength Selesai',
                imageUrl: 'assets/images/lanskap/savana.jpg', // Danger/Savanna
                progress: isBahayaDone ? 1.0 : 0.0,
                progressColor: isBahayaDone ? const Color(0xFF2196F3) : const Color(0xFF2E6F33),
                score: bahayaScore,
                onTap: () {
                  final q = DummyData.quizzes.firstWhere((element) => element.id == 'bahaya');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuizPlayPage(category: q),
                    ),
                  ).then((_) => _loadUserProfile());
                },
              ),

              // 4.5. Bulu Indah Nusantara
              _buildRegionCard(
                title: 'Bulu Indah Nusantara',
                subtitle: isBurungDone ? '$burungLength/$burungLength Selesai' : '0/$burungLength Selesai',
                imageUrl: 'assets/images/satwa/cendrawasih_kb.jpg', // Cenderawasih
                progress: isBurungDone ? 1.0 : 0.0,
                progressColor: isBurungDone ? const Color(0xFF2196F3) : const Color(0xFF2E6F33),
                score: burungScore,
                onTap: () {
                  final q = DummyData.quizzes.firstWhere((element) => element.id == 'burung');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuizPlayPage(category: q),
                    ),
                  ).then((_) => _loadUserProfile());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Premium Reusable Region Quiz Card Builder
  Widget _buildRegionCard({
    required String title,
    required String subtitle,
    required String imageUrl,
    required double progress,
    required Color progressColor,
    required VoidCallback onTap,
    int? score,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // Left: Circular cropped thumbnail image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 58,
                      height: 58,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.quiz_outlined, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Right: Titles and progress bar
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF212121),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              subtitle,
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            if (score != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFC8E6C9), width: 0.5),
                                ),
                                child: Text(
                                  'Skor: $score% (+${score * 10} Poin)',
                                  style: const TextStyle(
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.5,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Linear progress indicator
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 5,
                            backgroundColor: Colors.grey.shade100,
                            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                          ),
                        ),
                      ],
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
}
