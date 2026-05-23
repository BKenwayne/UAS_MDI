class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  const Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      questionText: json['questionText'] as String,
      options: List<String>.from(json['options'] as Iterable),
      correctOptionIndex: json['correctOptionIndex'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
    };
  }
}

class QuizCategory {
  final String id;
  final String title;
  final String description;
  final String iconName; // e.g. 'pets', 'egg'
  final List<Question> questions;
  final String badgeName; // Badge awarded upon success (e.g., 'Sahabat Mamalia')
  final int passingScore; // Score out of 100 needed to get the badge

  const QuizCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.questions,
    required this.badgeName,
    required this.passingScore,
  });

  factory QuizCategory.fromJson(Map<String, dynamic> json) {
    return QuizCategory(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconName: json['iconName'] as String,
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q as Map<String, dynamic>))
          .toList(),
      badgeName: json['badgeName'] as String,
      passingScore: json['passingScore'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconName': iconName,
      'questions': questions.map((q) => q.toJson()).toList(),
      'badgeName': badgeName,
      'passingScore': passingScore,
    };
  }
}
