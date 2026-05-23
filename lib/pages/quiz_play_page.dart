import 'package:flutter/material.dart';
import '../data/local_storage_service.dart';
import '../widgets/profile_avatar_button.dart';
import '../models/quiz.dart';

class ShuffledQuestion {
  final Question originalQuestion;
  final List<String> shuffledOptions;
  final int correctOptionIndex;

  ShuffledQuestion({
    required this.originalQuestion,
    required this.shuffledOptions,
    required this.correctOptionIndex,
  });

  String get questionText => originalQuestion.questionText;
}

class QuizPlayPage extends StatefulWidget {
  final QuizCategory category;

  const QuizPlayPage({
    super.key,
    required this.category,
  });

  @override
  State<QuizPlayPage> createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends State<QuizPlayPage> {
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _isAnswerSubmitted = false;
  int _correctAnswersCount = 0;
  bool _quizFinished = false;
  List<ShuffledQuestion> _shuffledQuestions = [];

  // Real-time duration tracking
  late DateTime _startTime;
  String? _durationText;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _prepareShuffledQuestions();
  }

  void _prepareShuffledQuestions() {
    _shuffledQuestions = widget.category.questions.map((question) {
      final correctText = question.options[question.correctOptionIndex];
      final optionsCopy = List<String>.from(question.options);
      optionsCopy.shuffle();
      final newCorrectIndex = optionsCopy.indexOf(correctText);
      return ShuffledQuestion(
        originalQuestion: question,
        shuffledOptions: optionsCopy,
        correctOptionIndex: newCorrectIndex,
      );
    }).toList();
  }

  void _handleOptionSelect(int index) {
    if (_isAnswerSubmitted) return; // Prevent changing answer after submission
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _submitAnswer() {
    if (_selectedOptionIndex == null) return;
    
    final question = _shuffledQuestions[_currentQuestionIndex];
    final isCorrect = _selectedOptionIndex == question.correctOptionIndex;

    setState(() {
      _isAnswerSubmitted = true;
      if (isCorrect) {
        _correctAnswersCount++;
      }
    });
  }

  void _nextQuestion() {
    final totalQuestions = _shuffledQuestions.length;
    
    if (_currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _isAnswerSubmitted = false;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() async {
    // Calculate final actual duration taken
    final duration = DateTime.now().difference(_startTime);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    _durationText = "$minutes:$seconds";

    final storage = LocalStorageService.instance;
    final profile = storage.getCurrentUser();
    
    if (profile != null) {
      final totalQuestions = _shuffledQuestions.length;
      final finalScore = ((_correctAnswersCount / totalQuestions) * 100).toInt();
      
      // Update high score
      final currentHighScore = profile.quizScores[widget.category.id] ?? 0;
      final newScores = Map<String, int>.from(profile.quizScores);
      if (finalScore > currentHighScore) {
        newScores[widget.category.id] = finalScore;
      }

      // Mark completed
      final newCompleted = List<String>.from(profile.completedQuizzes);
      if (!newCompleted.contains(widget.category.id)) {
        newCompleted.add(widget.category.id);
      }

      // Check badge unlock
      final newBadges = List<String>.from(profile.earnedBadges);
      bool newlyUnlockedBadge = false;
      if (finalScore >= widget.category.passingScore && !newBadges.contains(widget.category.badgeName)) {
        newBadges.add(widget.category.badgeName);
        newlyUnlockedBadge = true;
      }

      final updatedProfile = profile.copyWith(
        quizScores: newScores,
        completedQuizzes: newCompleted,
        earnedBadges: newBadges,
      );
      await storage.saveCurrentUser(updatedProfile);

      setState(() {
        _quizFinished = true;
      });

      if (newlyUnlockedBadge) {
        _showBadgeUnlockDialog(widget.category.badgeName);
      }
    }
  }

  void _showBadgeUnlockDialog(String badgeName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          title: const Text(
            '🎉 Lencana Baru Terbuka!',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'LilitaOne'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              const CircleAvatar(
                radius: 46,
                backgroundColor: Color(0xFFC8E6C9),
                child: Icon(
                  Icons.emoji_events_rounded,
                  size: 50,
                  color: Color(0xFF2E6F33),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                badgeName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E6F33),
                  fontSize: 20,
                  fontFamily: 'Lexend',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Selamat! Kamu telah membuktikan wawasan hebatmu dan berhak mendapatkan lencana ini.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  fontFamily: 'Lexend',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E6F33),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Selesai', style: TextStyle(fontFamily: 'Lexend')),
              ),
            ),
          ],
        );
      },
    );
  }

  // Difficulty badge helper based on category ID
  String _getDifficultyBadge(String id) {
    if (id == 'mamalia') return 'Tingkat Pemula';
    if (id == 'burung') return 'Tingkat Ahli';
    return 'Tingkat Menengah';
  }

  // Region Illustration for question card
  String _getQuestionIllustrationUrl(String id) {
    switch (id) {
      case 's1': return 'assets/images/satwa/harimau_sumatera.jpeg';
      case 's2':
      case 's3': return 'assets/images/satwa/gajah_sumatera.jpg';
      case 's4':
      case 's5': return 'assets/images/lanskap/hutan_sumatera.jpg';
      
      case 'j1':
      case 'j3': return 'assets/images/satwa/badak_jawa.jpeg';
      case 'j2': return 'assets/images/satwa/elang_jawa.jpg';
      
      case 'k1':
      case 'k3':
      case 'k4': return 'assets/images/satwa/orangutan_sumatera.jpg';
      case 'k2': return 'assets/images/satwa/enggang_gading.jpg';
      case 'k5':
      case 'k6': return 'assets/images/lanskap/hutan_kalimantan.jpg';
      
      case 'm1': 
      case 'm3': return 'assets/images/satwa/komodo.jpg';
      case 'm2': return 'assets/images/satwa/anoa.jpg';
      case 'm4': return 'assets/images/satwa/maleo.jpg';
      
      case 'p1': return 'assets/images/satwa/cendrawasih_kb.jpg';
      case 'p2': return 'assets/images/satwa/jalak_bali.jpg';
      case 'p3': return 'assets/images/satwa/maleo.jpg';
      case 'p4': return 'assets/images/lanskap/savana.jpg';
      case 'p5': return 'assets/images/satwa/elang_jawa.jpg';
      
      case 'r1': return 'assets/images/satwa/hiu_paus.jpg';
      case 'r2': return 'assets/images/satwa/komodo.jpg';
      case 'r3': return 'assets/images/satwa/harimau_sumatera.jpeg';
      
      default: return 'assets/images/lanskap/savana.jpg';
    }
  }

  // Dynamic encouraging messages based on correct count
  String _getEncouragementMessage(int correct, int total) {
    final pct = correct / total;
    if (pct == 1.0) {
      return 'Luar biasa! Kamu memiliki wawasan sempurna tentang satwa Indonesia.';
    } else if (pct >= 0.8) {
      return 'Luar biasa! Kamu semakin mengenal satwa Indonesia.';
    } else if (pct >= 0.6) {
      return 'Bagus sekali! Wawasan belajarmu tentang fauna nusantara sudah cukup matang.';
    }
    return 'Tetap semangat! Ayo belajar lagi untuk melestarikan fauna kebanggaan tanah air.';
  }

  @override
  Widget build(BuildContext context) {
    final questions = _shuffledQuestions;
    final totalQuestions = questions.length;

    if (_quizFinished) {
      return _buildResultScreen(totalQuestions);
    }

    final currentQuestion = questions[_currentQuestionIndex];
    final categoryUpper = widget.category.title.toUpperCase();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Color(0xFF28542A), size: 24),
          onPressed: () => _showExitWarningDialog(Theme.of(context)),
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
                  color: Color(0xFF28542A),
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
      body: SafeArea(
        child: Column(
          children: [
            // 1. TOP PROGRESS TRACKER (TAG & TITLE ROW & PROGRESS BAR)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upper category tag
                  Text(
                    'EKSPLORASI $categoryUpper',
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Color(0xFF8B5E3C), // Label Brown
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Title + Question number row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kuis Pengetahuan',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF212121),
                        ),
                      ),
                      Text(
                        '${_currentQuestionIndex + 1}/$totalQuestions',
                        style: const TextStyle(
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF2E6F33),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (_currentQuestionIndex + (_isAnswerSubmitted ? 1 : 0)) / totalQuestions,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFECEFF1),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)), // Blue progress
                    ),
                  ),
                ],
              ),
            ),

            // 2. QUESTION & ILLUSTRATION SCROLLABLE AREA
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Question Card (Rounded, Image on top, Text at bottom)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top Image with rounded corners & Difficulty Badge
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 160,
                                  width: double.infinity,
                                  child: Image.asset(
                                    _getQuestionIllustrationUrl(currentQuestion.originalQuestion.id),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Difficulty Badge
                                Positioned(
                                  bottom: 12,
                                  left: 16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2E6F33).withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _getDifficultyBadge(widget.category.id),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Lexend',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Bottom Question Text
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              currentQuestion.questionText,
                              style: const TextStyle(
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF212121),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 3. SELECTION OPTION LIST
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: List.generate(currentQuestion.shuffledOptions.length, (index) {
                          final optionText = currentQuestion.shuffledOptions[index];
                          final isSelected = _selectedOptionIndex == index;

                          Color cardBgColor = Colors.white;
                          Color borderColor = const Color(0xFFE0E0E0);
                          Color textColor = const Color(0xFF212121);
                          Color badgeBgColor = const Color(0xFFECEFF1);
                          Color badgeTextColor = const Color(0xFF757575);

                          Widget leadingIconOrText = Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          );

                          // High-fidelity active states matching mockup exactly
                          if (_isAnswerSubmitted) {
                            final isCorrect = index == currentQuestion.correctOptionIndex;
                            if (isCorrect) {
                              // Green Highlight for correct answer
                              cardBgColor = const Color(0xFFF1F8F2);
                              borderColor = const Color(0xFF2E6F33);
                              textColor = const Color(0xFF2E6F33);
                              badgeBgColor = const Color(0xFF2E6F33);
                              badgeTextColor = Colors.white;
                              leadingIconOrText = const Icon(Icons.check, size: 14, color: Colors.white);
                            } else if (isSelected) {
                              // Red Highlight for incorrect selected answer
                              cardBgColor = const Color(0xFFFFEBEE);
                              borderColor = const Color(0xFFC62828);
                              textColor = const Color(0xFFC62828);
                              badgeBgColor = const Color(0xFFC62828);
                              badgeTextColor = Colors.white;
                              leadingIconOrText = const Icon(Icons.close, size: 14, color: Colors.white);
                            }
                          } else if (isSelected) {
                            // Standard Selected State (Green highlight)
                            cardBgColor = const Color(0xFFF1F8F2);
                            borderColor = const Color(0xFF2E6F33);
                            textColor = const Color(0xFF2E6F33);
                            badgeBgColor = const Color(0xFF2E6F33);
                            badgeTextColor = Colors.white;
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: cardBgColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: borderColor,
                                width: isSelected || (_isAnswerSubmitted && (index == currentQuestion.correctOptionIndex || isSelected)) ? 1.8 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _isAnswerSubmitted ? null : () => _handleOptionSelect(index),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Left Circle Avatar
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: badgeBgColor,
                                          foregroundColor: badgeTextColor,
                                          child: leadingIconOrText,
                                        ),
                                        const SizedBox(width: 16),
                                        
                                        // Option Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                optionText,
                                                style: TextStyle(
                                                  fontFamily: 'Lexend',
                                                  fontSize: 14.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: textColor,
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
                        }),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // 4. FLOATING CURVED GREEN BOTTOM PANEL WITH NEXT BUTTON
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50), // Lively green background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A20), // Dark green button
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                ),
                onPressed: _selectedOptionIndex == null
                    ? null
                    : (_isAnswerSubmitted ? _nextQuestion : _submitAnswer),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isAnswerSubmitted
                          ? (_currentQuestionIndex == totalQuestions - 1 ? 'Selesaikan Kuis' : 'Pertanyaan Berikutnya')
                          : 'Kirim Jawaban',
                      style: const TextStyle(
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 5. HIGH FIDELITY END OF QUIZ SCREEN (AKHIR KUIS)
  Widget _buildResultScreen(int totalQuestions) {
    const brandGreen = Color(0xFF28542A);
    final correctRatioText = "$_correctAnswersCount/$totalQuestions";
    final pointAward = _correctAnswersCount * 300;

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
            const ProfileAvatarButton(radius: 16, borderWidth: 1.5),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    
                    // 1. HUGE CIRCULAR SCORE INDICATOR CARD
                    Center(
                      child: Container(
                        width: 250,
                        height: 250,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9), // Light green circle
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2E6F33), // Green border
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Big Ratio Text
                            Text(
                              correctRatioText,
                              style: const TextStyle(
                                fontSize: 60,
                                fontFamily: 'LilitaOne',
                                color: Color(0xFF1E3A20),
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Encouragement Subtitle
                            Text(
                              _getEncouragementMessage(_correctAnswersCount, totalQuestions),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 11.5,
                                color: Color(0xFF212121),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 2. DURATION CARD (WAKTU)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F2), // Light cream
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
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            color: Color(0xFF2E6F33),
                            size: 24,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Waktu',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Lexend',
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _durationText ?? "00:00",
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E6F33),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3. POINTS CARD (POIN)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F2), // Light cream
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
                        children: [
                          const Icon(
                            Icons.military_tech_outlined, // Medal icon
                            color: Color(0xFF1976D2), // Blue
                            size: 24,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Poin',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Lexend',
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "+$pointAward",
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 4. ACTION BUTTONS
                    // "Coba Lagi" Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A20), // Deep forest green
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                        ),
                        onPressed: () {
                          // Restart quiz
                          setState(() {
                            _currentQuestionIndex = 0;
                            _selectedOptionIndex = null;
                            _isAnswerSubmitted = false;
                            _correctAnswersCount = 0;
                            _quizFinished = false;
                            _startTime = DateTime.now(); // Reset time tracker
                            _prepareShuffledQuestions(); // Reshuffle options!
                          });
                        },
                        icon: const Icon(Icons.refresh_rounded, size: 18),
                        label: const Text(
                          'Coba Lagi',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // "Kembali ke Beranda" Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD5C6), // Soft peach orange
                          foregroundColor: const Color(0xFF8B5E3C), // Label Brown
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true); // Return back to list
                        },
                        icon: const Icon(Icons.home_outlined, size: 18),
                        label: const Text(
                          'Kembali ke Beranda',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Visual Green Wave bar
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

  void _showExitWarningDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Keluar dari Kuis?', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold)),
          content: const Text('Progres kuis yang sedang berjalan akan hilang. Yakin ingin keluar?', style: TextStyle(fontFamily: 'Lexend')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Just close dialog
              child: const Text('Batal', style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(false); // Close quiz screen
              },
              child: const Text(
                'Keluar',
                style: TextStyle(color: Color(0xFFC62828), fontFamily: 'Lexend', fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
