import 'package:flutter/material.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  // Accordion active state trackers
  final Map<int, bool> _accordionStates = {
    0: false,
    1: false,
    2: false,
  };

  // Static FAQ data list
  final List<Map<String, String>> _faqData = [
    {
      'question': 'Apakah aplikasi ini gratis digunakan?',
      'answer': 'Ya! NusaFauna 100% gratis digunakan untuk seluruh anak-anak Indonesia. Seluruh fitur ensiklopedia satwa, kuis interaktif, lencana lencana petualangan, dan papan skor dapat diakses penuh tanpa biaya apa pun guna melestarikan pengetahuan satwa endemik kita.',
    },
    {
      'question': 'Bagaimana cara melaporkan kesalahan data?',
      'answer': 'Kami sangat mengapresiasi kontribusi Anda. Jika Anda menemukan ketidaksesuaian data satwa, Anda dapat mengirimkan laporan melalui menu "Hubungi Kami" di bawah dengan menyertakan bukti pendukung atau menghubungi email resmi kami di support@nusafauna.com.',
    },
    {
      'question': 'Bagaimana cara menyimpan kuis progres?',
      'answer': 'Semua progres kuis yang Anda selesaikan otomatis tersimpan di database lokal perangkat Anda. Lencana unik yang diperoleh dari kelulusan kuis kustom juga terdaftar secara permanen di profil lencana koleksi Anda.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const brandGreen = Color(0xFF28542A);

    // Filter FAQs based on search query
    final filteredFaqs = _faqData;

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
              'Pusat Bantuan',
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
                    
                    // 1. WELCOME HEADER SECTION
                    const Text(
                      'Ada yang bisa kami\nbantu?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A20),
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Temukan jawaban untuk pertanyaan Anda di sini.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 13.5,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 2. TOPIK POPULER SECTION
                    const Text(
                      'TOPIK POPULER',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Card 1: Panduan Aplikasi
                    _buildPopularTopicCard(
                      icon: Icons.menu_book_rounded,
                      bgColor: const Color(0xFFE8F5E9),
                      iconColor: const Color(0xFF2E6F33),
                      title: 'Panduan Aplikasi',
                      subtitle: 'Pelajari cara menggunakan fitur Nusafauna secara maksimal.',
                      onTap: () => _showHelpDetailDialog(
                        context,
                        'Panduan Aplikasi',
                        'Gunakan Ensiklopedia untuk membaca asal-usul satwa lengkap dengan fakta menarik. Mainkan Kuis di tab kuis untuk menguji pengetahuan Anda dan kumpulkan lencana langka untuk dipajang di lembar Profil Anda!',
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Card 2: Akurasi Data Satwa
                    _buildPopularTopicCard(
                      icon: Icons.assignment_turned_in_outlined,
                      bgColor: const Color(0xFFFBE9E7),
                      iconColor: const Color(0xFFD84315),
                      title: 'Akurasi Data Satwa',
                      subtitle: 'Bagaimana kami mengkurasi dan memverifikasi informasi satwa.',
                      onTap: () => _showHelpDetailDialog(
                        context,
                        'Akurasi Data Satwa',
                        'Seluruh artikel, gambar, klasifikasi ilmiah, dan deskripsi satwa di NusaFauna dikurasi dengan cermat merujuk pada jurnal biologi nasional, informasi LIPI/BRIN, serta situs resmi konservasi flora fauna Indonesia.',
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Card 3: Masalah Teknis
                    _buildPopularTopicCard(
                      icon: Icons.warning_amber_rounded,
                      bgColor: const Color(0xFFE3F2FD),
                      iconColor: const Color(0xFF1976D2),
                      title: 'Masalah Teknis',
                      subtitle: 'Solusi untuk masalah login, bug, atau kendala perangkat.',
                      onTap: () => _showHelpDetailDialog(
                        context,
                        'Masalah Teknis',
                        'Apabila Anda mengalami lag, gambar tidak muncul, atau gagal masuk kuis, pastikan koneksi internet aktif. Jika kendala berlanjut, Anda dapat melakukan reset penyimpanan di tab Pengaturan Akun atau menghubungi Admin.',
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 4. PERTANYAAN UMUM FAQ ACCORDION SECTION
                    const Text(
                      'PERTANYAAN UMUM',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Render dynamic FAQ accordion blocks
                    filteredFaqs.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Text(
                              'Pertanyaan tidak ditemukan. Coba kata kunci lain!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Lexend', color: Colors.grey, fontSize: 13),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredFaqs.length,
                            itemBuilder: (context, index) {
                              final faq = filteredFaqs[index];
                              final isExpanded = _accordionStates[index] ?? false;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // Accordion Question Click Row
                                    InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: () {
                                        setState(() {
                                          _accordionStates[index] = !isExpanded;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                faq['question']!,
                                                style: const TextStyle(
                                                  fontFamily: 'Lexend',
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              isExpanded ? Icons.remove : Icons.add,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Answer Expandable body
                                    if (isExpanded)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                        child: Text(
                                          faq['answer']!,
                                          style: const TextStyle(
                                            fontFamily: 'Lexend',
                                            fontSize: 12.5,
                                            color: Colors.black54,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                    const SizedBox(height: 24),

                    // 5. STILL NEED HELP DEEP GREEN PANEL (MASIH BUTUH BANTUAN)
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E6F33), // Deep beautiful forest green
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Masih butuh bantuan?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tim dukungan kami siap membantu Anda kapan saja.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                          const SizedBox(height: 18),
                          // White Hubungi Kami capsule button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF2E6F33),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {
                                _showSupportContactDialog(context);
                              },
                              icon: const Icon(Icons.support_agent_rounded, size: 20),
                              label: const Text(
                                'Hubungi Kami',
                                style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
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

  // Helper card component for popular help topics
  Widget _buildPopularTopicCard({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
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
            blurRadius: 8,
            offset: const Offset(0, 3),
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
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: bgColor,
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 20,
                    ),
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
                            height: 1.25,
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

  // Dialog showing content details for a topic card
  void _showHelpDetailDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(title, style: const TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold)),
          content: Text(content, style: const TextStyle(fontFamily: 'Lexend', color: Colors.black87, height: 1.4)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // Interactive contact support agents sheet / dialog
  void _showSupportContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Row(
            children: [
              Icon(Icons.headset_mic_rounded, color: Color(0xFF2E6F33)),
              SizedBox(width: 10),
              Text(
                'Hubungi Kami',
                style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tim NusaFauna siap membantu! Silakan pilih saluran yang paling nyaman untuk Anda:',
                style: TextStyle(fontFamily: 'Lexend', color: Colors.black87, fontSize: 13, height: 1.4),
              ),
              SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFE8F5E9),
                  child: Icon(Icons.email_outlined, color: Color(0xFF2E6F33)),
                ),
                title: Text('Email Resmi', style: TextStyle(fontFamily: 'Lexend', fontSize: 13, fontWeight: FontWeight.bold)),
                subtitle: Text('support@nusafauna.com', style: TextStyle(fontFamily: 'Lexend', fontSize: 11)),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFE8F5E9),
                  child: Icon(Icons.phone_outlined, color: Color(0xFF2E6F33)),
                ),
                title: Text('WhatsApp Admin', style: TextStyle(fontFamily: 'Lexend', fontSize: 13, fontWeight: FontWeight.bold)),
                subtitle: Text('+62 812-3456-7890', style: TextStyle(fontFamily: 'Lexend', fontSize: 11)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
